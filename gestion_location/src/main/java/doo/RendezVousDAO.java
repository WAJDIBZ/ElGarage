package doo;

import entity.RendezVous;
import util.SingletonConnex;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RendezVousDAO {
      public int ajouterRendezVous(RendezVous rv) {
        Connection connection = SingletonConnex.getConnection();
        int generatedId = -1;
        try {
            String query = "INSERT INTO rendezvous (location_id, client_id, phone, ncin, address, rendezvous_date) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);            stmt.setInt(1, rv.getLocationId());
            stmt.setInt(2, rv.getClientId());
            stmt.setString(3, rv.getPhone());
            stmt.setString(4, rv.getNcin());
            stmt.setString(5, rv.getAddress());
            stmt.setTimestamp(6, new Timestamp(rv.getRendezVousDate().getTime()));
            
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Rendez-vous ajouté avec succès !");
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
                rs.close();
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur d'ajout de rendez-vous: " + e.getMessage());
        }
        return generatedId;
    }
      public List<RendezVous> getRendezVousByClientId(String clientId) {
        List<RendezVous> rendezVousList = new ArrayList<>();
        Connection connection = SingletonConnex.getConnection();
        try {
            String query = "SELECT * FROM rendezvous WHERE client_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, clientId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                RendezVous rv = new RendezVous();
                rv.setId(rs.getInt("id"));
                rv.setLocationId(rs.getInt("location_id"));
                rv.setClientId(rs.getInt("client_id"));
                rv.setPhone(rs.getString("phone"));
                rv.setNcin(rs.getString("ncin"));
                rv.setAddress(rs.getString("address"));
                rv.setRendezVousDate(rs.getTimestamp("rendezvous_date"));
                rendezVousList.add(rv);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la récupération des rendez-vous: " + e.getMessage());
        }
        return rendezVousList;
    }
      public RendezVous getRendezVousById(int id) {
        RendezVous rv = null;
        Connection connection = SingletonConnex.getConnection();
        try {
            String query = "SELECT * FROM rendezvous WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                rv = new RendezVous();
                rv.setId(rs.getInt("id"));
                rv.setLocationId(rs.getInt("location_id"));
                rv.setClientId(rs.getInt("client_id"));
                rv.setPhone(rs.getString("phone"));
                rv.setNcin(rs.getString("ncin"));
                rv.setAddress(rs.getString("address"));
                rv.setRendezVousDate(rs.getTimestamp("rendezvous_date"));
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la récupération du rendez-vous: " + e.getMessage());
        }
        return rv;
    }
      public void supprimerRendezVous(int id) {
        Connection connection = SingletonConnex.getConnection();
        try {
            String query = "DELETE FROM rendezvous WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("✅ Rendez-vous supprimé avec succès !");
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la suppression du rendez-vous: " + e.getMessage());
        }
    }
}
