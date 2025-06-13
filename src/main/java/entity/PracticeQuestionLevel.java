package entity;

public class PracticeQuestionLevel {

    private int id;
    private int practiceId;
    private int questionLevelId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPracticeId() {
        return practiceId;
    }

    public void setPracticeId(int practiceId) {
        this.practiceId = practiceId;
    }

    public int getQuestionLevelId() {
        return questionLevelId;
    }

    public void setQuestionLevelId(int questionLevelId) {
        this.questionLevelId = questionLevelId;
    }
}
