package dao;

import dal.DBContext;
import entity.UserChoice;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserChoiceDAO extends DBContext {

    public List<UserChoice> findAllByQuestionAttemptId(int questionAttemptId){
        List<UserChoice> userChoices = new ArrayList<>();
        String sql = "SELECT * FROM [user_choices] WHERE [question_attempt_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, questionAttemptId);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                UserChoice userChoice = new UserChoice();
                userChoice.setId(rs.getInt("id"));
                userChoice.setQuestionAttemptId(rs.getInt("question_attempt_id"));
                userChoice.setQuestionOptionId(rs.getInt("question_option_id"));

                userChoices.add(userChoice);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return userChoices;
    }

    public List<Integer> findAllOptionIdByQuestionAttemptId(int questionAttemptId){
        List<Integer> userChoiceIds = new ArrayList<>();
        String sql = "SELECT [question_option_id] FROM [user_choices] WHERE [question_attempt_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, questionAttemptId);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                userChoiceIds.add(rs.getInt("question_option_id") );
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return userChoiceIds;
    }

    public void insert(int questionAttemptId, int questionOptionId){
        String sql = "INSERT INTO [user_choices] ([question_attempt_id], [question_option_id]) VALUES (?, ?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, questionAttemptId);
            pstm.setInt(2, questionOptionId);
            pstm.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insert(int questionAttemptId, List<Integer> questionOptionIds){
        String sql = "INSERT INTO [user_choices] ([question_attempt_id], [question_option_id]) VALUES (?, ?)";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            for(int questionOption : questionOptionIds) {
                pstm.setInt(1, questionAttemptId);
                pstm.setInt(2, questionOption);
                pstm.addBatch();
            }
            pstm.executeBatch();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int questionAttemptId, int questionOptionId){
        String sql = "DELETE FROM [user_choices] WHERE [question_attempt_id] = ? AND [question_option_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, questionAttemptId);
            pstm.setInt(2, questionOptionId);
            pstm.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int questionAttemptId, List<Integer> questionOptionIds){
        String sql = "DELETE FROM [user_choices] WHERE [question_attempt_id] = ? AND [question_option_id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            for(int questionOption : questionOptionIds) {
                pstm.setInt(1, questionAttemptId);
                pstm.setInt(2, questionOption);
                pstm.addBatch();
            }
            pstm.executeBatch();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

}
