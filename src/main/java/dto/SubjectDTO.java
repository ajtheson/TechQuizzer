package dto;

import java.time.LocalDateTime;

public class SubjectDTO {
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
    private double minListPrice;
    private double minSalePrice;
    private boolean isRegistered;

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

    public boolean isPublished() {
        return isPublished;
    }

    public void setPublished(boolean published) {
        isPublished = published;
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

    public double getMinListPrice() {
        return minListPrice;
    }

    public void setMinListPrice(double minListPrice) {
        this.minListPrice = minListPrice;
    }

    public double getMinSalePrice() {
        return minSalePrice;
    }

    public void setMinSalePrice(double minSalePrice) {
        this.minSalePrice = minSalePrice;
    }

    public LocalDateTime getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDateTime updateDate) {
        this.updateDate = updateDate;
    }

    public boolean getIsRegistered() {
        return isRegistered;
    }

    public void setRegistered(boolean registered) {
        isRegistered = registered;
    }
}
