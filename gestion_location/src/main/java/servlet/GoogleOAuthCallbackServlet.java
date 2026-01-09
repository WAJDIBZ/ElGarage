package servlet;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

import doo.ClientDAO;
import doo.UserDAO;
import entity.Client;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Collections;

/**
 * Servlet qui g�re le callback OAuth de Google.
 */
@WebServlet("/GoogleOAuthCallback")
public class GoogleOAuthCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String ENV_GOOGLE_CLIENT_ID = "GOOGLE_OAUTH_CLIENT_ID";
    private static final String ENV_GOOGLE_CLIENT_SECRET = "GOOGLE_OAUTH_CLIENT_SECRET";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("googleOAuthPending") == null) {
            response.sendRedirect("Inscription.jsp?error=invalid_oauth_state");
            return;
        }
        
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.sendRedirect("Inscription.jsp?error=no_auth_code");
            return;
        }

        String clientId = System.getenv(ENV_GOOGLE_CLIENT_ID);
        String clientSecret = System.getenv(ENV_GOOGLE_CLIENT_SECRET);
        if (clientId == null || clientId.isBlank() || clientSecret == null || clientSecret.isBlank()) {
            response.sendRedirect("Inscription.jsp?error=google_oauth_not_configured");
            return;
        }
        
        try {
            String redirectUri = String.format("%s://%s:%d%s/GoogleOAuthCallback",
                request.getScheme(),
                request.getServerName(),
                request.getServerPort(),
                request.getContextPath()
            );
            
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    new NetHttpTransport(), 
                    GsonFactory.getDefaultInstance(),
                    "https://oauth2.googleapis.com/token",
                    clientId,
                    clientSecret,
                    code,
                    redirectUri)
                    .execute();
            
            String idTokenString = tokenResponse.getIdToken();
            
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    new NetHttpTransport(), GsonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(clientId))
                    .build();
                    
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken == null) {
                throw new ServletException("ID token invalide");
            }
            
            GoogleIdToken.Payload payload = idToken.getPayload();
            String email = payload.getEmail();
            String firstName = (String) payload.get("given_name");
            String lastName = (String) payload.get("family_name");
            
            session.removeAttribute("googleOAuthPending");
            
            UserDAO userDAO = new UserDAO();
            User existingUser = userDAO.findByUsername(email);
            
            if (existingUser != null) {
                session.setAttribute("username", email);
                session.setAttribute("role", existingUser.getRole());
                session.setAttribute("userId", existingUser.getUserId());
                session.setAttribute("clientId", existingUser.getClientId());
                
                response.sendRedirect("ClientDashboard.jsp");
            } else {
                Client newClient = new Client();
                newClient.setEmail(email);
                newClient.setNom(lastName != null ? lastName : "");
                newClient.setPrenom(firstName != null ? firstName : "");
                newClient.setNumTel("");
                newClient.setNcin("");
                newClient.setAdresse("");
                
                ClientDAO clientDAO = new ClientDAO();
                int clientId = clientDAO.ajouterClientRetourId(newClient);
                
                if (clientId > 0) {
                    User newUser = new User();
                    newUser.setUsername(email);
                    String randomPassword = generateRandomPassword();
                    newUser.setPasswordHash(hashMD5(randomPassword));
                    newUser.setRole("CLIENT");
                    newUser.setClientId(clientId);
                    
                    if (userDAO.addUser(newUser)) {
                        User createdUser = userDAO.findByUsername(email);
                        
                        session.setAttribute("username", email);
                        session.setAttribute("role", "CLIENT");
                        session.setAttribute("userId", createdUser.getUserId());
                        session.setAttribute("clientId", clientId);
                        
                        response.sendRedirect("ClientDashboard.jsp");
                    } else {
                        response.sendRedirect("Inscription.jsp?error=user_creation_failed");
                    }
                } else {
                    response.sendRedirect("Inscription.jsp?error=client_creation_failed");
                }
            }
            
        } catch (Exception e) {
            System.err.println("Erreur lors de l''authentification Google: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("Inscription.jsp?error=google_auth_processing_error");
        }
    }
    
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        
        for (int i = 0; i < 12; i++) {
            int randomIndex = random.nextInt(chars.length());
            sb.append(chars.charAt(randomIndex));
        }
        
        return sb.toString();
    }
    
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
            return null;
        }
    }
}
