package entity;

public class QuestionAttempt {

    private int id;
    private boolean isMarked;
    private int userChoice;
    private int questionId;
    private int examAttemptId;

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

    public int getUserChoice() {
        return userChoice;
    }

    public void setUserChoice(int userChoice) {
        this.userChoice = userChoice;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getExamAttemptId() {
        return examAttemptId;
    }

    public void setExamAttemptId(int examAttemptId) {
        this.examAttemptId = examAttemptId;
    }
}
