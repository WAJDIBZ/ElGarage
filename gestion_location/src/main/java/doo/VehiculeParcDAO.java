package doo;

import entity.Voiture;
import entity.VehiculeParc;
import util.SingletonConnex;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehiculeParcDAO {

    /** Récupère l’historique complet d’un parc */
    public List<VehiculeParc> getHistoryByParc(int codeParc) {
        List<VehiculeParc> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicule_parc WHERE codeParc = ?";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, codeParc);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VehiculeParc vp = new VehiculeParc();
                    vp.setId(rs.getInt("id"));
                    vp.setMatricule(rs.getString("matricule"));
                    vp.setCodeParc(codeParc);
                    vp.setDateArrivee(rs.getTimestamp("dateArrivee").toLocalDateTime());
                    Timestamp t = rs.getTimestamp("dateDepart");
                    if (t != null) vp.setDateDepart(t.toLocalDateTime());
                    list.add(vp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Liste des véhicules actuellement présents (dateDepart IS NULL) */
    public List<Voiture> getActiveVehiclesByParc(int codeParc) {
        List<Voiture> list = new ArrayList<>();
        String sql = """
            SELECT v.* FROM voiture v
             JOIN vehicule_parc vp ON v.matricule = vp.matricule
             WHERE vp.codeParc = ? AND vp.dateDepart IS NULL
            """;
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, codeParc);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Voiture v = new Voiture();
                    v.setMatricule(rs.getString("matricule"));
                    v.setMarque   (rs.getString("marque"));
                    v.setModele   (rs.getString("modele"));
                    v.setKilometrage(rs.getInt("kilometrage"));
                    v.setSpeed    (rs.getInt("speed"));
                    v.setAcceleration(rs.getDouble("acceleration"));
                    v.setTypeEnergie (rs.getString("typeEnergie"));
                    v.setImage    (rs.getString("image"));
                    v.setTarif    (rs.getDouble("tarif"));
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Compte les véhicules actifs dans un parc */
    public int countActiveByParc(int codeParc) {
        String sql = "SELECT COUNT(*) FROM vehicule_parc WHERE codeParc = ? AND dateDepart IS NULL";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, codeParc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Enregistre l’arrivée d’un véhicule dans un parc */
    public boolean addArrival(String matricule, int codeParc) {
        String sql = "INSERT INTO vehicule_parc (matricule, codeParc, dateArrivee) VALUES (?, ?, NOW())";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, matricule);
            ps.setInt   (2, codeParc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Enregistre le départ (libération) d’un véhicule */
    public boolean addDeparture(int id) {
        String sql = "UPDATE vehicule_parc SET dateDepart = NOW() WHERE id = ?";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
