package doo;

import entity.Location;
import util.SingletonConnex;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO implements ILocationDAO {

    @Override
    public void ajouterLocation(Location l) {
        String sql = "INSERT INTO location (codeClient, matricule, dateDebut, dateFin, montant, statut) VALUES (?,?,?,?,?,?)";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, l.getCodeClient());
            ps.setString(2, l.getMatricule());
            ps.setDate(3, l.getDateDebut());
            ps.setDate(4, l.getDateFin());
            ps.setDouble(5, l.getMontant());
            ps.setString(6, "En cours");
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Location> getLocationsByClient(String codeClient) {
        String sql = "SELECT * FROM location WHERE codeClient=? ORDER BY dateDebut DESC";
        // … exécution, mapping en List<Location> …
        List<Location> list = new ArrayList<>();
        Connection c = SingletonConnex.getConnection();
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, codeClient);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Location l = new Location();
                l.setId(rs.getInt("id"));
                l.setCodeClient(rs.getInt("codeClient"));
                l.setMatricule(rs.getString("matricule"));
                l.setDateDebut(rs.getDate("dateDebut"));
                l.setDateFin(rs.getDate("dateFin"));
                l.setMontant(rs.getDouble("montant"));
                l.setStatut(rs.getString("statut"));
                list.add(l);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    @Override
    public List<Location> getAllLocations() {
        List<Location> list = new ArrayList<>();
        String sql = "SELECT * FROM location";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Location l = new Location();
                l.setId(rs.getInt("id"));
                l.setCodeClient(rs.getInt("codeClient"));
                l.setMatricule(rs.getString("matricule"));
                l.setDateDebut(rs.getDate("dateDebut"));
                l.setDateFin(rs.getDate("dateFin"));
                l.setMontant(rs.getDouble("montant"));
                l.setStatut(rs.getString("statut"));
                list.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void modifierLocation(Location l) {
        String sql = "UPDATE location SET codeClient=?, matricule=?, dateDebut=?, dateFin=?, montant=?, statut=? WHERE id=?";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, l.getCodeClient());
            ps.setString(2, l.getMatricule());
            ps.setDate(3, l.getDateDebut());
            ps.setDate(4, l.getDateFin());
            ps.setDouble(5, l.getMontant());
            ps.setString(6, l.getStatut());
            ps.setInt(7, l.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void supprimerLocation(int id) {
        String sql = "DELETE FROM location WHERE id=?";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Location getLocationById(int id) {
        String sql = "SELECT * FROM location WHERE id=?";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Location l = new Location();
                    l.setId(id);
                    l.setCodeClient(rs.getInt("codeClient"));
                    l.setMatricule(rs.getString("matricule"));
                    l.setDateDebut(rs.getDate("dateDebut"));
                    l.setDateFin(rs.getDate("dateFin"));
                    l.setMontant(rs.getDouble("montant"));
                    l.setStatut(rs.getString("statut"));
                    return l;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates the status of a location.
     *
     * @param locationId The ID of the location to update
     * @param status     The new status
     * @return true if the update was successful, false otherwise
     */
    public boolean updateLocationStatus(int locationId, String status) {
        String sql = "UPDATE location SET statut=? WHERE id=?";
        Connection c = SingletonConnex.getConnection();
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, locationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
