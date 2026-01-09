package servlet;

import entity.RendezVous;
import doo.RendezVousDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RendezVousServlet")
public class RendezVousServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("annuler".equals(action)) {
            annulerRendezVous(request, response);
        } else if ("ajouter".equals(action)) {
            ajouterRendezVous(request, response);
        }
    }
    
    private void annulerRendezVous(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rendezVousIdStr = request.getParameter("rendezVousId");
        
        if (rendezVousIdStr != null && !rendezVousIdStr.isEmpty()) {
            try {
                int rendezVousId = Integer.parseInt(rendezVousIdStr);
                RendezVousDAO rendezVousDAO = new RendezVousDAO();
                rendezVousDAO.supprimerRendezVous(rendezVousId);
                
                response.sendRedirect("MesRendezVous.jsp?message=success&action=annulation");
            } catch (NumberFormatException e) {
                response.sendRedirect("MesRendezVous.jsp?message=error&error=format");
            }
        } else {
            response.sendRedirect("MesRendezVous.jsp?message=error&error=missing");
        }
    }
    
    private void ajouterRendezVous(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        String locationIdStr = request.getParameter("locationId");
        String clientIdStr = request.getParameter("clientId");
        String telephone = request.getParameter("telephone");
        String ncin = request.getParameter("ncin");
        String adresse = request.getParameter("adresse");
        String rendezVousDateStr = request.getParameter("rendezVousDate");
        
        try {
            int locationId = Integer.parseInt(locationIdStr);
            int clientId = Integer.parseInt(clientIdStr);
            
            // Créer l'objet RendezVous
            RendezVous rendezVous = new RendezVous();
            rendezVous.setLocationId(locationId);
            rendezVous.setClientId(clientId);
            rendezVous.setPhone(telephone);
            rendezVous.setNcin(ncin);
            rendezVous.setAddress(adresse);
            
            // Convertir la date de string à java.util.Date
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date rendezVousDate = sdf.parse(rendezVousDateStr);
            rendezVous.setRendezVousDate(rendezVousDate);
            
            // Ajouter le rendez-vous
            RendezVousDAO rendezVousDAO = new RendezVousDAO();
            int id = rendezVousDAO.ajouterRendezVous(rendezVous);
            
            if (id > 0) {
                response.sendRedirect("ClientDashboard.jsp?message=success&action=rdv");
            } else {
                response.sendRedirect("ClientDashboard.jsp?message=error&error=insert");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ClientDashboard.jsp?message=error&error=" + e.getMessage());
        }
    }
}
