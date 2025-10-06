package com.example.asmnews.entity;

import java.util.Date;

/**
 * Entity class cho bảng Users
 * Đại diện cho người dùng (phóng viên và quản trị viên)
 */
public class User {
    private String id;
    private String password;
    private String fullname;
    private Date birthday;
    private Boolean gender; // true: Nam, false: Nữ
    private String mobile;
    private String email;
    private Boolean role; // true: Quản trị, false: Phóng viên

    // Constructor mặc định
    public User() {
    }

    // Constructor có tham số
    public User(String id, String password, String fullname, Date birthday,
            Boolean gender, String mobile, String email, Boolean role) {
        this.id = id;
        this.password = password;
        this.fullname = fullname;
        this.birthday = birthday;
        this.gender = gender;
        this.mobile = mobile;
        this.email = email;
        this.role = role;
    }

    // Getter và Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getRole() {
        return role;
    }

    public void setRole(Boolean role) {
        this.role = role;
    }

    // Phương thức tiện ích
    public boolean isAdmin() {
        return role != null && role;
    }

    public boolean isReporter() {
        return role != null && !role;
    }

    public String getGenderText() {
        if (gender == null)
            return "Không xác định";
        return gender ? "Nam" : "Nữ";
    }

    public String getRoleText() {
        if (role == null)
            return "Không xác định";
        return role ? "Quản trị viên" : "Phóng viên";
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", fullname='" + fullname + '\'' +
                ", email='" + email + '\'' +
                ", role=" + getRoleText() +
                '}';
    }
}
