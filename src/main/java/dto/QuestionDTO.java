package dto;

public class QuestionDTO {
    private int id;
    private String content;
    private String explaination;
    private boolean status;
    private boolean isDeleted;
    private Integer questionLevelId;
    private Integer subjectLessonId;
    private Integer subjectDimensionId;
    private String questionFormat;
    private int subjectId;
    private String subjectName;
    private String questionDimensionName;
    private String subjectLessonName;
    private String questionLevelName;

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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getExplaination() {
        return explaination;
    }

    public void setExplaination(String explaination) {
        this.explaination = explaination;
    }

    public boolean getIsDeleted() {
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

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getQuestionDimensionName() {
        return questionDimensionName;
    }

    public void setQuestionDimensionName(String questionDimensionName) {
        this.questionDimensionName = questionDimensionName;
    }

    public String getSubjectLessonName() {
        return subjectLessonName;
    }

    public void setSubjectLessonName(String subjectLessonName) {
        this.subjectLessonName = subjectLessonName;
    }

    public String getQuestionLevelName() {
        return questionLevelName;
    }

    public void setQuestionLevelName(String questionLevelName) {
        this.questionLevelName = questionLevelName;
    }
}
