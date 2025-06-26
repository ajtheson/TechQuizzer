package dao;

import dal.DBContext;
import entity.QuestionMedia;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionMediaDAO extends DBContext {
    public void insert(QuestionMedia media) throws Exception {
        String sql = "INSERT INTO question_medias ([type], [link], [description], [question_id]) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, media.getType());
            stm.setString(2, media.getLink());
            stm.setString(3, media.getDescription());
            stm.setInt(4, media.getQuestionId());
            stm.executeUpdate();
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }
    }

    public List<QuestionMedia> findByQuestionId(int questionId) throws Exception {
        List<QuestionMedia> list = new ArrayList<>();
        String sql = "SELECT * FROM question_medias WHERE question_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    QuestionMedia m = new QuestionMedia();
                    m.setId(rs.getInt("id"));
                    m.setType(rs.getString("type"));
                    m.setLink(rs.getString("link"));
                    m.setDescription(rs.getString("description"));
                    m.setQuestionId(rs.getInt("question_id"));
                    list.add(m);
                }
            }
        }
        return list;
    }

    public QuestionMedia findById(int id) {
        String sql = "SELECT * FROM question_medias WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    QuestionMedia m = new QuestionMedia();
                    m.setId(rs.getInt("id"));
                    m.setType(rs.getString("type"));
                    m.setLink(rs.getString("link"));
                    m.setDescription(rs.getString("description"));
                    m.setQuestionId(rs.getInt("question_id"));
                    return m;
                }
            }
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }
        return null;
    }

}