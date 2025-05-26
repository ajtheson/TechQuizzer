package dto;

public class UserLoginDTO {
    private String email;
    private String password;
    private Boolean status;
    private Boolean active;
    private int roleId;

    public UserLoginDTO() {
    }

    public UserLoginDTO(String email, String password, Boolean status, Boolean active, int roleId) {
        this.email = email;
        this.password = password;
        this.status = status;
        this.active = active;
        this.roleId = roleId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
