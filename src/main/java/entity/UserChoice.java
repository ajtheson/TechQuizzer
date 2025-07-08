package entity;

public class UserChoice {

    private int id;
    private int questionOptionId;
    private int questionAttemptId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestionOptionId() {
        return questionOptionId;
    }

    public void setQuestionOptionId(int questionOptionId) {
        this.questionOptionId = questionOptionId;
    }

    public int getQuestionAttemptId() {
        return questionAttemptId;
    }

    public void setQuestionAttemptId(int questionAttemptId) {
        this.questionAttemptId = questionAttemptId;
    }
}
