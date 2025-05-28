package entity;

import java.time.LocalDateTime;

public class User {
    private int id;
    private String email;
    private String password;
    private String name;
    private Boolean gender;
    private String mobile;
    private String avatar;
    private String address;
    private Boolean status;
    private double balance;
    private Boolean activate;
    private String token;
    private LocalDateTime tokenCreateAt;
    private LocalDateTime tokenSendAt;
    private int roleId;
    private int wrongPasswordAttempts;
    private LocalDateTime passwordChangeLockedUntil;

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Boolean getActivate() {
        return activate;
    }

    public void setActivate(Boolean activate) {
        this.activate = activate;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getTokenCreateAt() {
        return tokenCreateAt;
    }

    public void setTokenCreateAt(LocalDateTime tokenCreateAt) {
        this.tokenCreateAt = tokenCreateAt;
    }

    public LocalDateTime getTokenSendAt() {
        return tokenSendAt;
    }

    public void setTokenSendAt(LocalDateTime tokenSendAt) {
        this.tokenSendAt = tokenSendAt;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getWrongPasswordAttempts() {
        return wrongPasswordAttempts;
    }

    public void setWrongPasswordAttempts(int wrongPasswordAttempts) {
        this.wrongPasswordAttempts = wrongPasswordAttempts;
    }

    public LocalDateTime getPasswordChangeLockedUntil() {
        return passwordChangeLockedUntil;
    }

    public void setPasswordChangeLockedUntil(LocalDateTime passwordChangeLockedUntil) {
        this.passwordChangeLockedUntil = passwordChangeLockedUntil;
    }

}
