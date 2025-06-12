package entity;

public class Question {

    private int id;
    private String content;
    private String media;
    private String explaination;
    private int questionLevelId;
    private int subjectLessonId;
    private int subjectDimensionId;

    public int getSubjectDimensionId() {
        return subjectDimensionId;
    }

    public void setSubjectDimensionId(int subjectDimensionId) {
        this.subjectDimensionId = subjectDimensionId;
    }

    public int getSubjectLessonId() {
        return subjectLessonId;
    }

    public void setSubjectLessonId(int subjectLessonId) {
        this.subjectLessonId = subjectLessonId;
    }

    public int getQuestionLevelId() {
        return questionLevelId;
    }

    public void setQuestionLevelId(int questionLevelId) {
        this.questionLevelId = questionLevelId;
    }

    public String getExplaination() {
        return explaination;
    }

    public void setExplaination(String explaination) {
        this.explaination = explaination;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
