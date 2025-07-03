package service;

import dao.*;
import dto.QuizDTO;
import entity.QuestionLevel;
import entity.Quiz;
import entity.QuizSetting;
import entity.Subject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class QuizService {

    public List<QuizDTO> convertQuizToQuizDTO(List<Quiz> quizzes) {
        List<QuizDTO> quizDTOList = new ArrayList<>();

        List<Integer> subjectIds = quizzes.stream().map(q -> q.getSubjectId()).distinct().toList();
        List<Integer> quizSettingIds = quizzes.stream().map(q -> q.getQuizSettingId()).distinct().toList();

        List<Subject> subjects = new SubjectDAO().findByIds(subjectIds);
        List<QuizSetting> quizSettings = new QuizSettingDAO().findByIds(quizSettingIds);

        Map<Integer, Subject> subjectMap = subjects.stream().collect(Collectors.toMap(s -> s.getId(), s -> s));
        Map<Integer, QuizSetting> quizSettingMap = quizSettings.stream().collect(Collectors.toMap(qs -> qs.getId(), q -> q));

        List<QuestionLevel> questionLevels = new QuestionLevelDAO().findAll();

        for (Quiz quiz : quizzes) {
            QuizDTO quizDTO = new QuizDTO();
            quizDTO.setId(quiz.getId());
            quizDTO.setFormat(quiz.getFormat());
            quizDTO.setName(quiz.getName());
            quizDTO.setSubject(subjectMap.get(quiz.getSubjectId()));
            quizDTO.setQuizSetting(quizSettingMap.get(quiz.getQuizSettingId()));

            QuestionLevel questionLevel = null;
            Optional<QuestionLevel> questionLevelOptional = questionLevels.stream()
                    .filter(q -> q.getId() == quiz.getQuestionLevelId()).findFirst();
            if (questionLevelOptional.isPresent()) {
                questionLevel = questionLevelOptional.get();
            }
            quizDTO.setQuestionLevel(questionLevel);

            quizDTO.setDuration(quiz.getDuration());
            quizDTO.setPassRate(quiz.getPassRate());
            quizDTOList.add(quizDTO);
        }
        return quizDTOList;
    }

    public QuizDTO convertQuizToQuizDTO(Quiz quiz) {
        QuizDTO quizDTO = new QuizDTO();
        quizDTO.setId(quiz.getId());
        quizDTO.setFormat(quiz.getFormat());
        quizDTO.setName(quiz.getName());
        quizDTO.setSubject(new SubjectDAO().findById(quiz.getSubjectId()));
        quizDTO.setQuizSetting(new QuizSettingDAO().findById(quiz.getQuizSettingId()));
        quizDTO.setQuestionLevel(new QuestionLevelDAO().findById(quiz.getQuestionLevelId()));
        quizDTO.setDuration(quiz.getDuration());
        quizDTO.setPassRate(quiz.getPassRate());

        return quizDTO;
    }
}
