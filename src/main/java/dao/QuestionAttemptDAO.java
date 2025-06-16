package dao;

import dal.DBContext;
import dto.QuestionAttemptDTO;
import entity.ExamAttempt;
import entity.Question;
import entity.QuestionAttempt;
import entity.QuestionOption;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuestionAttemptDAO extends DBContext {

    public boolean insertAllByExamAttemptIdAndQuestionIds(int examAttemptId, List<Integer> questionIds) {
        String sql = "insert into [question_attempts] ( [exam_attempt_id], [question_id]) values (?, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            for (Integer questionId : questionIds) {
                pstm.setInt(1, examAttemptId);
                pstm.setInt(2, questionId);
                pstm.addBatch();
            }
            pstm.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public List<QuestionAttemptDTO> findAllByExamAttemptId(int examAttemptId) {
        List<QuestionAttemptDTO> questionAttempts = new ArrayList<>();
        String sql = "select qa.id, qa.exam_attempt_id, qa.question_id, e.*, q.* " +
                "from question_attempts qa " +
                "join exam_attempts e on e.id = qa.exam_attempt_id " +
                "join questions q on qa.question_id = q.id " +
                "where qa.exam_attempt_id = ?";
        try (PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, examAttemptId);
            try (ResultSet rs = pstm.executeQuery()) {
                List<Integer> questionIds = new ArrayList<>();
                while (rs.next()) {
                    QuestionAttemptDTO questionAttemptDTO = new QuestionAttemptDTO();
                    questionAttemptDTO.setId(rs.getInt("id"));

                    Question question = new Question();
                    question.setId(rs.getInt("question_id"));
                    questionIds.add(question.getId());
                    question.setContent(rs.getString("content"));
                    question.setMedia(rs.getString("media"));
                    question.setDeleted(rs.getBoolean("is_deleted"));
                    question.setQuestionLevelId(rs.getInt("question_level_id"));
                    question.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                    question.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                    questionAttemptDTO.setQuestion(question);

                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("exam_attempt_id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setQuizId(rs.getObject("quiz_id", Integer.class));
                    examAttempt.setPracticeId(rs.getObject("practice_id", Integer.class));
                    questionAttemptDTO.setExamAttempt(examAttempt);

                    questionAttempts.add(questionAttemptDTO);
                }
                List<QuestionOption> questionOptions = new QuestionOptionDAO().findAllByQuestionIds(questionIds);
                Map<Integer, List<QuestionOption>> map = new HashMap<>();
                for (QuestionOption questionOption : questionOptions) {
                    if (map.containsKey(questionOption.getQuestionId())) {
                        map.get(questionOption.getQuestionId()).add(questionOption);
                    } else {
                        List<QuestionOption> list = new ArrayList<>();
                        list.add(questionOption);
                        map.put(questionOption.getQuestionId(), list);
                    }
                }
                for(QuestionAttemptDTO questionAttemptDTO : questionAttempts) {
                    questionAttemptDTO.setOptions(map.getOrDefault(questionAttemptDTO.getQuestion().getId(), new ArrayList<>()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questionAttempts;
    }

}
