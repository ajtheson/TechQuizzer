package dto;

public class UserDTO {
    private int id;
    private String email;
    private String password;
    private String name;
    private Boolean gender;
    private String mobile;
    private String avatar;
    private String address;
    private double balance;
    private int roleId;
    private String roleName;

    public UserDTO() {
    }

    public UserDTO(int id, String email, String password, String name, Boolean gender, String mobile, String avatar, String address, double balance, int roleId, String roleName) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.name = name;
        this.gender = gender;
        this.mobile = mobile;
        this.avatar = avatar;
        this.address = address;
        this.balance = balance;
        this.roleId = roleId;
        this.roleName = roleName;
    }

    // Getters and setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Boolean getGender() { return gender; }
    public void setGender(Boolean gender) { this.gender = gender; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}
