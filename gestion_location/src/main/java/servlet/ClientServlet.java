package servlet;

import java.io.IOException;
import doo.ClientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Client;

public class ClientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ClientDAO clientDAO = new ClientDAO();
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
          
            String ncin = request.getParameter("ncin");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String numTel = request.getParameter("numTel");
            String adresse = request.getParameter("adresse");
            String email = request.getParameter("email");

            Client client = new Client();
            client.setNcin(ncin);
            client.setNom(nom);
            client.setPrenom(prenom);
            client.setNumTel(numTel);
            client.setAdresse(adresse);
            client.setEmail(email);

            clientDAO.ajouterClient(client);
        } 
        else if ("modifier".equals(action)) {
           
            int codeClient = Integer.parseInt(request.getParameter("codeClient"));
            String ncin = request.getParameter("ncin");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String numTel = request.getParameter("numTel");
            String adresse = request.getParameter("adresse");
            String email = request.getParameter("email");

            Client client = new Client();
            client.setCodeClient(codeClient);
            client.setNcin(ncin);
            client.setNom(nom);
            client.setPrenom(prenom);
            client.setNumTel(numTel);
            client.setAdresse(adresse);
            client.setEmail(email);

            clientDAO.modifierClient(client);
        } 
        else if ("supprimer".equals(action)) {
          
            int codeClient = Integer.parseInt(request.getParameter("codeClient"));
            clientDAO.supprimerClient(codeClient);
        }

        response.sendRedirect("GererClient.jsp");
    }
}
