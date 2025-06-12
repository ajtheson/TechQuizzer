package entity;
import java.util.Date;
public class Subject {
    private Integer id;
    private String name;
    private String tagLine;
    private String thumbnail;
    private String shortDescription;
    private String longDescription;
    private Boolean featuredSubject;
    private Boolean published;
    private Integer categoryId;
    private Integer ownerId;
    private Date updateDate;

    public Subject() {
    }

    public Subject(Integer id, String name, String tagLine, String thumbnail, String shortDescription,
                   String longDescription, Boolean featuredSubject, Boolean published,
                   Integer categoryId, Integer ownerId, Date updateDate) {
        this.id = id;
        this.name = name;
        this.tagLine = tagLine;
        this.thumbnail = thumbnail;
        this.shortDescription = shortDescription;
        this.longDescription = longDescription;
        this.featuredSubject = featuredSubject;
        this.published = published;
        this.categoryId = categoryId;
        this.ownerId = ownerId;
        this.updateDate = updateDate;
    }
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
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

    public Boolean getFeaturedSubject() {
        return featuredSubject;
    }
    public void setFeaturedSubject(Boolean featuredSubject) {
        this.featuredSubject = featuredSubject;
    }

    public Boolean getPublished() {
        return published;
    }
    public void setPublished(Boolean published) {
        this.published = published;
    }

    public Integer getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getOwnerId() {
        return ownerId;
    }
    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public Date getUpdateDate() {
        return updateDate;
    }
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}
