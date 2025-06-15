package entity;

import java.time.LocalDateTime;

public class Subject {
    private int id;
    private String name;
    private String tagLine;
    private String thumbnail;
    private String shortDescription;
    private String longDescription;
    private boolean isFeaturedSubject;
    private boolean isPublished;
    private int categoryId;
    private int ownerId;
    private LocalDateTime updateDate;

    public Subject() {
    }

    public Subject(int id, String name, String tagLine, String thumbnail, String shortDescription, String longDescription, boolean isFeaturedSubject, boolean isPublished, int categoryId, int ownerId, LocalDateTime updateDate) {
        this.id = id;
        this.name = name;
        this.tagLine = tagLine;
        this.thumbnail = thumbnail;
        this.shortDescription = shortDescription;
        this.longDescription = longDescription;
        this.isFeaturedSubject = isFeaturedSubject;
        this.isPublished = isPublished;
        this.categoryId = categoryId;
        this.ownerId = ownerId;
        this.updateDate = updateDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isPublished() {
        return isPublished;
    }

    public void setPublished(boolean published) {
        isPublished = published;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTagLine() {
        return tagLine;
    }
    
    public void setTagLine(String tagLine) {
        this.tagLine = tagLine;
    }

    public String getThumbnail() {
        return thumbnail;
    }
    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getShortDescription() {
        return shortDescription;
    }
    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getLongDescription() {
        return longDescription;
    }

    public void setLongDescription(String longDescription) {
        this.longDescription = longDescription;
    }

    public boolean isFeaturedSubject() {
        return isFeaturedSubject;
    }

    public void setFeaturedSubject(boolean featuredSubject) {
        isFeaturedSubject = featuredSubject;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public LocalDateTime getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDateTime updateDate) {
        this.updateDate = updateDate;
    }
}
