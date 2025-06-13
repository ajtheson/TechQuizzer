package dao;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleDAO extends DBContext {
    public int getRoleIdByName(String name){
        String sql = "select [id] from [roles] where [name] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, name);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getInt("id");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public String getRoleNameById(int id){
        String sql = "select [name] from [roles] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return "";
    }
}
