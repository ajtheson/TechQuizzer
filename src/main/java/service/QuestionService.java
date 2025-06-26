package service;

import dao.DimensionDAO;
import dao.LessonDAO;
import dao.QuestionLevelDAO;
import dao.SubjectDAO;
import dto.QuestionDTO;
import entity.Lesson;
import entity.Question;

public class QuestionService {
    public QuestionDTO toQuestionDTO(Question question){
        if(question == null) return null;
        else{
            SubjectDAO subjectDAO = new SubjectDAO();
            LessonDAO lessonDAO = new LessonDAO();
            DimensionDAO dimensionDAO = new DimensionDAO();
            QuestionLevelDAO questionLevelDAO = new QuestionLevelDAO();
            Lesson lesson = lessonDAO.findById(question.getSubjectLessonId());
            int subjectId = lesson.getSubjectId();

            QuestionDTO questionDTO = new QuestionDTO();
            questionDTO.setId(question.getId());
            questionDTO.setContent(question.getContent());
            questionDTO.setExplaination(question.getExplaination());
            questionDTO.setDeleted(question.isDeleted());
            questionDTO.setQuestionLevelId(question.getQuestionLevelId());
            questionDTO.setSubjectLessonId(question.getSubjectLessonId());
            questionDTO.setSubjectDimensionId(question.getSubjectDimensionId());
            questionDTO.setQuestionFormat(question.getQuestionFormat());
            questionDTO.setSubjectName(subjectDAO.getSubjectById(subjectId).getName());
            questionDTO.setQuestionDimensionName(dimensionDAO.findById(question.getSubjectDimensionId()).getName());
            questionDTO.setSubjectLessonName(lesson.getName());
            questionDTO.setQuestionLevelName(questionLevelDAO.findById(question.getQuestionLevelId()).getName());
            return questionDTO;
        }
    }
}
