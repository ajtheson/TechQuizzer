package dao;

import dal.DBContext;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubjectDAO extends DBContext {
    public Subject getForRegister (int subjectId){
        String sql = "select [name], [thumbnail] from [subjects] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, subjectId);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                Subject subject = new Subject();
                subject.setName(rs.getString("name"));
                subject.setThumbnail(rs.getString("thumbnail"));
                subject.setId(subjectId);
                return subject;
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
}
