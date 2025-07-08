package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import dal.DBContext;
import entity.QuestionOption;

public class QuestionOptionDAO extends DBContext {

    public void insert(QuestionOption option) throws Exception {
        String sql = "INSERT INTO question_options (option_content, is_answer, question_id) VALUES (?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, option.getOptionContent());
            stm.setBoolean(2, option.isAnswer());
            stm.setInt(3, option.getQuestionId());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public List<QuestionOption> findByQuestionId(int questionId) throws Exception {
        List<QuestionOption> list = new ArrayList<>();
        String sql = "SELECT * FROM question_options WHERE question_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    QuestionOption o = new QuestionOption();
                    o.setId(rs.getInt("id"));
                    o.setOptionContent(rs.getString("option_content"));
                    o.setAnswer(rs.getBoolean("is_answer"));
                    o.setQuestionId(rs.getInt("question_id"));
                    list.add(o);
                }
            }
        }
        return list;
    }

    public List<QuestionOption> findAllByQuestionIds(List<Integer> questionIds) {
        List<QuestionOption> questionOptions = new ArrayList<>();
        if (questionIds == null || questionIds.isEmpty()) {
            return questionOptions;
        }
        String inClause = questionIds.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "select [id], [option_content], [is_answer], [question_id] " +
                "from [question_options] where [question_id] in (" + inClause + ")";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            int index = 1;
            for (Integer id : questionIds) {
                pstm.setInt(index++, id);
            }
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                QuestionOption questionOption = new QuestionOption();
                questionOption.setId(rs.getInt("id"));
                questionOption.setOptionContent(rs.getString("option_content"));
                questionOption.setAnswer(rs.getBoolean("is_answer"));
                questionOption.setQuestionId(rs.getInt("question_id"));
                questionOptions.add(questionOption);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questionOptions;
    }

}
