package model;

import java.util.Date;

public class User {
    private int id;
    private String username;
    private String password;
    private int roleId;
    private String phoneNumber;
    private String gender;
    private Date dob;
    private String identityCard;
    private String email;
    private String studentID;
    
    // Reference to Role object
    private Role role;
    
    public User() {
    }
    
    public User(int id, String username, String password, int roleId, String phoneNumber, 
                String gender, Date dob, String identityCard, String email, String studentID) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.dob = dob;
        this.identityCard = identityCard;
        this.email = email;
        this.studentID = studentID;
    }
    
    // Constructor with Role object
    public User(int id, String username, String password, int roleId, String phoneNumber, 
                String gender, Date dob, String identityCard, String email, String studentID, Role role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.dob = dob;
        this.identityCard = identityCard;
        this.email = email;
        this.studentID = studentID;
        this.role = role;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public int getRoleId() {
        return roleId;
    }
    
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public Date getDob() {
        return dob;
    }
    
    public void setDob(Date dob) {
        this.dob = dob;
    }
    
    public String getIdentityCard() {
        return identityCard;
    }
    
    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getStudentID() {
        return studentID;
    }
    
    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }
    
    public Role getRole() {
        return role;
    }
    
    public void setRole(Role role) {
        this.role = role;
    }
    
    @Override
    public String toString() {
        return "User{" + "id=" + id + ", username=" + username + ", roleId=" + roleId + 
               ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", dob=" + dob + 
               ", identityCard=" + identityCard + ", email=" + email + ", studentID=" + studentID + '}';
    }
}