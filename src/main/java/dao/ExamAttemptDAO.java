package dao;

import dal.DBContext;
import dto.ExamAttemptDTO;
import entity.ExamAttempt;
import entity.Quiz;
import entity.QuizSetting;
import entity.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ExamAttemptDAO extends DBContext {

    public int insert(ExamAttempt examAttempt) {
        String sql = "insert into [exam_attempts] ([type], [duration], [number_correct_question], [user_id], [quiz_id], [practice_id]) " +
                "values(?,?,?,?,?,?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setString(1, examAttempt.getType());
            pstm.setInt(2, examAttempt.getDuration());
            pstm.setInt(3, examAttempt.getNumberCorrectQuestions());
            pstm.setInt(4, examAttempt.getUserId());
            pstm.setObject(5, examAttempt.getQuizId(), Types.INTEGER);
            pstm.setObject(6, examAttempt.getPracticeId(), Types.INTEGER);
            int affectedRows = pstm.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ExamAttempt findByPracticeId(int practiceId) {
        String sql = "SELECT * FROM [exam_attempts] WHERE [practice_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, practiceId);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setPracticeId(practiceId);
                    return examAttempt;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ExamAttempt> findAllByQuizId(int quizId) {
        List<ExamAttempt> examAttempts = new ArrayList<>();
        String sql = "SELECT * FROM [exam_attempts] WHERE [quiz_id] = ? AND is_taken = 1";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, quizId);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setQuizId(quizId);

                    examAttempts.add(examAttempt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return examAttempts;
    }

    public List<ExamAttemptDTO> findAllByQuizIdWithPagination(int quizId, int page, int size, String search, LocalDate filter) {
        List<ExamAttemptDTO> examAttemptDTOs = new ArrayList<>();
        String sql = "select e.id, e.[type], e.[start_date], e.duration, e.number_correct_question, e.[user_id], u.[name], q.question_level_id, qs.number_question \n" +
                "from exam_attempts e\n" +
                "join quizzes q on e.quiz_id = q.id\n" +
                "join users u on e.[user_id] = u.id\n" +
                "join quiz_settings qs on q.quiz_setting_id = qs.id\n" +
                "where q.id = ? and u.name like ? and (? is null or e.start_date = ?) \n" +
                "ORDER BY [start_date] DESC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            pstm.setInt(index++, quizId);
            pstm.setString(index++, "%" + search + "%");
            if(filter != null){
                pstm.setDate(index++, Date.valueOf(filter));
                pstm.setDate(index++, Date.valueOf(filter));
            }else{
                pstm.setDate(index++, null);
                pstm.setDate(index++, null);
            }
            pstm.setInt(index++, (page - 1) * size);
            pstm.setInt(index, size);
            try(ResultSet rs = pstm.executeQuery()){
                while(rs.next()){
                    ExamAttemptDTO examAttemptDTO = new ExamAttemptDTO();

                    examAttemptDTO.setId(rs.getInt("id"));
                    examAttemptDTO.setType(rs.getString("type"));
                    examAttemptDTO.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttemptDTO.setDuration(rs.getInt("duration"));
                    examAttemptDTO.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttemptDTO.setNumberOfQuestions(rs.getInt("number_question") );

                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    examAttemptDTO.setUser(user);


                    examAttemptDTOs.add(examAttemptDTO);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return examAttemptDTOs;
    }

    public int countByQuizId(int quizId, String search, LocalDate filter) {
        String sql = "select COUNT(*) \n" +
                "from exam_attempts e\n" +
                "join users u on e.[user_id] = u.id\n" +
                "where e.quiz_id = ? and u.name like ? and (? is null or e.start_date = ?) \n";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            int index = 1;
            pstm.setInt(index++, quizId);
            pstm.setString(index++, "%" + search + "%");
            if(filter != null){
                pstm.setDate(index++, Date.valueOf(filter));
                pstm.setDate(index, Date.valueOf(filter));
            }else{
                pstm.setDate(index++, null);
                pstm.setDate(index, null);
            }
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ExamAttemptDTO> findTop10ByQuizIdAndUserIdOrderByDateDescAndIdDesc(int quizId, int userId){
        List<ExamAttemptDTO> examAttemptDTOs = new ArrayList<>();
        String sql = "SELECT TOP(10) e.*, qs.number_question FROM [exam_attempts] e " +
                "JOIN [quizzes] q ON e.[quiz_id] = q.[id] " +
                "JOIN [quiz_settings] qs ON q.[quiz_setting_id] = qs.[id] " +
                "WHERE [quiz_id] = ? AND [user_id] = ? ORDER BY [start_date] DESC, [id] DESC";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, quizId);
            pstm.setInt(2, userId);
            try(ResultSet rs = pstm.executeQuery()){
                while(rs.next()){
                    ExamAttemptDTO examAttemptDTO = new ExamAttemptDTO();
                    examAttemptDTO.setId(rs.getInt("id"));
                    examAttemptDTO.setType(rs.getString("type"));
                    examAttemptDTO.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttemptDTO.setDuration(rs.getInt("duration"));
                    examAttemptDTO.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttemptDTO.setNumberOfQuestions(rs.getInt("number_question") );

                    examAttemptDTOs.add(examAttemptDTO);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return examAttemptDTOs;
    }

    public boolean updateNumberCorrectQuestion(int numberCorrectQuestions, int id) {
        String sql = "UPDATE [exam_attempts] SET [number_correct_question] = ? WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, numberCorrectQuestions);
            pstm.setInt(2, id);
            pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateDuration(int duration, int id) {
        String sql = "UPDATE [exam_attempts] SET [duration] = ? WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, duration);
            pstm.setInt(2, id);
            pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateIsTaken(boolean isTaken, int id) {
        String sql = "UPDATE [exam_attempts] SET [is_taken] = ? WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setBoolean(1, isTaken);
            pstm.setInt(2, id);
            pstm.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public ExamAttempt findById(int id) {
        String sql = "SELECT * FROM [exam_attempts] WHERE [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setQuizId(rs.getObject("quiz_id", Integer.class));
                    examAttempt.setPracticeId(rs.getObject("practice_id", Integer.class));
                    return examAttempt;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public boolean isTakenExamAttempt(int id) {
        String sql = "SELECT 1 FROM [exam_attempts] WHERE [id] = ? AND [is_taken] = 1";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    return true;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public List<ExamAttempt> findAllByQuizIdAndUserId(int quizId, int userId) {
        List<ExamAttempt> attempts = new ArrayList<>();
        String sql = "SELECT * FROM [exam_attempts] WHERE [quiz_id] = ? AND [user_id] = ? ORDER BY id desc ";

        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, quizId);
            pstm.setInt(2, userId);

            try (ResultSet rs = pstm.executeQuery()) {
                while (rs.next()) {
                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setQuizId(rs.getInt("quiz_id"));
                    attempts.add(examAttempt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return attempts;
    }

    public boolean isBelongToUser(int examAttemptId, int userId){
        String sql = "SELECT 1 FROM [exam_attempts] WHERE [user_id] = ? and [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, userId);
            pstm.setInt(2, examAttemptId);
            try(ResultSet rs = pstm.executeQuery()){
                if(rs.next()){
                    return true;
                }
            }
        }catch (Exception e){
            return false;
        }
        return false;
    }

}
