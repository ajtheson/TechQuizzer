package dao;

import dal.DBContext;
import entity.QuestionLevel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuestionLevelDAO extends DBContext {

    public QuestionLevel findById(int id) {
        String sql = "select * from [question_levels] where id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                QuestionLevel questionLevel = new QuestionLevel();
                questionLevel.setId(id);
                questionLevel.setName(rs.getString("name"));
                return questionLevel;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<QuestionLevel> findAll() {
        List<QuestionLevel> questionLevels = new ArrayList<QuestionLevel>();
        String sql = "select [id], [name] from [question_levels]";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                QuestionLevel questionLevel = new QuestionLevel();
                questionLevel.setId(rs.getInt("id"));
                questionLevel.setName(rs.getString("name"));
                questionLevels.add(questionLevel);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return questionLevels;
    }
}
