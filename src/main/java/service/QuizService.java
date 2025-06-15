package service;

import dao.*;
import dto.QuizDTO;
import entity.Quiz;
import entity.QuizSetting;
import entity.Subject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import entity.TestType;

import java.util.stream.Collectors;

public class QuizService {

    public List<QuizDTO> convertQuizToQuizDTO(List<Quiz> quizzes) {
        List<QuizDTO> quizDTOList = new ArrayList<>();

        List<Integer> subjectIds = quizzes.stream().map(Quiz::getSubjectId).distinct().toList();
        List<Integer> quizSettingIds = quizzes.stream().map(Quiz::getQuizSettingId).distinct().toList();
        List<Integer> testTypeIds = quizzes.stream().map(Quiz::getTestTypeId).distinct().toList();

        SubjectDAO subjectDAO = new SubjectDAO();
        QuizSettingDAO quizSettingDAO = new QuizSettingDAO();
        TestTypeDao testTypeDAO = new TestTypeDao();

        List<Subject> subjects = subjectDAO.findByIds(subjectIds);
        List<QuizSetting> quizSettings = quizSettingDAO.findByIds(quizSettingIds);
        List<TestType> testTypes = testTypeDAO.findByIds(testTypeIds);

        Map<Integer, Subject> subjectMap = subjects.stream().collect(Collectors.toMap(Subject::getId, s -> s));
        Map<Integer, QuizSetting> quizSettingMap = quizSettings.stream().collect(Collectors.toMap(QuizSetting::getId, q -> q));
        Map<Integer, TestType> testTypeMap = testTypes.stream().collect(Collectors.toMap(TestType::getId, t -> t));
        for (Quiz quiz : quizzes) {
            QuizDTO quizDTO = new QuizDTO();
            quizDTO.setId(quiz.getId());
            quizDTO.setName(quiz.getName());
            quizDTO.setSubject(subjectMap.get(quiz.getSubjectId()));
            quizDTO.setQuizSetting(quizSettingMap.get(quiz.getQuizSettingId()));
            quizDTO.setTestType(testTypeMap.get(quiz.getTestTypeId()));
            quizDTO.setLevel(quiz.getLevel());
            quizDTO.setDuration(quiz.getDuration());
            quizDTO.setPassRate(quiz.getPassRate());
            quizDTO.setStatus(quiz.getStatus());
            quizDTOList.add(quizDTO);
        }
        return quizDTOList;
    }

    public QuizDTO convertQuizToQuizDTO(Quiz quiz) {
        Subject subject = new SubjectDAO().findById(quiz.getSubjectId());
        QuizSetting quizSetting = new QuizSettingDAO().findById(quiz.getQuizSettingId());
        TestType testType = new TestTypeDao().findById(quiz.getTestTypeId());

        QuizDTO quizDTO = new QuizDTO();
        quizDTO.setId(quiz.getId());
        quizDTO.setName(quiz.getName());
        quizDTO.setSubject(subject);
        quizDTO.setQuizSetting(quizSetting);
        quizDTO.setTestType(testType);
        quizDTO.setLevel(quiz.getLevel());
        quizDTO.setDuration(quiz.getDuration());
        quizDTO.setPassRate(quiz.getPassRate());
        quizDTO.setStatus(quiz.getStatus());

        return quizDTO;
    }
}
