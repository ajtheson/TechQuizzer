package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import dal.DBContext;
import dto.LessonDTO;
import dto.QuizDTO;
import entity.*;

public class QuizDAO extends DBContext {
    public boolean hasExamAttempt(int quizId) throws SQLException {
        String sql = "SELECT 1 FROM exam_attempts WHERE quiz_id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizId);
            try (ResultSet rs = pstm.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public QuizDTO findByQuizId(int id) {
        String sql = "SELECT q.id, q.name as quiz_name, q.subject_id,q.format, q.test_type_id, q.quiz_setting_id, q.question_level_id, "
                +
                "s.name as subject_name, ql.name as question_level_name, qs.number_question, q.duration, q.pass_rate, "
                +
                "q.status, tt.name as test_type_name " +
                "FROM [quizzes] q " +
                "LEFT JOIN [subjects] s ON q.subject_id = s.id " +
                "LEFT JOIN [test_types] tt ON q.test_type_id = tt.id " +
                "LEFT JOIN [quiz_settings] qs ON q.quiz_setting_id = qs.id " +
                "LEFT JOIN [question_levels] ql ON q.question_level_id = ql.id " +
                "WHERE q.id = ?";

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    QuizDTO quizDTO = new QuizDTO();
                    quizDTO.setId(id);
                    quizDTO.setName(rs.getString("quiz_name"));
                    quizDTO.setDuration(rs.getInt("duration"));
                    quizDTO.setPassRate(rs.getInt("pass_rate"));
                    quizDTO.setStatus(rs.getInt("status"));
                    quizDTO.setFormat(rs.getString("format"));
                    Subject subject = new Subject();
                    subject.setId(rs.getInt("subject_id"));
                    subject.setName(rs.getString("subject_name"));
                    quizDTO.setSubject(subject);

                    TestType testType = new TestType();
                    testType.setId(rs.getInt("test_type_id"));
                    testType.setName(rs.getString("test_type_name"));
                    quizDTO.setTestType(testType);

                    QuizSetting quizSetting = new QuizSetting();
                    quizSetting.setId(rs.getInt("quiz_setting_id"));
                    quizSetting.setNumberOfQuestions(rs.getInt("number_question"));
                    quizDTO.setQuizSetting(quizSetting);

                    QuestionLevel questionLevel = new QuestionLevel();
                    questionLevel.setId(rs.getInt("question_level_id"));
                    questionLevel.setName(rs.getString("question_level_name"));
                    quizDTO.setQuestionLevel(questionLevel);

                    return quizDTO;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<QuizDTO> getQuizzesByPage(String subjectName, String testTypeName, String searchText,
            int page, int pageSize, String sortField, String sortOrder, int expertId) {
        List<QuizDTO> quizzes = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT q.id, q.name, q.question_level_id, qs.number_question, q.duration, q.pass_rate, q.status, q.quiz_setting_id, "
                        +
                        "s.id AS subject_id, s.name AS subject_name, " +
                        "t.id AS test_type_id, t.name AS test_type_name, " +
                        "ql.name AS question_level_name " +
                        "FROM quizzes q " +
                        "JOIN subjects s ON q.subject_id = s.id " +
                        "JOIN test_types t ON q.test_type_id = t.id " +
                        "LEFT JOIN quiz_settings qs ON q.quiz_setting_id = qs.id " +
                        "LEFT JOIN question_levels ql ON q.question_level_id = ql.id " +
                        "WHERE s.owner_id = ?");

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (testTypeName != null && !testTypeName.isEmpty()) {
            sql.append(" AND t.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND q.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("q.name", "q.question_level_id", "q.duration", "q.pass_rate",
                "q.id", "s.name", "t.name", "qs.number_question");
        if (!validSortFields.contains(sortField))
            sortField = "q.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC"))
            sortOrder = "ASC";

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

                QuestionLevel questionLevel = new QuestionLevel();
                questionLevel.setId(rs.getInt("question_level_id"));
                questionLevel.setName(rs.getString("question_level_name"));
                dto.setQuestionLevel(questionLevel);

                dto.setDuration(rs.getInt("duration"));
                dto.setPassRate(rs.getInt("pass_rate"));
                dto.setStatus(rs.getInt("status"));

                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                subject.setName(rs.getString("subject_name"));
                dto.setSubject(subject);

                TestType testType = new TestType();
                testType.setId(rs.getInt("test_type_id"));
                testType.setName(rs.getString("test_type_name"));
                dto.setTestType(testType);

                QuizSetting quizSetting = new QuizSetting();
                quizSetting.setId(rs.getInt("quiz_setting_id"));
                quizSetting.setNumberOfQuestions(rs.getInt("number_question"));
                dto.setQuizSetting(quizSetting);

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
                        "LEFT JOIN quiz_settings qs ON q.quiz_setting_id = qs.id " +
                        "WHERE s.owner_id = ?");

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

    public boolean changeQuizStatus(int id, int status) {
        String sql = "UPDATE [quizzes] SET status = ? WHERE id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return false;
    }

    public Quiz findById(int id) {
        String sql = "SELECT [format],  [name], [question_level_id], [duration], [pass_rate], [description], [test_type_id], [quiz_setting_id], [subject_id] FROM [quizzes] WHERE [id] = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, id);
            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(id);
                    quiz.setFormat(rs.getString("format"));
                    quiz.setName(rs.getString("name"));
                    quiz.setQuestionLevelId(rs.getInt("question_level_id"));
                    quiz.setDuration(rs.getInt("duration"));
                    quiz.setPassRate(rs.getInt("pass_rate"));
                    quiz.setDescription(rs.getString("description"));
                    quiz.setTestTypeId(rs.getInt("test_type_id"));
                    quiz.setQuizSettingId(rs.getInt("quiz_setting_id"));
                    quiz.setSubjectId(rs.getInt("subject_id"));
                    return quiz;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Quiz> findAllByTestTypeIdAndSubjectIdsWithPagination(int testTypeId, List<Integer> subjectIds, int page,
            int size, String search) throws SQLException {
        ArrayList<Quiz> quizzes = new ArrayList<>();
        if (subjectIds == null || subjectIds.isEmpty()) {
            return quizzes;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT [id], [name], [question_level_id], [duration], [pass_rate], [description], [test_type_id], [quiz_setting_id], [subject_id] "
                + "FROM [quizzes] "
                + "WHERE [status] = 1 AND [test_type_id] = ? AND [subject_id] IN (" + inClause + ") AND [name] LIKE ? "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            int index = 1;
            pstm.setInt(index++, testTypeId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            pstm.setString(index++, "%" + search + "%");
            pstm.setInt(index++, (page - 1) * size);
            pstm.setInt(index, size);

            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setName(rs.getString("name"));
                quiz.setQuestionLevelId(rs.getInt("question_level_id"));
                quiz.setDuration(rs.getInt("duration"));
                quiz.setPassRate(rs.getInt("pass_rate"));
                quiz.setDescription(rs.getString("description"));
                quiz.setTestTypeId(rs.getInt("test_type_id"));
                quiz.setQuizSettingId(rs.getInt("quiz_setting_id"));
                quiz.setSubjectId(rs.getInt("subject_id"));
                quizzes.add(quiz);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    public int countByTestTypeIdAndSubjectIds(int testTypeId, List<Integer> subjectIds, String search)
            throws SQLException {
        if (subjectIds == null || subjectIds.isEmpty()) {
            return 0;
        }
        String inClause = subjectIds.stream().map(id -> "?").collect(Collectors.joining(", "));
        String sql = "SELECT COUNT(*) FROM [quizzes] WHERE [status] = 1 AND [test_type_id] = ? AND [subject_id] IN ("
                + inClause + ") AND [name] LIKE ? ";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            int index = 1;
            pstm.setInt(index++, testTypeId);
            for (Integer id : subjectIds) {
                pstm.setInt(index++, id);
            }
            pstm.setString(index, "%" + search + "%");
            ResultSet rs = pstm.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateQuiz(int id, String name, int questionLevelId, int duration, int passRate, int testTypeId) {
        String sql = "UPDATE [quizzes] SET [name] = ?, [question_level_id] = ?, [duration] = ?, " +
                "[pass_rate] = ?, [test_type_id] = ? " +
                " WHERE [id] = ?";

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setString(1, name);
            pstm.setInt(2, questionLevelId);
            pstm.setInt(3, duration);
            pstm.setInt(4, passRate);
            pstm.setInt(5, testTypeId);
            pstm.setInt(6, id);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating complete quiz: " + e.getMessage());
        }
        return false;
    }

    public boolean createQuiz(Quiz quiz) throws SQLException {
        String sql = "INSERT INTO [quizzes] ([name],[format], [question_level_id], [duration], [pass_rate], " +
                "[description], [status], [test_type_id], [subject_id], [quiz_setting_id]) " +
                "VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, quiz.getName());
            ps.setString(2, quiz.getFormat());
            ps.setInt(3, quiz.getQuestionLevelId());
            ps.setInt(4, quiz.getDuration());
            ps.setInt(5, quiz.getPassRate());
            ps.setString(6, quiz.getDescription());
            ps.setInt(7, quiz.getStatus());
            ps.setInt(8, quiz.getTestTypeId());
            ps.setInt(9, quiz.getSubjectId());
            ps.setInt(10, quiz.getQuizSettingId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public List<LessonDTO> getLessonsByPage(String subjectName, String lessonTypeName, String searchText,
            int page, int pageSize, String sortField, String sortOrder, int expertId) {
        List<LessonDTO> lessons = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT l.id, l.name, l.[order], l.video_link, l.content, l.status, " +
                        "s.id AS subject_id, s.name AS subject_name, " +
                        "lt.id AS lesson_type_id, lt.name AS lesson_type_name " +
                        "FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                        "WHERE s.owner_id = ?");

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        List<String> validSortFields = Arrays.asList("l.name", "l.order", "l.id", "s.name", "lt.name");
        if (!validSortFields.contains(sortField))
            sortField = "l.id";
        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC"))
            sortOrder = "ASC";

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LessonDTO dto = new LessonDTO();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setOrder(rs.getInt("order"));
                dto.setVideoLink(rs.getString("video_link"));
                dto.setContent(rs.getString("content"));
                dto.setStatus(rs.getBoolean("status"));

                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                subject.setName(rs.getString("subject_name"));
                dto.setSubject(subject);

                LessonType lessonType = new LessonType();
                lessonType.setId(rs.getInt("lesson_type_id"));
                lessonType.setName(rs.getString("lesson_type_name"));
                dto.setLessonType(lessonType);

                lessons.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lessons;
    }

    public int getTotalLessons(String subjectName, String lessonTypeName, String searchText, int expertId) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total FROM lessons l " +
                        "JOIN subjects s ON l.subject_id = s.id " +
                        "LEFT JOIN lesson_types lt ON l.lesson_type_id = lt.id " +
                        "WHERE s.owner_id = ?");

        if (subjectName != null && !subjectName.isEmpty()) {
            sql.append(" AND s.name LIKE ?");
        }
        if (lessonTypeName != null && !lessonTypeName.isEmpty()) {
            sql.append(" AND lt.name LIKE ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND l.name LIKE ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, expertId);
            int paramIndex = 2;

            if (subjectName != null && !subjectName.isEmpty())
                ps.setString(paramIndex++, "%" + subjectName + "%");

            if (lessonTypeName != null && !lessonTypeName.isEmpty())
                ps.setString(paramIndex++, "%" + lessonTypeName + "%");

            if (searchText != null && !searchText.isEmpty())
                ps.setString(paramIndex++, "%" + searchText + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

}
