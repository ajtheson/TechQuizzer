package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import dal.DBContext;
import dto.RegistrationDTO;
import entity.PricePackage;
import entity.Registration;
import entity.Subject;

public class RegistrationDAO extends DBContext {
    public boolean addRegistration(Registration registration) {
        String sql = "insert into [registrations] ([time], [total_cost], [duration], [valid_from], [valid_to], [status], " +
                "[price_package_id], [user_id]) values (?,?,?,?,?,?,?,?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setObject(1, registration.getTime());
            pstm.setDouble(2, registration.getTotalCost());
            pstm.setObject(3, registration.getDuration());
            pstm.setObject(4, registration.getValidFrom());
            pstm.setObject(5, registration.getValidTo());
            pstm.setString(6, registration.getStatus());
            pstm.setInt(7, registration.getPricePackageId());
            pstm.setInt(8, registration.getUserId());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public List<RegistrationDTO> getRegistrationListOfUser(int userID) {
        List<RegistrationDTO> list = new ArrayList<>();
        String sql = "select * from [registrations] where [user_id] = ? order by [time] desc";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, userID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                RegistrationDTO r = new RegistrationDTO();
                r.setId(rs.getInt("id"));

                Timestamp timeTs = rs.getTimestamp("time");
                if (timeTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");
                    r.setTime(timeTs.toLocalDateTime().format(formatter));
                } else {
                    r.setTime(null);
                }

                r.setTotalCost(rs.getDouble("total_cost"));

                r.setDuration(rs.getObject("duration", Integer.class));

                Timestamp validFromTs = rs.getTimestamp("valid_from");
                if (validFromTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidFrom(validFromTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidFrom(null);
                }

                Timestamp validToTs = rs.getTimestamp("valid_to");
                if (validToTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidTo(validToTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidTo(null);
                }

                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));

                PricePackageDAO pDAO = new PricePackageDAO();
                PricePackage p = pDAO.get(rs.getInt("price_package_id"));
                r.setPricePackage(p);

                SubjectDAO sDAO = new SubjectDAO();
                r.setSubject(sDAO.getForUserRegistration(p.getSubjectId()));

                list.add(r);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public boolean changeStatus(int id, String status) {
        String sql = "update [registrations] set status = ? where id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public int getSubjectId(int registrationID) {
        String sql = "select p.[subject_id] from [registrations] r join [price_packages] p on r.price_package_id = p.id where r.[id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, registrationID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return rs.getInt("subject_id");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public int getPricePackageId(int registrationID) {
        String sql = "select [price_package_id] from [registrations] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, registrationID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return rs.getInt("price_package_id");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public boolean userModifyRegistration(LocalDateTime time, double totalCost, Integer duration, int pricePackageId, int id) {
        String sql = "update [registrations] set [time] = ?, [total_cost] = ?, [duration] = ?, [price_package_id] = ? where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setObject(1, time);
            pstm.setDouble(2, totalCost);
            pstm.setObject(3, duration);
            pstm.setInt(4, pricePackageId);
            pstm.setInt(5, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean isRegistrationExist(int userID, int subjectID) {
        String sql = """
                SELECT 1
                FROM registrations r JOIN price_packages p
                ON r.price_package_id = p.id
                WHERE r.user_id = ? AND p.subject_id = ? AND r.status IN ('Paid', 'Pending Confirmation', 'Pending Payment')
                """;
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, userID);
            pstm.setInt(2, subjectID);
            if (pstm.executeQuery().next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public List<RegistrationDTO> findAllByUserID(int userID) throws SQLException {
        List<RegistrationDTO> registrations = new ArrayList<>();
        String sql = "select r.*, s.[id] as sId, s.[name] " +
                "from [registrations] r " +
                "join [price_packages] p on r.price_package_id = p.id " +
                "join [subjects] s on s.id = p.subject_id " +
                "where [user_id] = ? AND r.[status] = 'Paid'";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, userID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                RegistrationDTO registrationDTO = new RegistrationDTO();
                registrationDTO.setId(rs.getInt("id"));
                Subject subject = new Subject();
                subject.setId(rs.getInt("sId"));
                subject.setName(rs.getString("name"));
                registrationDTO.setSubject(subject);
                registrations.add(registrationDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public List<RegistrationDTO> getAllRegistrations() {
        String sql = "select * from [registrations]";
        List<RegistrationDTO> registrations = new ArrayList<>();
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                RegistrationDTO r = new RegistrationDTO();
                r.setId(rs.getInt("id"));

                Timestamp timeTs = rs.getTimestamp("time");
                if (timeTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");
                    r.setTime(timeTs.toLocalDateTime().format(formatter));
                } else {
                    r.setTime(null);
                }

                r.setTotalCost(rs.getDouble("total_cost"));

                r.setDuration(rs.getObject("duration", Integer.class));

                Timestamp validFromTs = rs.getTimestamp("valid_from");
                if (validFromTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidFrom(validFromTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidFrom(null);
                }

                Timestamp validToTs = rs.getTimestamp("valid_to");
                if (validToTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidTo(validToTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidTo(null);
                }

                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));

                PricePackageDAO pDAO = new PricePackageDAO();
                PricePackage p = pDAO.get(rs.getInt("price_package_id"));
                r.setPricePackage(p);

                SubjectDAO sDAO = new SubjectDAO();
                r.setSubject(sDAO.getForUserRegistration(p.getSubjectId()));

                UserDAO uDAO = new UserDAO();
                r.setUser(uDAO.getForSale(rs.getInt("user_id")));
                r.setLastUpdatedBy(uDAO.getForSale(rs.getInt("last_updated_by")));

                registrations.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    public RegistrationDTO getById(Integer id) {
        String sql = "select * from [registrations] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                RegistrationDTO r = new RegistrationDTO();
                r.setId(rs.getInt("id"));

                Timestamp timeTs = rs.getTimestamp("time");
                if (timeTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");
                    r.setTime(timeTs.toLocalDateTime().format(formatter));
                } else {
                    r.setTime(null);
                }

                r.setTotalCost(rs.getDouble("total_cost"));

                r.setDuration(rs.getObject("duration", Integer.class));

                Timestamp validFromTs = rs.getTimestamp("valid_from");
                if (validFromTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidFrom(validFromTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidFrom(null);
                }

                Timestamp validToTs = rs.getTimestamp("valid_to");
                if (validToTs != null) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    r.setValidTo(validToTs.toLocalDateTime().format(formatter));
                } else {
                    r.setValidTo(null);
                }

                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));

                PricePackageDAO pDAO = new PricePackageDAO();
                PricePackage p = pDAO.get(rs.getInt("price_package_id"));
                r.setPricePackage(p);

                SubjectDAO sDAO = new SubjectDAO();
                r.setSubject(sDAO.getForUserRegistration(p.getSubjectId()));

                UserDAO uDAO = new UserDAO();
                r.setUser(uDAO.getForSale(rs.getInt("user_id")));
                r.setLastUpdatedBy(uDAO.getForSale(rs.getInt("last_updated_by")));

                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateRegistration(Registration r) {
        String sql = "update [registrations] set [status] = ?, [valid_from] = ?, [valid_to] = ?, [note] = ?, [last_updated_by] = ? where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, r.getStatus());
            pstm.setObject(2, r.getValidFrom());
            pstm.setObject(3, r.getValidTo());
            pstm.setString(4, r.getNote());
            pstm.setObject(5, r.getLastUpdatedBy());
            pstm.setInt(6, r.getId());
            pstm.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteTempRegistration(Integer id) {
        String sql = "delete from [registrations] where [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean createRegistrationBySale(Registration registration) {
        String sql = "insert into [registrations] ([time], [total_cost], [duration], [valid_from], [valid_to], [status], " +
                "[note], [price_package_id], [user_id], [last_updated_by]) values (?,?,?,?,?,?,?,?,?,?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setObject(1, registration.getTime());
            pstm.setDouble(2, registration.getTotalCost());
            pstm.setObject(3, registration.getDuration());
            pstm.setObject(4, registration.getValidFrom());
            pstm.setObject(5, registration.getValidTo());
            pstm.setString(6, registration.getStatus());
            pstm.setString(7, registration.getNote());
            pstm.setInt(8, registration.getPricePackageId());
            pstm.setInt(9, registration.getUserId());
            pstm.setInt(10, registration.getLastUpdatedBy());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;

    }

    //Return true when the registration valid
    //False when the registration is expired
    public boolean isRegistrationValid(int userId, int subjectId){
        String sql = """
                select r.valid_to
                from registrations r join price_packages p on r.price_package_id = p.id
                where r.user_id = ? and p.subject_id = ?
                """;
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, userId);
            pstm.setInt(2, subjectId);
            ResultSet rs = pstm.executeQuery();
            Timestamp currentTime = Timestamp.valueOf(LocalDateTime.now());
            while (rs.next()) {
                Timestamp validToTime = rs.getTimestamp("valid_to");
                if(validToTime == null || validToTime.after(currentTime)){
                    return true;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
}
