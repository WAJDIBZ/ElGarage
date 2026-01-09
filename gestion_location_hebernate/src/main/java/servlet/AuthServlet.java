package servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class AuthServlet extends HttpServlet {

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
            return null;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String adresse = request.getParameter("adresse");
        String password = request.getParameter("password");
        String hashedPassword = hashMD5(password);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_location", "root", "");

            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE username = ? AND passwordHash = ?");
            stmt.setString(1, adresse);
            stmt.setString(2, hashedPassword);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                int userId = rs.getInt("userId");
                Integer clientId = rs.getObject("clientId") != null ? rs.getInt("clientId") : null;

                HttpSession session = request.getSession();
                session.setAttribute("username", adresse);
                session.setAttribute("role", role);
                session.setAttribute("userId", userId);
                session.setAttribute("clientId", clientId);

                // O cookie d’identification
                Cookie userCookie = new Cookie("user", adresse);
                userCookie.setMaxAge(60 * 60 * 24); // 1 jour
                response.addCookie(userCookie);

                if ("ADMIN".equals(role)) {
                    response.sendRedirect("GererClient.jsp");
                } else if ("CLIENT".equals(role)) {
                    response.sendRedirect("ClientDashboard.jsp");
                } else {
                    response.sendRedirect("index.jsp?error=unknownrole");
                }
            } else {
                response.sendRedirect("index.jsp?error=1");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=exception");
        }
    }
}
