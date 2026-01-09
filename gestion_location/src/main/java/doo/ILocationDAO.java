package doo;

import java.util.List;
import entity.Location;

public interface ILocationDAO {
    void ajouterLocation(Location l);
    List<Location> getAllLocations();
    void modifierLocation(Location l);
    void supprimerLocation(int id);
    Location getLocationById(int id);
}
