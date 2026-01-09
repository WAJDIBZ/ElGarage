package servlet;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
        "/GererClient.jsp",
        "/GererVehicules.jsp",
        "/GererParcs.jsp",
        "/GererCalendar.jsp",
        "/ClientDashboard.jsp"
})
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            // Pas connecté
            res.sendRedirect("index.jsp?error=session");
            return;
        }

        String role = (String) session.getAttribute("role");
        String uri = req.getRequestURI();

        // Règles d'accès par rôle
        if (uri.contains("GererClient.jsp") || uri.contains("GererVehicules.jsp") ||
                uri.contains("GererParcs.jsp") || uri.contains("GererCalendar.jsp")) {
            if (!"ADMIN".equals(role)) {
                res.sendRedirect("index.jsp?error=unauthorized");
                return;
            }
        } else if (uri.contains("ClientDashboard.jsp")) {
            if (!"CLIENT".equals(role)) {
                res.sendRedirect("index.jsp?error=unauthorized");
                return;
            }
        }

        // Si tout est bon, continuer
        chain.doFilter(request, response);
    }

    public void destroy() {}
}
