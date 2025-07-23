package service;

import dao.*;
import dto.PracticeDTO;
import dto.QuizDTO;
import entity.ExamAttempt;
import entity.Practice;
import entity.Question;
import entity.QuizSettingGroup;
import java.util.Random;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ExamAttemptService {

    public int createExamAttemptAndQuestionForExamAttempt(Object object, int userId) {
        int insertedExamAttemptId = -1;
        int numberOfQuestions = 0;

        try {

            //insert exam attempt
            ExamAttempt examAttempt = new ExamAttempt();
            if (object instanceof Practice practice) {
                examAttempt.setType("Practice");
                examAttempt.setDuration(0);
                numberOfQuestions = practice.getNumberOfQuestions();
            } else if (object instanceof QuizDTO quizDTO) {
                examAttempt.setType("Quiz");
                examAttempt.setDuration(quizDTO.getDuration());
                numberOfQuestions = quizDTO.getQuizSetting().getNumberOfQuestions();
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
            List<Question> questions = new ArrayList<>(numberOfQuestions);
            String format = "";
            List<Question> questionSubList = null;

            if (object instanceof Practice practice) {
                if (practice.getSubjectDimensionId() != null) {
                    questionSubList = new QuestionDAO().findAllByDimensionIdAndQuestionLevelAndFormat(practice.getSubjectDimensionId(), practice.getQuestionLevelId(), practice.getFormat());
                } else {
                    questionSubList = new QuestionDAO().findAllByLessonIdAndQuestionLevelAndFormat(practice.getSubjectLessonId(), practice.getQuestionLevelId(), practice.getFormat());
                }
                Collections.shuffle(questionSubList);
                questions.addAll(questionSubList.subList(0, Math.min(practice.getNumberOfQuestions(), questionSubList.size())));
                format = practice.getFormat();
            } else if (object instanceof QuizDTO quizDTO) {
                List<QuizSettingGroup> quizSettingGroups = new QuizSettingGroupDAO().getByQuizSettingIdAndType(quizDTO.getQuizSetting().getId(), quizDTO.getQuizSetting().getQuestionType());
                for (QuizSettingGroup quizSettingGroup : quizSettingGroups) {
                    if (quizSettingGroup.getSubjectDimensionId() != null) {
                        questionSubList = new QuestionDAO().findAllByDimensionIdAndQuestionLevelAndFormat(
                                quizSettingGroup.getSubjectDimensionId(), quizDTO.getQuestionLevel().getId(), quizDTO.getFormat());
                    } else {
                        questionSubList = new QuestionDAO().findAllByLessonIdAndQuestionLevelAndFormat(
                                quizSettingGroup.getSubjectLessonId(), quizDTO.getQuestionLevel().getId(), quizDTO.getFormat());
                    }
                    Collections.shuffle(questionSubList);
                    questions.addAll(questionSubList.subList(0, Math.min(quizSettingGroup.getNumberQuestion(), questionSubList.size())));
                }
                format = quizDTO.getFormat();
            }

            if (questions.isEmpty()) {
                throw new Exception("No question available");
            }
            if (questions.size() < numberOfQuestions) {
                Random random = new Random();
                while (questions.size() < numberOfQuestions) {
                    questions.add(questions.get(random.nextInt(questions.size())));
                }
            }

            List<Integer> questionIds = questions.stream().map(q -> q.getId()).toList();
            if (format.equalsIgnoreCase("multiple")) {
                if (!new QuestionAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                    throw new Exception("Question attempt not created");
                }
            } else {
                if (!new EssayAttemptDAO().insertAllByExamAttemptIdAndQuestionIds(insertedExamAttemptId, questionIds)) {
                    throw new Exception("Essay attempt not created");
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertedExamAttemptId;
    }

}
