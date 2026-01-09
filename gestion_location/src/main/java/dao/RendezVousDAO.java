package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import entity.RendezVous;

/**
 * DAO class for managing RendezVous records.
 */
public class RendezVousDAO {
    private final Connection connection;

    public RendezVousDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * Saves a RendezVous record to the database.
     *
     * @param rv The RendezVous entity to save.
     * @throws SQLException If a database error occurs.
     */
    public void save(RendezVous rv) throws SQLException {
        String sql = "INSERT INTO RendezVous (location_id, client_id, phone, ncin, address, rendezvous_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, rv.getLocationId());
            stmt.setInt(2, rv.getClientId());
            stmt.setString(3, rv.getPhone());
            stmt.setString(4, rv.getNcin());
            stmt.setString(5, rv.getAddress());
            stmt.setDate(6, new java.sql.Date(rv.getRendezVousDate().getTime()));
            stmt.executeUpdate();
        }
    }
}
