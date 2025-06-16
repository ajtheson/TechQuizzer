package dao;

import dal.DBContext;
import entity.QuestionOption;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class QuestionOptionDAO extends DBContext {

    public List<QuestionOption> findAllByQuestionIds(List<Integer> questionIds) {
        List<QuestionOption> questionOptions = new ArrayList<>();
        if (questionIds == null || questionIds.isEmpty()) {
            return questionOptions;
        }
        String inClause = questionIds.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "select [id], [option_content], [is_answer], [question_id] " +
                "from [question_options] where [question_id] in (" + inClause + ")";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
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
        }catch (Exception e) {
            e.printStackTrace();
        }
        return questionOptions;
    }

}
