package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "voiture")
public class Voiture {
    @Id
    @Column(name = "matricule", nullable = false)
    private String matricule;
    
    @Column(name = "marque", nullable = false)
    private String marque;
    
    @Column(name = "modele", nullable = false)
    private String modele;
    
    @Column(name = "kilometrage")
    private int kilometrage;
    
    @Column(name = "speed")
    private int speed;
    
    @Column(name = "acceleration")
    private double acceleration;
    
    @Column(name = "typeenergie")
    private String typeEnergie;
    
    @Column(name = "image")
    private String Image;
    
    @Column(name = "tarif")
    private double tarif;
    
    @OneToMany(mappedBy = "voiture", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<Location> locations = new java.util.ArrayList<>();
    
    @OneToMany(mappedBy = "voiture", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<VehiculeParc> vehiculeParcs = new java.util.ArrayList<>();
    
    public Voiture() {
    }
    
    public Voiture(String matricule, String marque, String modele, int kilometrage,
                   int speed, double acceleration, String typeEnergie, String Image, double tarif) {
        this.matricule = matricule;
        this.marque = marque;
        this.modele = modele;
        this.kilometrage = kilometrage;
        this.speed = speed;
        this.acceleration = acceleration;
        this.typeEnergie = typeEnergie;
        this.Image = Image;
        this.tarif = tarif;
    }
    
    public double getTarif() { return tarif; }
    public void setTarif(double tarif) { this.tarif = tarif; }
    public String getMatricule() {
        return matricule;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public String getMarque() {
        return marque;
    }
    public void setMarque(String marque) {
        this.marque = marque;
    }
    public String getModele() {
        return modele;
    }
    public void setModele(String modele) {
        this.modele = modele;
    }
    public int getKilometrage() {
        return kilometrage;
    }
    public void setKilometrage(int kilometrage) {
        this.kilometrage = kilometrage;
    }
    public int getSpeed() {
        return speed;
    }
    public void setSpeed(int speed) {
        this.speed = speed;
    }
    public double getAcceleration() {
        return acceleration;
    }
    public void setAcceleration(double acceleration) {
        this.acceleration = acceleration;
    }
    public String getTypeEnergie() {
        return typeEnergie;
    }
    public void setTypeEnergie(String typeEnergie) {
        this.typeEnergie = typeEnergie;
    }
    public String getImage() {
        return Image;
    }
    public void setImage(String image) {
        Image = image;
    }
    
    public java.util.List<Location> getLocations() {
        return locations;
    }
    
    public void setLocations(java.util.List<Location> locations) {
        this.locations = locations;
    }
    
    public java.util.List<VehiculeParc> getVehiculeParcs() {
        return vehiculeParcs;
    }
    
    public void setVehiculeParcs(java.util.List<VehiculeParc> vehiculeParcs) {
        this.vehiculeParcs = vehiculeParcs;
    }
    
    @Override
    public String toString() {
        return "Voiture{" +
                "matricule='" + matricule + '\'' +
                ", marque='" + marque + '\'' +
                ", modele='" + modele + '\'' +
                ", kilometrage=" + kilometrage +
                ", speed=" + speed +
                ", acceleration=" + acceleration +
                ", typeEnergie='" + typeEnergie + '\'' +
                '}';
    }
}
