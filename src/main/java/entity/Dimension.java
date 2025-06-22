package entity;

public class Dimension {
    private int id;
    private String type;
    private String name;
    private String description;
    private int subjectId;

    public Dimension() {
        this.type = "Domain";
    }

    public Dimension(int id, String type, String name, String description, int subjectId) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.description = description;
        this.subjectId = subjectId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
}
