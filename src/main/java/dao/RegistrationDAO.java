package dao;

import dal.DBContext;
import dto.RegistrationDTO;
import entity.PricePackage;
import entity.Registration;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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


    public List<RegistrationDTO> findAllByUserID(int userID) throws SQLException {
        List<RegistrationDTO> registrations = new ArrayList<>();
        String sql = "select r.*, s.[id] as sId, s.[name] " +
                "from [registrations] r " +
                "join [price_packages] p on r.price_package_id = p.id " +
                "join [subjects] s on s.id = p.subject_id " +
                "where [user_id] = ? AND r.[status] = 'Paid'";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, userID);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()){
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

}
