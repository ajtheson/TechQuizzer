package entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class ExamAttempt {

    private int id;
    private String type;
    private LocalDate startDate;
    private int duration;
    private int numberCorrectQuestions;
    private int userId;
    private Integer quizId;
    private Integer practiceId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getNumberCorrectQuestions() {
        return numberCorrectQuestions;
    }

    public void setNumberCorrectQuestions(int numberCorrectQuestions) {
        this.numberCorrectQuestions = numberCorrectQuestions;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getQuizId() {
        return quizId;
    }

    public void setQuizId(Integer quizId) {
        this.quizId = quizId;
    }

    public Integer getPracticeId() {
        return practiceId;
    }

    public void setPracticeId(Integer practiceId) {
        this.practiceId = practiceId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
}
