package doo;

import java.util.List;
import entity.Voiture;

public interface IvoitureDAO {
    void ajouterVoiture(Voiture v);
    List<Voiture> getAllVoitures();
    void modifierVoiture(Voiture v);
    void supprimerVoiture(String matricule);
//    Voiture getVoitureByMatricule(String matricule);
}
