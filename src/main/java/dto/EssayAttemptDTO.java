package dto;

import entity.EssaySubmission;
import entity.ExamAttempt;
import entity.Question;
import entity.QuestionMedia;

import java.util.List;

public class EssayAttemptDTO {

    private int id;
    private boolean isMarked;
    private Question question;
    private ExamAttempt examAttempt;
    private List<EssaySubmission> submissions;
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

    public List<EssaySubmission> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(List<EssaySubmission> submissions) {
        this.submissions = submissions;
    }

    public List<QuestionMedia> getQuestionMedias() {
        return questionMedias;
    }

    public void setQuestionMedias(List<QuestionMedia> questionMedias) {
        this.questionMedias = questionMedias;
    }
}
