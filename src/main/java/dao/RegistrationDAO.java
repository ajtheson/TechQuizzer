package dao;

import dal.DBContext;
import entity.Registration;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

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
}
