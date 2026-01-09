package servlet;

import doo.VoitureDAO;
import entity.Voiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class VoitureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final VoitureDAO dao = new VoitureDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        // Tous les attributs
        String matricule = request.getParameter("matricule");
        String marque = request.getParameter("marque");
        String modele = request.getParameter("modele");
        String kilometrageStr = request.getParameter("kilometrage");
        String speedStr = request.getParameter("speed");
        String accelerationStr = request.getParameter("acceleration");
        String typeEnergie = request.getParameter("typeEnergie");
        String image = request.getParameter("image");
        String tarifStr = request.getParameter("tarif");
        double tarif = (tarifStr != null && !tarifStr.isEmpty()) ? Double.parseDouble(tarifStr) : 0.0;

        // Validate and parse numeric parameters
        int kilometrage = (kilometrageStr != null && !kilometrageStr.isEmpty()) 
                ? Integer.parseInt(kilometrageStr) : 0;
        int speed = (speedStr != null && !speedStr.isEmpty()) 
                ? Integer.parseInt(speedStr) : 0;
        double acceleration = (accelerationStr != null && !accelerationStr.isEmpty()) 
                ? Double.parseDouble(accelerationStr) : 0.0;

        if (matricule == null || matricule.isEmpty()) {
            matricule = "VEH-" + System.currentTimeMillis(); // Generate a unique matricule
            request.setAttribute("generatedMatricule", matricule);
        }

        Voiture v = new Voiture();
        v.setMatricule(matricule);
        v.setMarque(marque);
        v.setModele(modele);
        v.setKilometrage(kilometrage);
        v.setSpeed(speed);
        v.setAcceleration(acceleration);
        v.setTypeEnergie(typeEnergie);
        v.setImage(image);
        v.setTarif(tarif);

        if ("ajouter".equals(action)) {
            dao.ajouterVoiture(v);
        } else if ("modifier".equals(action)) {
            dao.modifierVoiture(v);
        } else if ("supprimer".equals(action)) {
            dao.supprimerVoiture(matricule);
        }

        response.sendRedirect("GererVehicules.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirige vers la liste si quelqu’un appelle en GET
        response.sendRedirect("GererVehicules.jsp");
    }
}
