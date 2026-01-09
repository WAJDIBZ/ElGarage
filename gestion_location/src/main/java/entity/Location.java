package entity;

import java.sql.Date;

public class Location {
    private int id;
    private int codeClient;
    private String matricule;
    private Date dateDebut;
    private Date dateFin;
    private double montant; // Montant total de la location
    private String statut; // ex. "En cours", "Terminé"

    // Getters / Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCodeClient() { return codeClient; }
    public void setCodeClient(int codeClient) { this.codeClient = codeClient; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

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
                ", codeClient=" + codeClient +
                ", matricule='" + matricule + '\'' +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                ", montant=" + montant +
                ", statut='" + statut + '\'' +
                '}';
    }
}
