package dao;

import dal.DBContext;
import entity.Question;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO extends DBContext {

    public List<Question> findAllByDimensionIdAndQuestionLevelAndFormat(int dimensionId, int questionLevelId, String format) {
        List<Question> questions = new ArrayList<>();
        String sql = "select [id], [content], [explaination], [question_level_id], [subject_lesson_id], [subject_dimension_id] " +
                "from [questions] where [subject_dimension_id] = ? and [question_level_id] = ? AND [question_format] = ? and [is_deleted] = 0";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, dimensionId);
            pstm.setInt(2, questionLevelId);
            pstm.setString(3, format);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setContent(rs.getString("content"));
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

    public List<Question> findAllByLessonIdAndQuestionLevelAndFormat(int lessonId, int questionLevelId, String format) {
        List<Question> questions = new ArrayList<>();
        String sql = "select [id], [content], [explaination], [question_level_id], [subject_lesson_id], [subject_dimension_id] " +
                "from [questions] where [subject_lesson_id] = ? and [question_level_id] = ? and [question_format] = ? and [is_deleted] = 0";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, lessonId);
            pstm.setInt(2, questionLevelId);
            pstm.setString(3, format);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setContent(rs.getString("content"));
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

}
