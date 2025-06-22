package entity;

public class Lesson {

    private int id;
    private String name;
    private String topic;
    private int order;
    private String videoLink;
    private String content;
    private boolean status;
    private int subjectId;
    private Integer lessonTypeId;

    public Lesson() {
    }

    public Lesson(int id, String name, String topic, int order, String videoLink,
                  String content, boolean status, int subjectId, Integer lessonTypeId) {
        this.id = id;
        this.name = name;
        this.topic = topic;
        this.order = order;
        this.videoLink = videoLink;
        this.content = content;
        this.status = status;
        this.subjectId = subjectId;
        this.lessonTypeId = lessonTypeId;
    }

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

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
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

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public int getLessonTypeId() {
        return lessonTypeId;
    }

    public void setLessonTypeId(int lessonTypeId) {
        this.lessonTypeId = lessonTypeId;
    }
}
