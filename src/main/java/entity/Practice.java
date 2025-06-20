package entity;

import java.util.List;

public class Practice {

    private int id;
    private String name;
    private int numberOfQuestions;
    private Integer subjectDimensionId;
    private Integer subjectLessonId;
    private int userId;
    private String format;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumberOfQuestions() {
        return numberOfQuestions;
    }

    public void setNumberOfQuestions(int numberOfQuestions) {
        this.numberOfQuestions = numberOfQuestions;
    }

    public Integer getSubjectDimensionId() {
        return subjectDimensionId;
    }

    public void setSubjectDimensionId(Integer subjectDimensionId) {
        this.subjectDimensionId = subjectDimensionId;
    }

    public Integer getSubjectLessonId() {
        return subjectLessonId;
    }

    public void setSubjectLessonId(Integer subjectLessonId) {
        this.subjectLessonId = subjectLessonId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}
