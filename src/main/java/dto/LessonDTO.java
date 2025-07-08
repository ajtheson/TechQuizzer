package dto;


import entity.LessonType;

import entity.Subject;

public class LessonDTO {
    private int id;
    private String name;
    private int order;
    private String videoLink;
    private String topic;
    private String content;
    private boolean status;
    private Subject subject;
    private SubjectDTO subjectDTO;
    private LessonType lessonType;

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
    public int getOrder() {
        return order;
    }
    public void setOrder(int order) {
        this.order = order;
    }
    public String getVideoLink() {
        return videoLink;
    }
    public void setVideoLink(String videoLink) {
        this.videoLink = videoLink;
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
    public Subject getSubject() {
        return subject;
    }
    public void setSubject(Subject subject) {
        this.subject = subject;
    }
    public LessonType getLessonType() {
        return lessonType;
    }
    public void setLessonType(LessonType lessonType) {
        this.lessonType = lessonType;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public SubjectDTO getSubjectDTO() {
        return subjectDTO;
    }

    public void setSubjectDTO(SubjectDTO subjectDTO) {
        this.subjectDTO = subjectDTO;
    }
}
