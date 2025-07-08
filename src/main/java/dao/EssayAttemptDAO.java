package dao;

import dal.DBContext;
import dto.EssayAttemptDTO;
import dto.QuestionAttemptDTO;
import entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EssayAttemptDAO extends DBContext {

    public List<EssayAttemptDTO> findAllByExamAttemptId(int examAttemptId) {
        List<EssayAttemptDTO> essayAttemptDTOs = new ArrayList<>();
        String sql = "select ea.id, ea.exam_attempt_id, ea.question_id, ea.is_marked, e.*, q.*\n" +
                "from essay_attempts ea\n" +
                "join exam_attempts e on e.id = ea.exam_attempt_id\n" +
                "join questions q on ea.question_id = q.id " +
                "where ea.exam_attempt_id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, examAttemptId);
            try (ResultSet rs = pstm.executeQuery()) {
                List<Integer> essayAttemptIds = new ArrayList<>();
                while (rs.next()) {
                    EssayAttemptDTO essayAttemptDTO = new EssayAttemptDTO();
                    essayAttemptDTO.setId(rs.getInt("id"));
                    essayAttemptIds.add(essayAttemptDTO.getId());
                    essayAttemptDTO.setMarked(rs.getBoolean("is_marked"));

                    Question question = new Question();
                    question.setId(rs.getInt("question_id"));
                    question.setContent(rs.getString("content"));
                    question.setExplaination(rs.getString("explaination"));
                    question.setDeleted(rs.getBoolean("is_deleted"));
                    question.setQuestionLevelId(rs.getInt("question_level_id"));
                    question.setSubjectDimensionId(rs.getInt("subject_dimension_id"));
                    question.setSubjectLessonId(rs.getInt("subject_lesson_id"));
                    essayAttemptDTO.setQuestion(question);

                    ExamAttempt examAttempt = new ExamAttempt();
                    examAttempt.setId(rs.getInt("exam_attempt_id"));
                    examAttempt.setType(rs.getString("type"));
                    examAttempt.setStartDate(rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null);
                    examAttempt.setDuration(rs.getInt("duration"));
                    examAttempt.setNumberCorrectQuestions(rs.getInt("number_correct_question"));
                    examAttempt.setUserId(rs.getInt("user_id"));
                    examAttempt.setQuizId(rs.getObject("quiz_id", Integer.class));
                    examAttempt.setPracticeId(rs.getObject("practice_id", Integer.class));
                    essayAttemptDTO.setExamAttempt(examAttempt);

                    List<QuestionMedia> questionMedias = new QuestionMediaDAO().findByQuestionId(question.getId());
                    essayAttemptDTO.setQuestionMedias(questionMedias);

                    essayAttemptDTOs.add(essayAttemptDTO);
                }
                List<EssaySubmission> essaySubmissions = new EssaySubmissionDAO().findAllByEssayAttemptIds(essayAttemptIds);
                Map<Integer, List<EssaySubmission>> map = new HashMap<>();

                for (EssaySubmission submission : essaySubmissions) {
                    if (map.containsKey(submission.getEssayAttemptId())) {
                        map.get(submission.getEssayAttemptId()).add(submission);
                    } else {
                        List<EssaySubmission> list = new ArrayList<>();
                        list.add(submission);
                        map.put(submission.getEssayAttemptId(), list);
                    }
                }
                for(EssayAttemptDTO essayAttemptDTO : essayAttemptDTOs) {
                    essayAttemptDTO.setSubmissions(map.getOrDefault(essayAttemptDTO.getId(), new ArrayList<>()));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return essayAttemptDTOs;
    }

    public boolean insertAllByExamAttemptIdAndQuestionIds(int examAttemptId, List<Integer> questionIds) {
        String sql = "insert into [essay_attempts] ([exam_attempt_id], [question_id]) values (?, ?)";
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

    public boolean updateEssayAttemptsDuringExamAttempt(List<EssayAttemptDTO> essayAttemptDTOs) {
        String sql = "update [essay_attempts] set is_marked = ? where id = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            for(EssayAttemptDTO essayAttemptDTO : essayAttemptDTOs) {
                pstm.setBoolean(1, essayAttemptDTO.isMarked());
                pstm.setInt(2, essayAttemptDTO.getId());
                pstm.addBatch();
            }
            pstm.executeBatch();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
