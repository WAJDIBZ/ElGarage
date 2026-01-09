package doo;

import entity.Parc;
import util.SingletonConnex;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParcDAO {
    /** Récupère tous les parcs */
    public List<Parc> getAllParcs() {
        List<Parc> list = new ArrayList<>();
        String sql = "SELECT * FROM parc";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Parc p = new Parc();
                p.setCodeParc(rs.getInt("codeParc"));
                p.setNomParc(rs.getString("nomParc"));
                p.setCapaciteMax(rs.getInt("capaciteMax"));
                p.setAdresse(rs.getString("adresse"));
                p.setLatitude(rs.getObject("latitude", Double.class));
                p.setLongitude(rs.getObject("longitude", Double.class));
                p.setResponsable(rs.getString("responsable"));
                p.setTelResponsable(rs.getString("telResponsable"));
                p.setStatut(rs.getString("statut"));
                p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Récupère un parc par son code */
    public Parc getParcById(int codeParc) {
        Parc p = null;
        String sql = "SELECT * FROM parc WHERE codeParc = ?";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, codeParc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Parc();
                    p.setCodeParc(rs.getInt("codeParc"));
                    p.setNomParc(rs.getString("nomParc"));
                    p.setCapaciteMax(rs.getInt("capaciteMax"));
                    p.setAdresse(rs.getString("adresse"));
                    p.setLatitude(rs.getObject("latitude", Double.class));
                    p.setLongitude(rs.getObject("longitude", Double.class));
                    p.setResponsable(rs.getString("responsable"));
                    p.setTelResponsable(rs.getString("telResponsable"));
                    p.setStatut(rs.getString("statut"));
                    p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    /** Ajoute un nouveau parc */
    public boolean addParc(Parc p) {
        String sql = """
            INSERT INTO parc (nomParc, capaciteMax, adresse,
                              latitude, longitude,
                              responsable, telResponsable, statut)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getNomParc());
            ps.setInt   (2, p.getCapaciteMax());
            ps.setString(3, p.getAdresse());
            ps.setObject(4, p.getLatitude());
            ps.setObject(5, p.getLongitude());
            ps.setString(6, p.getResponsable());
            ps.setString(7, p.getTelResponsable());
            ps.setString(8, p.getStatut());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Met à jour un parc existant */
    public boolean updateParc(Parc p) {
        String sql = """
            UPDATE parc
               SET nomParc=?, capaciteMax=?, adresse=?,
                   latitude=?, longitude=?,
                   responsable=?, telResponsable=?, statut=?
             WHERE codeParc=?
            """;
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getNomParc());
            ps.setInt   (2, p.getCapaciteMax());
            ps.setString(3, p.getAdresse());
            ps.setObject(4, p.getLatitude());
            ps.setObject(5, p.getLongitude());
            ps.setString(6, p.getResponsable());
            ps.setString(7, p.getTelResponsable());
            ps.setString(8, p.getStatut());
            ps.setInt   (9, p.getCodeParc());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Supprime un parc */
    public boolean deleteParc(int codeParc) {
        String sql = "DELETE FROM parc WHERE codeParc = ?";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, codeParc);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
