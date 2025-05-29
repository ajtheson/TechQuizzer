package entity;

public class Setting {
    private int id;
    private String type;
    private String value;
    private String description;
    private int order;
    private boolean isActivated;

    public Setting(String type, String value, String description, int order, boolean isActivated) {
        this.type = type;
        this.value = value;
        this.description = description;
        this.order = order;
        this.isActivated = isActivated;
    }

    public Setting(int id, String type, String value, String description, int order, boolean isActivated) {
        this.id = id;
        this.type = type;
        this.value = value;
        this.description = description;
        this.order = order;
        this.isActivated = isActivated;
    }

    public Setting() {
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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public boolean isActivated() {
        return isActivated;
    }

    public void setActivated(boolean activated) {
        isActivated = activated;
    }
}
