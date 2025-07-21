package service;

import dao.*;
import dto.PracticeDTO;
import dto.QuizDTO;
import entity.ExamAttempt;
import entity.Practice;
import entity.Question;
import entity.QuizSettingGroup;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ExamAttemptService {

    public int createExamAttemptAndQuestionForExamAttempt(Object object, int userId) {
        int insertedExamAttemptId = -1;

        try {

            //insert exam attempt
            ExamAttempt examAttempt = new ExamAttempt();
            if (object instanceof Practice practice) {
                examAttempt.setType("Practice");
                examAttempt.setDuration(0);
            }else if(object instanceof QuizDTO quizDTO){
                examAttempt.setType("Quiz");
                examAttempt.setDuration(quizDTO.getDuration());
            }
            examAttempt.setNumberCorrectQuestions(0);
            examAttempt.setUserId(userId);

            if (object instanceof Practice practice) {
                examAttempt.setPracticeId(practice.getId());
            } else if (object instanceof QuizDTO quizDTO) {
                examAttempt.setQuizId(quizDTO.getId());
            }
            insertedExamAttemptId = new ExamAttemptDAO().insert(examAttempt);
            if (insertedExamAttemptId == -1) {
                throw new Exception("Exam attempt not created");
            }

            //insert question attempt
            if (object instanceof Practice practice) {
                List<Question> questions = new ArrayList<>(practice.getNumberOfQuestions());
                if (practice.getSubjectDimensionId() != null) {
                    List<Question> questionSubList = new QuestionDAO().findAllByDimensionIdAndQuestionLevelAndFormat(practice.getSubjectDimensionId(), practice.getQuestionLevelId(), practice.getFormat());
                    Collections.shuffle(questionSubList);
                    questions.addAll(questionSubList.subList(0, practice.getNumberOfQuestions()));
                } else {
                    List<Question> questionSubList = new QuestionDAO().findAllByLessonIdAndQuestionLevelAndFormat(practice.getSubjectLessonId(), practice.getQuestionLevelId(), practice.getFormat());
                    Collections.shuffle(questionSubList);
                    questions.addAll(questionSubList.subList(0, practice.getNumberOfQuestions()));
                }
                List<Integer> questionIds = questions.stream().map(q -> q.getId()).toList();
                if (practice.getFormat().equalsIgnoreCase("multiple")) {
                    if (!new QuestionAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                        throw new Exception("Question attempt not created");
                    }
                } else {
                    if (!new EssayAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                        throw new Exception("Essay attempt not created");
                    }
                }
            } else if (object instanceof QuizDTO quizDTO) {
                List<Question> questions = new ArrayList<>(quizDTO.getQuizSetting().getNumberOfQuestions());
                List<QuizSettingGroup> quizSettingGroups = new QuizSettingGroupDAO().getByQuizSettingIdAndType(quizDTO.getQuizSetting().getId(), quizDTO.getQuizSetting().getQuestionType());
                for(QuizSettingGroup quizSettingGroup : quizSettingGroups){
                    if(quizSettingGroup.getSubjectDimensionId() != null){
                        List<Question> questionSubList = new QuestionDAO().findAllByDimensionIdAndQuestionLevelAndFormat(
                                quizSettingGroup.getSubjectDimensionId(), quizDTO.getQuestionLevel().getId(), quizDTO.getFormat());
                        Collections.shuffle(questionSubList);
                        questions.addAll(questionSubList.subList(0, quizSettingGroup.getNumberQuestion()));
                    }
                    else{
                        List<Question> questionSubList = new QuestionDAO().findAllByLessonIdAndQuestionLevelAndFormat(
                                quizSettingGroup.getSubjectLessonId(), quizDTO.getQuestionLevel().getId(), quizDTO.getFormat());
                        Collections.shuffle(questionSubList);
                        questions.addAll(questionSubList.subList(0, quizSettingGroup.getNumberQuestion()));
                    }
                }

                List<Integer> questionIds = questions.stream().map(q -> q.getId()).toList();
                if (quizDTO.getFormat().equalsIgnoreCase("multiple")) {
                    if (!new QuestionAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                        throw new Exception("Question attempt not created");
                    }
                } else {
                    if (!new EssayAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                        throw new Exception("Essay attempt not created");
                    }
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertedExamAttemptId;
    }

}
