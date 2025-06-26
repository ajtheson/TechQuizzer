package dao;

import dal.DBContext;
import dto.QuestionDTO;
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

    public List<QuestionDTO> findQuestionWithPagination(int page, int size, int subjectId, int dimensionId, int lessonId, int levelId, String status, String search, int ownerId) {
        List<QuestionDTO> questions = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                SELECT q.id, q.content, q.explaination, q.status, q.question_level_id, ql.name AS question_level_name, q.subject_lesson_id, l.name AS subject_lesson_name, q.subject_dimension_id, d.name AS subject_dimension_name, l.subject_id, s.name AS subject_name
                FROM [questions] q JOIN [lessons] l on q.subject_lesson_id = l.id
                JOIN [dimensions] d on q.subject_dimension_id = d.id
                JOIN [question_levels] ql on q.question_level_id = ql.id
                JOIN [subjects] s on l.subject_id = s.id
                WHERE 1=1 AND q.is_deleted = 0
                """);
        if (subjectId != 0) {
            sql.append(" AND l.subject_id = ?");
        }
        if (dimensionId != 0) {
            sql.append(" AND q.subject_dimension_id = ?");
        }
        if (lessonId != 0) {
            sql.append(" AND q.subject_lesson_id = ?");
        }
        if (levelId != 0) {
            sql.append(" AND q.question_level_id = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND q.status = ").append(status.equalsIgnoreCase("Show") ? "1" : "0");
        }
        if (search != null && !search.isEmpty()) {
            sql.append(" AND q.content LIKE ?");
        }
        if (ownerId != 0) {
            sql.append(" AND s.owner_id = ?");
        }
        sql.append(" ORDER BY [id]");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (subjectId != 0) {
                pstm.setInt(paramIndex++, subjectId);
            }
            if (dimensionId != 0) {
                pstm.setInt(paramIndex++, dimensionId);
            }
            if (lessonId != 0) {
                pstm.setInt(paramIndex++, lessonId);
            }
            if (levelId != 0) {
                pstm.setInt(paramIndex++, levelId);
            }
            if (search != null && !search.isEmpty()) {
                pstm.setString(paramIndex++, "%" + search + "%");
            }
            if (ownerId != 0) {
                pstm.setInt(paramIndex++, ownerId);
            }
            pstm.setInt(paramIndex++, (page - 1) * size);
            pstm.setInt(paramIndex, size);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                QuestionDTO question = new QuestionDTO();
                question.setId(rs.getInt("id"));
                question.setContent(rs.getString("content"));
                question.setExplaination(rs.getString("explaination"));
                question.setStatus(rs.getBoolean("status"));
                question.setQuestionLevelId(rs.getInt("question_level_id"));
                question.setQuestionLevelName(rs.getString("question_level_name"));
                question.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                question.setSubjectLessonName(rs.getString("subject_lesson_name"));
                question.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                question.setQuestionDimensionName(rs.getString("subject_dimension_name"));
                question.setSubjectId(rs.getInt("subject_id"));
                question.setSubjectName(rs.getString("subject_name"));
                questions.add(question);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
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


    public int getTotalQuestion(int subjectId, int dimensionId, int lessonId, int levelId, String status, String search, int ownerId) {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*)
                FROM [questions] q JOIN [lessons] l on q.subject_lesson_id = l.id
                JOIN [subjects] s on l.subject_id = s.id
                WHERE 1=1 AND q.is_deleted = 0
                """);
        if (subjectId != 0) {
            sql.append(" AND l.subject_id = ?");
        }
        if (dimensionId != 0) {
            sql.append(" AND q.subject_dimension_id = ?");
        }
        if (lessonId != 0) {
            sql.append(" AND q.subject_lesson_id = ?");
        }
        if (levelId != 0) {
            sql.append(" AND q.question_level_id = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND q.status = ").append(status.equalsIgnoreCase("Show") ? "1" : "0");
        }
        if (search != null && !search.isEmpty()) {
            sql.append(" AND q.content LIKE ?");
        }
        if (ownerId != 0) {
            sql.append(" AND s.owner_id = ?");
        }
        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (subjectId != 0) {
                pstm.setInt(paramIndex++, subjectId);
            }
            if (dimensionId != 0) {
                pstm.setInt(paramIndex++, dimensionId);
            }
            if (lessonId != 0) {
                pstm.setInt(paramIndex++, lessonId);
            }
            if (levelId != 0) {
                pstm.setInt(paramIndex++, levelId);
            }
            if (search != null && !search.isEmpty()) {
                pstm.setString(paramIndex++, "%" + search + "%");
            }
            if (ownerId != 0) {
                pstm.setInt(paramIndex++, ownerId);
            }
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return 0;
    }

    public boolean updateStatus(int id, boolean status){
        String sql = """
                UPDATE [questions]
                SET [status] = ?
                WHERE [id] = ?
        """;
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, status ? 1 : 0);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {}
        return false;
    }
}
