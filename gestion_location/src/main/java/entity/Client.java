package entity;
public class Client {

    private int codeClient;

    private String ncin;
    private String nom;
    private String prenom;
    private String numTel;
    private String adresse;
    private String email;

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
}
