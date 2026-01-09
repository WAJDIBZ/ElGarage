package entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "client")
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodeClient")
    private int codeClient;
    
    @Column(name = "ncin", unique = true, nullable = false)
    private String ncin;
    
    @Column(name = "nom", nullable = false)
    private String nom;
    
    @Column(name = "prenom", nullable = false)
    private String prenom;
    
    @Column(name = "numtel")
    private String numTel;
    
    @Column(name = "adresse")
    private String adresse;
    
    @Column(name = "email", unique = true)
    private String email;
    
    @OneToMany(mappedBy = "client", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Location> locations = new ArrayList<>();
    
    @OneToOne(mappedBy = "client", cascade = CascadeType.ALL, orphanRemoval = true)
    private User user;
    
    public int getCodeClient() { return codeClient; }
    public void setCodeClient(int codeClient) { this.codeClient = codeClient; }
    public String getNcin() { return ncin; }
    public void setNcin(String ncin) { this.ncin = ncin; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public String getNumTel() { return numTel; }
    public void setNumTel(String numTel) { this.numTel = numTel; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public List<Location> getLocations() {
        return locations;
    }
    
    public void setLocations(List<Location> locations) {
        this.locations = locations;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
}
