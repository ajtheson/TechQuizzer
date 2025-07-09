package dao;

import dal.DBContext;
import entity.ExamAttempt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;

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

    public ExamAttempt findByQuizIdAndUserId(int quizId, int userId){
        String sql = "SELECT * FROM [exam_attempts] WHERE [quiz_id] = ? AND [user_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, quizId);
            pstm.setInt(2, userId);
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
                    return examAttempt;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

}
