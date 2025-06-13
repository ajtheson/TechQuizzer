package entity;

public class PricePackage {
    private int id;
    private String name;
    private Integer duration;
    private double listPrice;
    private double salePrice;
    private String description;
    private boolean status;
    private int subjectId;

    public PricePackage() {
    }

    public PricePackage(int id, String name, Integer duration, double listPrice, double salePrice, String description,
            boolean status, int subjectId) {
        this.id = id;
        this.name = name;
        this.duration = duration;
        this.listPrice = listPrice;
        this.salePrice = salePrice;
        this.description = description;
        this.status = status;
        this.subjectId = subjectId;
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

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public double getListPrice() {
        return listPrice;
    }

    public void setListPrice(double listPrice) {
        this.listPrice = listPrice;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
}
