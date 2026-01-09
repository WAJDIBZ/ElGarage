package entity;

public class Voiture {
    private String matricule;
    private String marque;
    private String modele;
    private int kilometrage;
    private int speed;
    private double acceleration;
    private String typeEnergie;
    private String Image;
    private double tarif;

    public Voiture() {
    }

    public Voiture(String matricule, String marque, String modele, int kilometrage,
                   int speed, double acceleration, String typeEnergie , String Image, double tarif) {
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
