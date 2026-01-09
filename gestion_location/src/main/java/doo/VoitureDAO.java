package doo;

import entity.Voiture;
import util.SingletonConnex;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class VoitureDAO implements IvoitureDAO {

    public void ajouterVoiture(Voiture v) {
    	 Connection connection = SingletonConnex.getConnection();
        try  {
            String query = "INSERT INTO voiture (matricule, marque, modele, kilometrage, speed, acceleration, typeEnergie, image,tarif) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, v.getMatricule());
            stmt.setString(2, v.getMarque());
            stmt.setString(3, v.getModele());
            stmt.setInt(4, v.getKilometrage());
            stmt.setInt(5, v.getSpeed());
            stmt.setDouble(6, v.getAcceleration());
            stmt.setString(7, v.getTypeEnergie());
            stmt.setString(8, v.getImage());
            stmt.setDouble(9, v.getTarif());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Voiture ajoutée avec succès !");
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur d'ajout voiture : " + e.getMessage());
        }
    }

    public List<Voiture> getAllVoitures() {
        List<Voiture> voitures = new ArrayList<>();
         Connection connection = SingletonConnex.getConnection();
        try  {
            String query = "SELECT * FROM voiture";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Voiture v = new Voiture();
                v.setMatricule(rs.getString("matricule"));
                v.setMarque(rs.getString("marque"));
                v.setModele(rs.getString("modele"));
                v.setKilometrage(rs.getInt("kilometrage"));
                v.setSpeed(rs.getInt("speed"));
                v.setAcceleration(rs.getDouble("acceleration"));
                v.setTypeEnergie(rs.getString("typeEnergie"));
                v.setImage(rs.getString("image"));
                v.setTarif(rs.getDouble("tarif"));
                voitures.add(v);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la récupération des voitures : " + e.getMessage());
        }
        return voitures;
    }

    public void modifierVoiture(Voiture v) {
    	 Connection connection = SingletonConnex.getConnection();
        try  {
            String query = "UPDATE voiture SET marque=?, modele=?, kilometrage=?, speed=?, acceleration=?, typeEnergie=?, image=? , tarif=? WHERE matricule=?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, v.getMarque());
            stmt.setString(2, v.getModele());
            stmt.setInt(3, v.getKilometrage());
            stmt.setInt(4, v.getSpeed());
            stmt.setDouble(5, v.getAcceleration());
            stmt.setString(6, v.getTypeEnergie());
            stmt.setString(7, v.getImage());
            stmt.setDouble(8, v.getTarif());
            stmt.setString(9, v.getMatricule());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("✅ Voiture modifiée avec succès !");
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur de modification voiture : " + e.getMessage());
        }
    }

    public void supprimerVoiture(String matricule) {
    	 Connection connection = SingletonConnex.getConnection();
        try  {
            String query = "DELETE FROM voiture WHERE matricule=?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, matricule);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("✅ Voiture supprimée avec succès !");
            }
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur de suppression voiture : " + e.getMessage());
        }
    }

    public Voiture getVoitureByMatricule(String matricule) {
    	 Connection connection = SingletonConnex.getConnection();
        Voiture v = null;
        try  {
            String query = "SELECT * FROM voiture WHERE matricule=?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, matricule);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                v = new Voiture();
                v.setMatricule(rs.getString("matricule"));
                v.setMarque(rs.getString("marque"));
                v.setModele(rs.getString("modele"));
                v.setKilometrage(rs.getInt("kilometrage"));
                v.setSpeed(rs.getInt("speed"));
                v.setAcceleration(rs.getDouble("acceleration"));
                v.setTypeEnergie(rs.getString("typeEnergie"));
                v.setImage(rs.getString("image"));
                v.setTarif(rs.getDouble("tarif"));
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur lors de la recherche de la voiture : " + e.getMessage());
        }
        return v;
    }
    public List<Voiture> getAvailableVoitures(String marque, String modele, Date dateDebut, Date dateFin) {
        List<Voiture> list = new ArrayList<>();
        String sql = """
        SELECT * FROM voiture v
         WHERE v.marque = ?
           AND v.modele = ?
           AND v.matricule NOT IN (
             SELECT l.matricule
               FROM location l
              WHERE NOT (l.dateFin < ? OR l.dateDebut > ?)
           )
        """;
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, marque);
            ps.setString(2, modele);
            ps.setDate(3, dateDebut);
            ps.setDate(4, dateFin);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voiture v = new Voiture();
                v.setMatricule(rs.getString("matricule"));
                v.setMarque(rs.getString("marque"));
                v.setModele(rs.getString("modele"));
                v.setKilometrage(rs.getInt("kilometrage"));
                v.setSpeed(rs.getInt("speed"));
                v.setAcceleration(rs.getDouble("acceleration"));
                v.setTypeEnergie(rs.getString("typeEnergie"));
                v.setImage(rs.getString("image"));
                v.setTarif(rs.getDouble("tarif"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAllMarques() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT marque FROM voiture";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String marque = rs.getString("marque");
                list.add(marque);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Voiture> rechercherVehiculesDisponibles(String marque, String modele, String dateDebut, String dateFin) {
        boolean hasMarque = marque != null && !marque.isBlank();
        boolean hasModele = modele != null && !modele.isBlank();
        boolean hasDates = dateDebut != null && !dateDebut.isBlank() && dateFin != null && !dateFin.isBlank();

        // Si aucun filtre n'est fourni (cas d'arrivée sur la page), on affiche toutes les voitures.
        if (!hasMarque && !hasModele && !hasDates) {
            return getAllVoitures();
        }

        Date dDebut = null;
        Date dFin = null;
        if (hasDates) {
            try {
                dDebut = Date.valueOf(dateDebut);
                dFin = Date.valueOf(dateFin);
            } catch (IllegalArgumentException ex) {
                // Format de date inattendu → on ignore le filtre des dates au lieu de renvoyer 0 résultat.
                hasDates = false;
            }
        }

        List<Voiture> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM voiture v WHERE 1=1");
        if (hasMarque) {
            sql.append(" AND v.marque = ?");
        }
        if (hasModele) {
            sql.append(" AND v.modele = ?");
        }
        if (hasDates) {
            sql.append(" AND NOT EXISTS (\n");
            sql.append("   SELECT 1 FROM location l\n");
            sql.append("    WHERE l.matricule = v.matricule\n");
            sql.append("      AND NOT (l.dateFin < ? OR l.dateDebut > ?)\n");
            sql.append(" )");
        }

        Connection c = SingletonConnex.getConnection();
        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int i = 1;
            if (hasMarque) {
                ps.setString(i++, marque);
            }
            if (hasModele) {
                ps.setString(i++, modele);
            }
            if (hasDates) {
                ps.setDate(i++, dDebut);
                ps.setDate(i++, dFin);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Voiture v = new Voiture();
                    v.setMatricule(rs.getString("matricule"));
                    v.setMarque(rs.getString("marque"));
                    v.setModele(rs.getString("modele"));
                    v.setKilometrage(rs.getInt("kilometrage"));
                    v.setSpeed(rs.getInt("speed"));
                    v.setAcceleration(rs.getDouble("acceleration"));
                    v.setTypeEnergie(rs.getString("typeEnergie"));
                    v.setImage(rs.getString("image"));
                    v.setTarif(rs.getDouble("tarif"));
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }
    public List<String> getModelesParMarque(String marque) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT modele FROM voiture WHERE marque = ?";
        Connection c = SingletonConnex.getConnection();
        try (
                PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, marque);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String modele = rs.getString("modele");
                list.add(modele);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}