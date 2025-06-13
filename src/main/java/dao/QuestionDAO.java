package dao;

import dal.DBContext;
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
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, dimensionId);
            pstm.setInt(2, questionLevel);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setContent(rs.getString("content"));
                question.setMedia(rs.getString("media"));
                question.setExplaination(rs.getString("explaination"));
                question.setQuestionLevelId(rs.getInt("question_level_id"));
                question.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                question.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                questions.add(question);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return questions;
    }

//    public List<Question> findAllByLessonIdAndQuestionLevel(int lessonId, int questionLevel) {
//
//    }

}
