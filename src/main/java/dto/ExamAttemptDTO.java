package dto;

import entity.Practice;
import entity.Quiz;
import entity.User;

import java.time.LocalDate;

public class ExamAttemptDTO {

    private int id;
    private String type;
    private LocalDate startDate;
    private int duration;
    private String formattedDuration;
    private int numberCorrectQuestions;
    private int numberOfQuestions;
    private User user;
    private Quiz quiz;
    private Practice practice;

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

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Practice getPractice() {
        return practice;
    }

    public void setPractice(Practice practice) {
        this.practice = practice;
    }

    public int getNumberOfQuestions() {
        return numberOfQuestions;
    }

    public void setNumberOfQuestions(int numberOfQuestions) {
        this.numberOfQuestions = numberOfQuestions;
    }

    public String getFormattedDuration() {
        return formattedDuration;
    }

    public void setFormattedDuration(String formattedDuration) {
        this.formattedDuration = formattedDuration;
    }
}
