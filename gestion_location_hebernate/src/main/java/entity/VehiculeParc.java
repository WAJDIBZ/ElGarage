package entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "vehicule_parc")
public class VehiculeParc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    
    @ManyToOne
    @JoinColumn(name = "matricule", nullable = false)
    private Voiture voiture;
    
    @ManyToOne
    @JoinColumn(name = "codeparc", nullable = false)
    private Parc parc;
    
    @Column(name = "datearrivee")
    private LocalDateTime dateArrivee;
    
    @Column(name = "datedepart")
    private LocalDateTime dateDepart;
    
    public VehiculeParc() {}
    
    // Getter / Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public Voiture getVoiture() { return voiture; }
    public void setVoiture(Voiture voiture) { this.voiture = voiture; }
    
    public Parc getParc() { return parc; }
    public void setParc(Parc parc) { this.parc = parc; }
    
    // Pour compatibilité avec le code existant
    public String getMatricule() { return voiture != null ? voiture.getMatricule() : null; }
    public void setMatricule(String matricule) {
        // Cette méthode sera remplacée par setVoiture dans le nouveau code
    }
    
    public int getCodeParc() { return parc != null ? parc.getCodeParc() : 0; }
    public void setCodeParc(int codeParc) {
        // Cette méthode sera remplacée par setParc dans le nouveau code
    }
    
    public LocalDateTime getDateArrivee() { return dateArrivee; }
    public void setDateArrivee(LocalDateTime dateArrivee) { this.dateArrivee = dateArrivee; }
    
    public LocalDateTime getDateDepart() { return dateDepart; }
    public void setDateDepart(LocalDateTime dateDepart) { this.dateDepart = dateDepart; }
    
    @Override
    public String toString() {
        return "VehiculeParc{" +
                "id=" + id +
                ", voiture=" + (voiture != null ? voiture.getMatricule() : "null") +
                ", parc=" + (parc != null ? parc.getCodeParc() : 0) +
                ", dateArrivee=" + dateArrivee +
                ", dateDepart=" + dateDepart +
                '}';
    }
}
