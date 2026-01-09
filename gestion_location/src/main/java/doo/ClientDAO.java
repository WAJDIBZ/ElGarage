package doo;

import entity.Client;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.SingletonConnex;

public class ClientDAO implements Icoocli {
    
    @Override
    public void ajouterClient(Client c) {
        Connection connection = SingletonConnex.getConnection();
        try {
            String query = "INSERT INTO client (ncin, nom, prenom, numTel, adresse, email) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, c.getNcin());
            stmt.setString(2, c.getNom());
            stmt.setString(3, c.getPrenom());
            stmt.setString(4, c.getNumTel());
            stmt.setString(5, c.getAdresse());
            stmt.setString(6, c.getEmail());
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Client ajouté avec succès !");
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur d'ajout: " + e.getMessage());
        }
    }
    public int ajouterClientRetourId(Client c) {
        String sql = "INSERT INTO client (ncin, nom, prenom, numTel, adresse, email) VALUES (?,?,?,?,?,?)";
        Connection conn = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getNcin());
            ps.setString(2, c.getNom());
            ps.setString(3, c.getPrenom());
            ps.setString(4, c.getNumTel());
            ps.setString(5, c.getAdresse());
            ps.setString(6, c.getEmail());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override

    public List<Client> getAllClients() {
        List<Client> clients = new ArrayList<>();
        Connection connection = SingletonConnex.getConnection();
        try {
            System.out.println("🔍 Récupération des clients...");
            String query = "SELECT * FROM client";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Client c = new Client();
                c.setCodeClient(rs.getInt("codeClient"));
                c.setNcin(rs.getString("ncin"));
                c.setNom(rs.getString("nom"));
                c.setPrenom(rs.getString("prenom"));
                c.setNumTel(rs.getString("numTel"));
                c.setAdresse(rs.getString("adresse"));
                c.setEmail(rs.getString("email"));
                clients.add(c);
            }
            rs.close();
            stmt.close();
            System.out.println("✅ Nombre de clients récupérés: " + clients.size());
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la récupération des clients: " + e.getMessage());
        }
        return clients;
    }
    @Override
    public void modifierClient(Client c) {
        Connection connection = SingletonConnex.getConnection();
        if (connection != null) {
            try {
                String query = "UPDATE client SET ncin=?, nom=?, prenom=?, numTel=?, adresse=?, email=? WHERE CodeClient=?";
                PreparedStatement stmt = connection.prepareStatement(query);
                stmt.setString(1, c.getNcin());
                stmt.setString(2, c.getNom());
                stmt.setString(3, c.getPrenom());
                stmt.setString(4, c.getNumTel());
                stmt.setString(5, c.getAdresse());
                stmt.setString(6, c.getEmail());
                stmt.setInt(7, c.getCodeClient());

                stmt.executeUpdate();
                stmt.close();
           
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void supprimerClient(int codeClient) {
        Connection connection = SingletonConnex.getConnection();
        if (connection != null) {
            try {
                String query = "DELETE FROM client WHERE CodeClient=?";
                PreparedStatement stmt = connection.prepareStatement(query);
                stmt.setInt(1, codeClient);

                stmt.executeUpdate();
                stmt.close();
           
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    @Override
    
    public Client getClientById(String codeClient) {
        Client client = null;
        Connection connection = SingletonConnex.getConnection();
        if (connection != null) {
            try {
                String query = "SELECT * FROM client WHERE CodeClient=?";
                PreparedStatement stmt = connection.prepareStatement(query);
                stmt.setString(1, codeClient);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    client = new Client();
                    client.setCodeClient(rs.getInt("CodeClient"));
                    client.setNcin(rs.getString("ncin"));
                    client.setNom(rs.getString("nom"));
                    client.setPrenom(rs.getString("prenom"));
                    client.setNumTel(rs.getString("numTel"));
                    client.setAdresse(rs.getString("adresse"));
                    client.setEmail(rs.getString("email"));
                }
                stmt.close();
               
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return client;
    }

}
