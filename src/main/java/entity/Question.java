package entity;

public class Question {

    private int id;
    private String content;
    private String explaination;
    public boolean status;
    private boolean isDeleted;
    private Integer questionLevelId;
    private Integer subjectLessonId;
    private Integer subjectDimensionId;
    private String questionFormat;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getExplaination() {
        return explaination;
    }

    public void setExplaination(String explaination) {
        this.explaination = explaination;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public Integer getQuestionLevelId() {
        return questionLevelId;
    }

    public void setQuestionLevelId(Integer questionLevelId) {
        this.questionLevelId = questionLevelId;
    }

    public Integer getSubjectLessonId() {
        return subjectLessonId;
    }

    public void setSubjectLessonId(Integer subjectLessonId) {
        this.subjectLessonId = subjectLessonId;
    }

    public Integer getSubjectDimensionId() {
        return subjectDimensionId;
    }

    public void setSubjectDimensionId(Integer subjectDimensionId) {
        this.subjectDimensionId = subjectDimensionId;
    }

    public String getQuestionFormat() {
        return questionFormat;
    }

    public void setQuestionFormat(String questionFormat) {
        this.questionFormat = questionFormat;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public String getQuestionFormat() {
        return questionFormat;
    }

    public void setQuestionFormat(String questionFormat) {
        this.questionFormat = questionFormat;
    }
}
