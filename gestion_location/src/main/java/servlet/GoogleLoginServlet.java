package servlet;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeRequestUrl;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;

/**
 * Servlet pour initier le flux d''authentification Google OAuth2.
 * Redirige l''utilisateur vers l''�cran de consentement Google.
 */
@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String ENV_GOOGLE_CLIENT_ID = "GOOGLE_OAUTH_CLIENT_ID";
    private static final Collection<String> SCOPES = Arrays.asList(
        "https://www.googleapis.com/auth/userinfo.profile",
        "https://www.googleapis.com/auth/userinfo.email"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String clientId = System.getenv(ENV_GOOGLE_CLIENT_ID);
            if (clientId == null || clientId.isBlank()) {
                response.sendRedirect("Inscription.jsp?error=google_oauth_not_configured");
                return;
            }
            // Construire dynamiquement l''URL de callback
            String callbackUrl = String.format("%s://%s:%d%s/GoogleOAuthCallback",
                request.getScheme(),
                request.getServerName(),
                request.getServerPort(),
                request.getContextPath()
            );

            String authorizationUrl = new GoogleAuthorizationCodeRequestUrl(
                    clientId, callbackUrl, SCOPES)
                .setState("state_parameter_passthrough_value")
                .build();

            request.getSession(true).setAttribute("googleOAuthPending", true);
            response.sendRedirect(authorizationUrl);
        } catch (Exception e) {
            System.err.println("Erreur lors de la redirection vers Google: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("Inscription.jsp?error=google_auth_error");
        }
    }
}
