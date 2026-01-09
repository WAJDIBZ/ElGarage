package servlet;

import java.io.IOException;
import java.sql.Date;

import doo.LocationDAO;
import entity.Location;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LocationServlet")
public class LocationServlet extends HttpServlet {
    private final LocationDAO dao = new LocationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if (action == null || action.isEmpty()) {
                throw new IllegalArgumentException("Action parameter is missing.");
            }
            if ("supprimer".equals(action)) {
                String idl = req.getParameter("id");
                if (idl == null || idl.isEmpty()) {
                    throw new IllegalArgumentException("location parameter is missing or invalid for supprimer action.");
                }
                try {
                    int id = Integer.parseInt(idl);
                    System.out.println("Supprimer id: " + id);
                    dao.supprimerLocation(id);
                    resp.sendRedirect("GererLocations.jsp");
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Invalid number format for CodeClient: " );
                }
            } else if ("changerStatut".equals(action)) {
                String idStr = req.getParameter("id");
                String statut = req.getParameter("statut");
                if (idStr == null || statut == null) {
                    throw new IllegalArgumentException("ID ou statut manquant pour l'action changerStatut.");
                }
                try {
                    int id = Integer.parseInt(idStr);
                    Location location = dao.getLocationById(id);
                    if (location != null) {
                        location.setStatut(statut);
                        dao.modifierLocation(location);
                    }
                    resp.sendRedirect("GererLocations.jsp");
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Format d'ID invalide : " + idStr);
                }
                return; // Important to prevent falling through to the next block
            }


            String codeClientStr = req.getParameter("codeClient");
            String matricule = req.getParameter("matricule");
            String dateDebutStr = req.getParameter("dateDebut");
            String dateFinStr = req.getParameter("dateFin");
            String montantStr = req.getParameter("tarif");
            String statut = "En cours"; // Default value
            System.out.println("action: " + req.getParameter("action"));
            System.out.println("codeClient: " + req.getParameter("codeClient"));
            System.out.println("matricule: " + req.getParameter("matricule"));
            System.out.println("dateDebut: " + req.getParameter("dateDebut"));
            System.out.println("dateFin: " + req.getParameter("dateFin"));
            System.out.println("tarif: " + req.getParameter("tarif"));
            System.out.println("statut: " + req.getParameter("statut"));
            if (codeClientStr == null || codeClientStr.isBlank() ||
                    matricule == null || matricule.isBlank() ||
                    dateDebutStr == null || dateDebutStr.isBlank() ||
                    dateFinStr == null || dateFinStr.isBlank() ||
                    montantStr == null || montantStr.isBlank()) {
                throw new IllegalArgumentException("Paramètres manquants: veuillez choisir les dates et un véhicule avant de réserver.");
            }

            int codeClient = Integer.parseInt(codeClientStr);
            Date dDebut = Date.valueOf(dateDebutStr);
            Date dFin = Date.valueOf(dateFinStr);
            if (dFin.before(dDebut)) {
                throw new IllegalArgumentException("La date de fin doit être après la date de début.");
            }
            double mt = Double.parseDouble(montantStr);
            // calcul du montant
            final long millisPerDay = 1000L * 60 * 60 * 24;
            long diffMillis = dFin.getTime() - dDebut.getTime();
            long days = (long) Math.ceil(diffMillis / (double) millisPerDay);
            if (days < 1) {
                days = 1;
            }
            double montant = days * mt;

            Location l = new Location();
            l.setCodeClient(codeClient);
            l.setMatricule(matricule);
            l.setDateDebut(dDebut);
            l.setDateFin(dFin);
            l.setMontant(montant);
            l.setStatut(statut);

            if ("ajouter".equals(action)) {
                dao.ajouterLocation(l);
            }

            else {
                throw new IllegalArgumentException("Unsupported action: " + action);
            }
            HttpSession sess = req.getSession();
            Object clientIdObj = sess.getAttribute("clientId");
            String cd = clientIdObj != null ? String.valueOf(clientIdObj) : null;
            if (cd != null) {
                resp.sendRedirect("ClientDashboard.jsp");
            } else {
                resp.sendRedirect("GererLocations.jsp");
            }


        } catch (NumberFormatException e) {
            if (!resp.isCommitted()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format: " + e.getMessage());
            }
        } catch (IllegalArgumentException e) {
            if (!resp.isCommitted()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            }
        } catch (Exception e) {
            if (!resp.isCommitted()) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("GererLocations.jsp");
    }
}