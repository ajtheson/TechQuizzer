package entity;

public class EssayAttempt {

    private int id;
    private boolean isMarked;
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
