package entity;

import java.time.LocalDateTime;

public class VehiculeParc {
    private int id;
    private String matricule;
    private int codeParc;
    private LocalDateTime dateArrivee;
    private LocalDateTime dateDepart;

    public VehiculeParc() {}

    // Getter / Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public int getCodeParc() { return codeParc; }
    public void setCodeParc(int codeParc) { this.codeParc = codeParc; }

    public LocalDateTime getDateArrivee() { return dateArrivee; }
    public void setDateArrivee(LocalDateTime dateArrivee) { this.dateArrivee = dateArrivee; }

    public LocalDateTime getDateDepart() { return dateDepart; }
    public void setDateDepart(LocalDateTime dateDepart) { this.dateDepart = dateDepart; }

    @Override
    public String toString() {
        return "VehiculeParc{" +
                "id=" + id +
                ", matricule='" + matricule + '\'' +
                ", codeParc=" + codeParc +
                ", dateArrivee=" + dateArrivee +
                ", dateDepart=" + dateDepart +
                '}';
    }
}
