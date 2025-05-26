package dao;

import dal.DBContext;
import dto.UserLoginDTO;


import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO extends DBContext {
    public UserLoginDTO getUserByEmail(String email) {

        try {
            String sql = "SELECT * FROM Users WHERE Email = ? AND status = 1 AND activate = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return new UserLoginDTO(

                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getBoolean("status"),
                        rs.getBoolean("activate"),
                        rs.getInt("role_id")

                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
