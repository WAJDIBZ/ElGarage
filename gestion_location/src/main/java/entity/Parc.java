package entity;

import java.time.LocalDateTime;

public class Parc {
    private int codeParc;
    private String nomParc;
    private int capaciteMax;
    private String adresse;
    private Double latitude;
    private Double longitude;
    private String responsable;
    private String telResponsable;
    private String statut; // "ouvert", "fermé", "maintenance"
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

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
