package dao;

import dal.DBContext;
import entity.Category;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO  extends DBContext {
    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "select [id], [name] from [subject_categories] where [status] = 1";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                list.add(category);
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public String getCategoryNameById(int id){
        String sql = "select [name] from [subject_categories] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
}
