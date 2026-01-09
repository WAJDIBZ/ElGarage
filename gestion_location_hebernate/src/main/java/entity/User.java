package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int userId;
    
    @Column(name = "username", unique = true, nullable = false)
    private String username;
    
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    
    @Column(name = "role", nullable = false)
    private String role;      // "ADMIN" ou "CLIENT"
    
    @OneToOne
    @JoinColumn(name = "client_id")
    private Client client;
    
    public User() {
    }
    
    public User(int userId, String username, String passwordHash, String role, Integer clientId) {
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        // clientId sera géré via setClient
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
    
    public Client getClient() {
        return client;
    }
    
    public void setClient(Client client) {
        this.client = client;
    }
    
    // Pour compatibilité avec le code existant
    public Integer getClientId() {
        return client != null ? client.getCodeClient() : null;
    }
    
    public void setClientId(Integer clientId) {
        // Cette méthode sera remplacée par setClient dans le nouveau code
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", role='" + role + '\'' +
                ", clientId=" + (client != null ? client.getCodeClient() : null) +
                '}';
    }
}
