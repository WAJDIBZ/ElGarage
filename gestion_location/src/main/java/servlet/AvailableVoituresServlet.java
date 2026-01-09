package servlet;

import entity.Voiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import  doo.VoitureDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/AvailableVoitures")
public class AvailableVoituresServlet extends HttpServlet {
    private final VoitureDAO dao = new VoitureDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String marque = req.getParameter("marque");
        String modele = req.getParameter("modele");
        Date dateDebut = Date.valueOf(req.getParameter("debut"));
        Date dateFin   = Date.valueOf(req.getParameter("fin"));

        List<Voiture> dispo = dao.getAvailableVoitures(marque, modele, dateDebut, dateFin);
        req.setAttribute("dispo", dispo);
        req.getRequestDispatcher("voituresDisponibles.jsp")
                .forward(req, resp);
    }

}
