package dto;

public class RegisterDTO {
    private String email;
    private String password;
    private String confirmPassword;
    private String name;
    private String genderString;
    private String mobile;
    private String address;

    public RegisterDTO(String email, String password, String confirmPassword, String name, String genderString, String mobile, String address) {
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.name = name;
        this.genderString = genderString;
        this.mobile = mobile;
        this.address = address;
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

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGenderString() {
        return genderString;
    }

    public void setGenderString(String genderString) {
        this.genderString = genderString;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isValidInput() {
        if (email == null || email.trim().isEmpty()) return false;
        if (password == null || password.trim().isEmpty()) return false;
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) return false;
        if (name == null || name.trim().isEmpty()) return false;
        if (genderString == null || genderString.trim().isEmpty()) return false;
        if (mobile == null || mobile.trim().isEmpty()) return false;
        return address != null && !address.trim().isEmpty();
    }

}
