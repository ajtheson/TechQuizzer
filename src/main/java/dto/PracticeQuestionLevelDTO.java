package dto;

import entity.QuestionLevel;

public class PracticeQuestionLevelDTO {

    private int id;
    private QuestionLevel questionLevel;
    private int practiceId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public QuestionLevel getQuestionLevel() {
        return questionLevel;
    }

    public void setQuestionLevel(QuestionLevel questionLevel) {
        this.questionLevel = questionLevel;
    }

    public int getPracticeId() {
        return practiceId;
    }

    public void setPracticeId(int practiceId) {
        this.practiceId = practiceId;
    }
}
