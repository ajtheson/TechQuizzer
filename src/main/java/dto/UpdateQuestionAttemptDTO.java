package dto;

import java.util.List;

public class UpdateQuestionAttemptDTO {

    private List<QuestionAttemptDTO> questionAttempts;
    private int duration;
    private int examAttemptId;

    public List<QuestionAttemptDTO> getQuestionAttempts() {
        return questionAttempts;
    }

    public void setQuestionAttempts(List<QuestionAttemptDTO> questionAttempts) {
        this.questionAttempts = questionAttempts;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getExamAttemptId() {
        return examAttemptId;
    }

    public void setExamAttemptId(int examAttemptId) {
        this.examAttemptId = examAttemptId;
    }
}
