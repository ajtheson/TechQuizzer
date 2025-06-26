package dao;

import dal.DBContext;
import entity.Question;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO extends DBContext {

    public List<Question> findAllByDimensionIdAndQuestionLevel(int dimensionId, int questionLevel) {
        List<Question> questions = new ArrayList<Question>();
        String sql = "select [id], [content], [explaination], [question_level_id], [subject_lesson_id], [subject_dimension_id] " +
                "from [questions] where [subject_dimension_id] = ? and [question_level_id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, dimensionId);
            pstm.setInt(2, questionLevel);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setContent(rs.getString("content"));
                question.setExplaination(rs.getString("explaination"));
                question.setQuestionLevelId(rs.getInt("question_level_id"));
                question.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                question.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                questions.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    public int create(Question q) throws Exception {
        String sql = "INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setString(1, q.getContent());
            stm.setString(2, q.getExplaination());
            stm.setString(3, q.getQuestionFormat());
            stm.setInt(4, q.getQuestionLevelId());

            if (q.getSubjectLessonId() == null || q.getSubjectLessonId() == 0) {
                stm.setNull(5, java.sql.Types.INTEGER);
            } else {
                stm.setInt(5, q.getSubjectLessonId());
            }

            if (q.getSubjectDimensionId() == null || q.getSubjectDimensionId() == 0) {
                stm.setNull(6, java.sql.Types.INTEGER);
            } else {
                stm.setInt(6, q.getSubjectDimensionId());
            }

            stm.setBoolean(7, q.isStatus());

            stm.executeUpdate();

            try (var rs = stm.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public Question findById(int id) throws Exception {
        String sql = "SELECT * FROM questions WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setContent(rs.getString("content"));
                    q.setExplaination(rs.getString("explaination"));
                    q.setQuestionFormat(rs.getString("question_format"));
                    q.setStatus(rs.getBoolean("status"));
                    q.setDeleted(rs.getBoolean("is_deleted"));
                    q.setQuestionLevelId((Integer) rs.getObject("question_level_id"));
                    q.setSubjectLessonId((Integer) rs.getObject("subject_lesson_id"));
                    q.setSubjectDimensionId((Integer) rs.getObject("subject_dimension_id"));
                    return q;
                }
            }catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
        return null;
    }

    public boolean toggleStatus(int id, boolean status) throws Exception {
        String sql = "UPDATE questions SET [status] = ? WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
            return true;
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }
        return false;
    }

    public void markAsDeleted(int questionId) throws Exception {
        String sql = "UPDATE questions SET is_deleted = 1 WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            stm.executeUpdate();
        }
    }

    public Integer findSubjectIdByQuestionId(int questionId) {
        String query = """
        SELECT 
            COALESCE(l.subject_id, d.subject_id) AS subject_id
        FROM questions q
        LEFT JOIN lessons l ON q.subject_lesson_id = l.id
        LEFT JOIN dimensions d ON q.subject_dimension_id = d.id
        WHERE q.id = ?
    """;

        try (
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("subject_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


}
