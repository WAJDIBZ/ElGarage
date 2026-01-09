package entity;

public class User {
    private int    userId;
    private String username;
    private String passwordHash;
    private String role;      // "ADMIN" ou "CLIENT"
    private Integer clientId; // null si ADMIN


    public User() {
    }
    public User(int userId, String username, String passwordHash, String role, Integer clientId) {
        this.userId     = userId;
        this.username   = username;
        this.passwordHash = passwordHash;
        this.role       = role;
        this.clientId   = clientId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPasswordHash() {
        return passwordHash;
    }
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public Integer getClientId() {
        return clientId;
    }
    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", role='" + role + '\'' +
                ", clientId=" + clientId +
                '}';
    }
}
