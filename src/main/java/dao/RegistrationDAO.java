package dao;

import dal.DBContext;
import dto.RegistrationDTO;
import entity.PricePackage;
import entity.Registration;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO extends DBContext {
    public boolean addRegistration(Registration registration) {
        String sql = "insert into [registrations] ([time], [total_cost], [valid_from], [valid_to], [status], " +
                "[price_package_id], [user_id]) values (?,?,?,?,?,?,?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setObject(1, registration.getTime());
            pstm.setDouble(2, registration.getTotalCost());
            pstm.setObject(3, registration.getValidFrom());
            pstm.setObject(4, registration.getValidTo());
            pstm.setString(5, registration.getStatus());
            pstm.setInt(6, registration.getPricePackageId());
            pstm.setInt(7, registration.getUserId());
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public List<RegistrationDTO> getRegistrationListOfUser(int userID){
        List<RegistrationDTO> list = new ArrayList<>();
        String sql = "select * from [registrations] where [user_id] = ? order by [status] desc, [time] desc";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, userID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()){
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
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public boolean changeStatus(int id, String status){
        String sql = "update [registrations] set status = ? where id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public int getSubjectId(int registrationID){
        String sql = "select p.[subject_id] from [registrations] r join [price_packages] p on r.price_package_id = p.id where r.[id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, registrationID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()){
                return rs.getInt("subject_id");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public int getPricePackageId(int registrationID){
        String sql = "select [price_package_id] from [registrations] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, registrationID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()){
                return rs.getInt("price_package_id");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public boolean userModifyRegistration(LocalDateTime time, double totalCost, int pricePackageId, int id){
        String sql = "update [registrations] set [time] = ?, [total_cost] = ?, [price_package_id] = ? where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setObject(1, time);
            pstm.setDouble(2, totalCost);
            pstm.setInt(3, pricePackageId);
            pstm.setInt(4, id);
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean isRegistrationExist(int userID, int subjectID){
        String sql = """
                SELECT 1
                FROM registrations r JOIN price_packages p
                ON r.price_package_id = p.id
                WHERE r.user_id = ? AND p.subject_id = ? AND r.status = 'Paid'
                """;
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, userID);
            pstm.setInt(2, subjectID);
            if(pstm.executeQuery().next()){
                return true;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
}
