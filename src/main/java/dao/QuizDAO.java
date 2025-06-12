package dao;

import dal.DBContext;
import dto.QuizDTO;
import entity.QuizSetting;
import entity.Subject;
import entity.TestType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class QuizDAO extends DBContext {

    public List<QuizDTO> getQuizzesByPage(String subjectName, String testTypeName, String searchText,
                                          int page, int pageSize, String sortField, String sortOrder, int expertId) {
        List<QuizDTO> quizzes = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT q.id, q.name, q.level, q.duration, q.pass_rate, q.status, " +
                        "s.id AS subject_id, s.name AS subject_name, " +
                        "t.id AS test_type_id, t.name AS test_type_name " +
                        "FROM quizzes q " +
                        "JOIN subjects s ON q.subject_id = s.id " +
                        "JOIN test_types t ON q.test_type_id = t.id " +
                        "LEFT JOIN quiz_settings qs ON q.quiz_setting_id = qs.id " +
                        "WHERE s.owner_id = ?"
        );

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (testTypeName != null && !testTypeName.isEmpty()) {
            sql.append(" AND t.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND q.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("q.name", "q.level", "q.duration", "q.pass_rate", "q.id", "s.name", "t.name");
        if (!validSortFields.contains(sortField)) sortField = "q.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC")) sortOrder = "ASC";

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            pstm.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                pstm.setString(paramIndex++, "%" + subjectName + "%");

            if (testTypeName != null && !testTypeName.isEmpty())
                pstm.setString(paramIndex++, "%" + testTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                pstm.setString(paramIndex++, "%" + searchText + "%");

            pstm.setInt(paramIndex++, offset);
            pstm.setInt(paramIndex, pageSize);

            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                QuizDTO dto = new QuizDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setLevel(rs.getString("level"));
                dto.setDuration(rs.getInt("duration"));
                dto.setPassRate(rs.getInt("pass_rate"));
                dto.setPublished(rs.getBoolean("status"));

                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                subject.setName(rs.getString("subject_name"));
                dto.setSubject(subject);

                TestType testType = new TestType();
                testType.setId(rs.getInt("test_type_id"));
                testType.setName(rs.getString("test_type_name"));
                dto.setTestType(testType);


                quizzes.add(dto);
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return quizzes;
    }

    public int getTotalQuizzes(String subjectName, String testTypeName, String searchText, int expertId) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total FROM quizzes q " +
                        "JOIN subjects s ON q.subject_id = s.id " +
                        "JOIN test_types t ON q.test_type_id = t.id " +
                        "WHERE s.owner_id = ?"
        );

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (testTypeName != null && !testTypeName.isEmpty()) {
            sql.append(" AND t.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND q.name LIKE ?");
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            pstm.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                pstm.setString(paramIndex++, "%" + subjectName + "%");

            if (testTypeName != null && !testTypeName.isEmpty())
                pstm.setString(paramIndex++, "%" + testTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                pstm.setString(paramIndex++, "%" + searchText + "%");

            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return 0;
    }

    public boolean changeQuizStatus(int id, boolean status) {
        String sql = "UPDATE quizzes SET status = ? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setBoolean(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return false;
    }
}
