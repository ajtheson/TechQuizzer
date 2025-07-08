package dto;

import javax.security.auth.Subject;

import entity.QuestionLevel;
import entity.QuizSetting;
import entity.TestType;

public class QuizDTO {

    private int id;
    private String name;
    private Subject subject;
    private QuestionLevel questionLevel;
    private QuizSetting quizSetting;
    private TestType testType;
    private int duration;
    private int passRate;
    private int status;
    private String format;

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

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public QuestionLevel getQuestionLevel() {
        return questionLevel;
    }

    public void setQuestionLevel(QuestionLevel questionLevel) {
        this.questionLevel = questionLevel;
    }

    public QuizSetting getQuizSetting() {
        return quizSetting;
    }

    public void setQuizSetting(QuizSetting quizSetting) {
        this.quizSetting = quizSetting;
    }

    public void setTestType(TestType testType) {
        this.testType = testType;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPassRate() {
        return passRate;
    }

    public void setPassRate(int passRate) {
        this.passRate = passRate;
    }

    public TestType getTestType() {
        return testType;
    }

    public void setTestType(TestType testType) {
        this.testType = testType;
    }

    public int getStatus() {
        return status;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}
