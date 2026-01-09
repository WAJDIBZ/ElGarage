package entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "parc")
public class Parc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codeparc")
    private int codeParc;
    
    @Column(name = "nomparc", nullable = false)
    private String nomParc;
    
    @Column(name = "capacitemax")
    private int capaciteMax;
    
    @Column(name = "adresse")
    private String adresse;
    
    @Column(name = "latitude")
    private Double latitude;
    
    @Column(name = "longitude")
    private Double longitude;
    
    @Column(name = "responsable")
    private String responsable;
    
    @Column(name = "telresponsable")
    private String telResponsable;
    
    @Column(name = "statut")
    private String statut; // "ouvert", "fermé", "maintenance"
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "parc", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<VehiculeParc> vehiculeParcs = new ArrayList<>();
    
    public Parc() {}
    
    // Getter / Setter
    public int getCodeParc() { return codeParc; }
    public void setCodeParc(int codeParc) { this.codeParc = codeParc; }
    public String getNomParc() { return nomParc; }
    public void setNomParc(String nomParc) { this.nomParc = nomParc; }
    public int getCapaciteMax() { return capaciteMax; }
    public void setCapaciteMax(int capaciteMax) { this.capaciteMax = capaciteMax; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }
    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
    public String getResponsable() { return responsable; }
    public void setResponsable(String responsable) { this.responsable = responsable; }
    public String getTelResponsable() { return telResponsable; }
    public void setTelResponsable(String telResponsable) { this.telResponsable = telResponsable; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public List<VehiculeParc> getVehiculeParcs() {
        return vehiculeParcs;
    }
    
    public void setVehiculeParcs(List<VehiculeParc> vehiculeParcs) {
        this.vehiculeParcs = vehiculeParcs;
    }
    
    @Override
    public String toString() {
        return "Parc{" +
                "codeParc=" + codeParc +
                ", nomParc='" + nomParc + '\'' +
                ", capaciteMax=" + capaciteMax +
                ", adresse='" + adresse + '\'' +
                ", statut='" + statut + '\'' +
                '}';
    }
}
