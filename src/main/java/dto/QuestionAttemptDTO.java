package dto;

import entity.*;

import java.util.List;

public class QuestionAttemptDTO {

    private int id;
    private boolean isMarked;
    private List<Integer> userChoices;
    private Question question;
    private ExamAttempt examAttempt;
    private List<QuestionOption> options;
    private List<QuestionMedia> questionMedias;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isMarked() {
        return isMarked;
    }

    public void setMarked(boolean marked) {
        isMarked = marked;
    }

    public List<Integer> getUserChoices() {
        return userChoices;
    }

    public void setUserChoices(List<Integer> userChoices) {
        this.userChoices = userChoices;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public ExamAttempt getExamAttempt() {
        return examAttempt;
    }

    public void setExamAttempt(ExamAttempt examAttempt) {
        this.examAttempt = examAttempt;
    }

    public List<QuestionOption> getOptions() {
        return options;
    }

    public void setOptions(List<QuestionOption> options) {
        this.options = options;
    }

    public List<QuestionMedia> getQuestionMedias() {
        return questionMedias;
    }

    public void setQuestionMedias(List<QuestionMedia> questionMedias) {
        this.questionMedias = questionMedias;
    }
}
