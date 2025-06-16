package dao;

import dal.DBContext;
import entity.QuizSetting;
import entity.QuizSettingGroup;
import entity.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class QuizSettingDAO extends DBContext {
    public int createQuizSetting(QuizSetting quizSetting) throws SQLException {
        String sql = "INSERT INTO [quiz_settings] ([number_question], [question_type]) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, quizSetting.getNumberOfQuestions());
            ps.setString(2, quizSetting.getQuestionType());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating quiz setting failed, no rows affected.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating quiz setting failed, no ID obtained.");
                }
            }
        }
    }
    
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
    public boolean updateQuizSetting(int id, int numberOfQuestion ) {
        String sql = "UPDATE [quiz_settings] SET [number_question] = ? WHERE [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, numberOfQuestion);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating subject name: " + e.getMessage());
        }
        return false;
    }
    public List<QuizSettingGroup> listLessonQuestion(int quizSettingId) {
        String sql = """
            SELECT 
                qsg.id,
                qsg.subject_lesson_id,
                SUM(qsg.number_question) AS total_questions,
                qsg.quiz_setting_id
            FROM 
                quiz_setting_groups qsg
            JOIN 
                quiz_settings qs ON qs.id = qsg.quiz_setting_id
            WHERE 
                qs.id = ? AND qsg.subject_lesson_id IS NOT NULL
            GROUP BY 
                qsg.subject_lesson_id, qsg.id, qsg.quiz_setting_id
            """;

        List<QuizSettingGroup> result = new ArrayList<>();

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizSettingId);

            try (ResultSet rs = pstm.executeQuery()) {
                while (rs.next()) {
                    QuizSettingGroup group = new QuizSettingGroup();
                    group.setId(rs.getInt("id"));
                    group.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                    group.setNumberQuestion(rs.getInt("total_questions"));
                    group.setQuizSettingId(rs.getInt("quiz_setting_id"));
                    group.setSubjectDimensionId(null); // lesson group không có dimension

                    result.add(group);
                }
            }
        } catch (Exception e) {
            System.out.println("Error listLessonQuestion: " + e.getMessage());
        }
        return result;
    }

    public List<QuizSettingGroup> listDimensionQuestion(int quizSettingId) {
        String sql = """
            SELECT 
                qsg.id,
                qsg.subject_dimension_id,
                SUM(qsg.number_question) AS total_questions,
                qsg.quiz_setting_id
            FROM 
                quiz_setting_groups qsg
            JOIN 
                quiz_settings qs ON qs.id = qsg.quiz_setting_id
            WHERE 
                qs.id = ? AND qsg.subject_dimension_id IS NOT NULL
            GROUP BY 
                qsg.subject_dimension_id, qsg.id, qsg.quiz_setting_id
            """;

        List<QuizSettingGroup> result = new ArrayList<>();

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizSettingId);

            try (ResultSet rs = pstm.executeQuery()) {
                while (rs.next()) {
                    QuizSettingGroup group = new QuizSettingGroup();
                    group.setId(rs.getInt("id"));
                    group.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                    group.setNumberQuestion(rs.getInt("total_questions"));
                    group.setQuizSettingId(rs.getInt("quiz_setting_id"));
                    group.setSubjectLessonId(null); // dimension group không có lesson

                    result.add(group);
                }
            }
        } catch (Exception e) {
            System.out.println("Error listDimensionQuestion: " + e.getMessage());
        }
        return result;
    }
    public int getQuizSettingIdByQuizId(int quizId) {
        String sql = """
        SELECT qs.id 
        FROM quiz_settings qs
        JOIN quizzes q ON q.quiz_setting_id = qs.id
        WHERE q.id = ?
        """;

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizId);

            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (Exception e) {
            System.out.println("Error getQuizSettingIdByQuizId: " + e.getMessage());
        }
        return -1;
    }
}
