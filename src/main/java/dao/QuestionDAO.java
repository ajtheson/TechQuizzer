package dao;

import dal.DBContext;
import dto.QuestionDTO;
import entity.Question;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO extends DBContext {

    public List<Question> findAllByDimensionIdAndQuestionLevel(int dimensionId, int questionLevel) {
        List<Question> questions = new ArrayList<Question>();
        String sql = "select [id], [content], [media], [explaination], [question_level_id], [subject_lesson_id], [subject_dimension_id] " +
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
