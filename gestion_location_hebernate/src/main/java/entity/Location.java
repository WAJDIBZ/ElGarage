package entity;

import jakarta.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "location")
public class Location {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    
    @ManyToOne
    @JoinColumn(name = "codeclient", nullable = false)
    private Client client;
    
    @ManyToOne
    @JoinColumn(name = "matricule", nullable = false)
    private Voiture voiture;
    
    @Column(name = "datedebut")
    private Date dateDebut;
    
    @Column(name = "datefin")
    private Date dateFin;
    
    @Column(name = "montant")
    private double montant;
    
    @Column(name = "statut")
    private String statut;
    
    // Getters / Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    // Remplacer les getters/setters pour codeClient et matricule par client et voiture
    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }
    
    public Voiture getVoiture() { return voiture; }
    public void setVoiture(Voiture voiture) { this.voiture = voiture; }
    
    // Pour compatibilité avec le code existant
    public int getCodeClient() { return client != null ? client.getCodeClient() : 0; }
    public void setCodeClient(int codeClient) {
        // Cette méthode sera remplacée par setClient dans le nouveau code
    }
    
    public String getMatricule() { return voiture != null ? voiture.getMatricule() : null; }
    public void setMatricule(String matricule) {
        // Cette méthode sera remplacée par setVoiture dans le nouveau code
    }
    
    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }
    
    public double getMontant() { return montant; }
    public void setMontant(double montant) { this.montant = montant; }
    
    public Date getDateFin() { return dateFin; }
    public void setDateFin(Date dateFin) { this.dateFin = dateFin; }
    
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    
    public String toString() {
        return "Location{" +
                "id=" + id +
                ", client=" + (client != null ? client.getCodeClient() : "null") +
                ", voiture=" + (voiture != null ? voiture.getMatricule() : "null") +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                ", montant=" + montant +
                ", statut='" + statut + '\'' +
                '}';
    }
}
