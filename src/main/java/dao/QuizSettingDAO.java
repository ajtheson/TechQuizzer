package dao;

import dal.DBContext;
import entity.QuizSetting;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class QuizSettingDAO extends DBContext {

    public QuizSetting findById(int id) {
        String sql = """
                SELECT
                    [number_question],
                    [question_type]
                FROM [quiz_settings] where id=?
            """;
        try{
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()) {
                QuizSetting quizSetting = new QuizSetting();
                quizSetting.setId(id);
                quizSetting.setNumberOfQuestions(rs.getInt("number_question"));
                quizSetting.setQuestionType(rs.getString("question_type"));
                return quizSetting;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<QuizSetting> findByIds(List<Integer> ids) {
        List<QuizSetting> quizSettings = new ArrayList<>();
        if(ids == null || ids.isEmpty()) {
            return quizSettings;
        }
        String inClause = ids.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "SELECT [id], [number_question], [question_type] FROM [quiz_settings] WHERE id IN (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            for(Integer id : ids) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while(rs.next()) {
                QuizSetting quizSetting = new QuizSetting();
                quizSetting.setId(rs.getInt("id"));
                quizSetting.setNumberOfQuestions(rs.getInt("number_question"));
                quizSetting.setQuestionType(rs.getString("question_type"));
                quizSettings.add(quizSetting);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return quizSettings;
    }

}
