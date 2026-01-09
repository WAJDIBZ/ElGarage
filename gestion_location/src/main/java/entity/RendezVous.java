package entity;

import java.util.Date;

/**
 * Entity class representing a RendezVous record.
 */
public class RendezVous {    private int id;
    private int locationId;
    private int clientId;
    private String phone;
    private String ncin;
    private String address;
    private Date rendezvousDate;
    private Date createdAt;

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNcin() {
        return ncin;
    }

    public void setNcin(String ncin) {
        this.ncin = ncin;
    }    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getRendezVousDate() {
        return rendezvousDate;
    }

    public void setRendezVousDate(Date rendezVousDate) {
        this.rendezvousDate = rendezVousDate;
    }
}
