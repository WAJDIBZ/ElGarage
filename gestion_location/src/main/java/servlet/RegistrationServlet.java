package servlet;

import doo.ClientDAO;
import doo.UserDAO;
import entity.Client;
import entity.User;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String hashMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashed = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashed) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom      = request.getParameter("nom");
        String prenom   = request.getParameter("prenom");
        String email    = request.getParameter("email");
        String numTel   = request.getParameter("numTel");
        String ncin     = request.getParameter("ncin");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        // 1) Vérifier les mots de passe
        if (!password.equals(confirm)) {
            response.sendRedirect("Inscription.jsp?error=Les mots de passe ne correspondent pas");
            return;
        }

        // 2) Créer le client
        Client c = new Client();
        c.setNom(nom);
        c.setPrenom(prenom);
        c.setEmail(email);
        c.setNumTel(numTel);
        c.setNcin(ncin);
        c.setAdresse("");  // si tu enregistres adresse, sinon vide
        ClientDAO clientDao = new ClientDAO();
        int codeClient = clientDao.ajouterClientRetourId(c);
        if (codeClient <= 0) {
            response.sendRedirect("Inscription.jsp?error=Erreur lors de la création du client");
            return;
        }

        // 3) Créer l’utilisateur
        User u = new User();
        u.setUsername(username);
        u.setPasswordHash(hashMD5(password));
        u.setRole("CLIENT");
        u.setClientId(codeClient);

        UserDAO userDao = new UserDAO();
        boolean ok = userDao.addUser(u);
        if (!ok) {
            response.sendRedirect("Inscription.jsp?error=Login déjà utilisé");
            return;
        }

        // 4) Redirection vers login
        response.sendRedirect("index.jsp?message=inscription_ok");
    }
}
