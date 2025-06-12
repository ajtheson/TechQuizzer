package dto;

import entity.*;

import java.util.List;

public class PracticeDTO {

    private int id;
    private String name;
    private int numberOfQuestions;
    private String formattedDuration;
    private String levelString;
    private ExamAttempt examAttempt;
    private Dimension subjectDimension;
    private Lesson subjectLesson;
    private Subject subject;
    private List<PracticeQuestionLevelDTO> practiceQuestionLevels;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumberOfQuestions() {
        return numberOfQuestions;
    }

    public void setNumberOfQuestions(int numberOfQuestions) {
        this.numberOfQuestions = numberOfQuestions;
    }

    public ExamAttempt getExamAttempt() {
        return examAttempt;
    }

    public void setExamAttempt(ExamAttempt examAttempt) {
        this.examAttempt = examAttempt;
    }

    public Dimension getSubjectDimension() {
        return subjectDimension;
    }

    public void setSubjectDimension(Dimension subjectDimension) {
        this.subjectDimension = subjectDimension;
    }

    public Lesson getSubjectLesson() {
        return subjectLesson;
    }

    public void setSubjectLesson(Lesson subjectLesson) {
        this.subjectLesson = subjectLesson;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public List<PracticeQuestionLevelDTO> getPracticeQuestionLevels() {
        return practiceQuestionLevels;
    }

    public void setPracticeQuestionLevels(List<PracticeQuestionLevelDTO> practiceQuestionLevels) {
        this.practiceQuestionLevels = practiceQuestionLevels;
    }

    public String getFormattedDuration() {
        return formattedDuration;
    }

    public void setFormattedDuration(String formattedDuration) {
        this.formattedDuration = formattedDuration;
    }

    public String getLevelString() {
        return levelString;
    }

    public void setLevelString(String levelString) {
        this.levelString = levelString;
    }
}
