package dto;

import entity.QuizSetting;
import entity.Subject;

public class QuizDTO {

    private int id;
    private String name;
    private Subject subject;
    private String level;
    private QuizSetting quizSetting;
    private int  duration;
    private int passRate;

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

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public QuizSetting getQuizSetting() {
        return quizSetting;
    }

    public void setQuizSetting(QuizSetting quizSetting) {
        this.quizSetting = quizSetting;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getPassRate() {
        return passRate;
    }

    public void setPassRate(int passRate) {
        this.passRate = passRate;
    }

}
