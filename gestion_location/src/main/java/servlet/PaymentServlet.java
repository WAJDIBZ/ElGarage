package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stripe.Stripe;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import dao.RendezVousDAO;
import doo.ClientDAO;
import doo.LocationDAO;
import doo.VoitureDAO;
import entity.Client;
import entity.Location;
import entity.Voiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import service.payment.*;
import util.SingletonConnex;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("method");

        // Validate and parse locationId
        String locationIdParam = request.getParameter("locationId");
        System.out.println("Location ID: " + locationIdParam);
        int locationId;
        try {
            locationId = Integer.parseInt(locationIdParam);
        } catch (NumberFormatException | NullPointerException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("success", false);
            errorResponse.put("error", "Missing or invalid locationId.");
            response.getWriter().write(errorResponse.toString());
            return;
        }

        // Validate and parse clientId
        String clientIdParam = request.getParameter("clientId");
        int clientId;
        System.out.println("Client ID: " + clientIdParam);
        try {
            clientId = Integer.parseInt(clientIdParam);
        } catch (NumberFormatException | NullPointerException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("success", false);
            errorResponse.put("error", "Missing or invalid clientId.");
            response.getWriter().write(errorResponse.toString());
            return;
        }

        Map<String, String> data = new HashMap<>();
        data.put("rendezVousDate", request.getParameter("rendezVousDate"));
        data.put("dateDebut", request.getParameter("dateDebut"));
        data.put("telephone", request.getParameter("telephone"));
        data.put("ncin", request.getParameter("ncin"));
        data.put("adresse", request.getParameter("adresse"));
        Connection connection = SingletonConnex.getConnection();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Initialize Stripe API key from environment (do not hardcode secrets)
        String stripeSecretKey = System.getenv("STRIPE_SECRET_KEY");
        if (stripeSecretKey != null && !stripeSecretKey.isBlank()) {
            Stripe.apiKey = stripeSecretKey;
        }

        try {
            if ("stripe".equals(method)) {
            if (Stripe.apiKey == null || Stripe.apiKey.isBlank()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject errorResponse = new JSONObject();
                errorResponse.put("success", false);
                errorResponse.put("error", "Stripe is not configured. Set STRIPE_SECRET_KEY environment variable.");
                response.getWriter().write(errorResponse.toString());
                return;
            }
                // Store the locationId in the metadata to retrieve it after payment success
                SessionCreateParams params = SessionCreateParams.builder()
                        .setMode(SessionCreateParams.Mode.PAYMENT)
                        .setSuccessUrl(
                                request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                        + request.getContextPath() + "/success.jsp?locationId=" + locationId)
                        .setCancelUrl(request.getScheme() + "://" + request.getServerName() + ":"
                                + request.getServerPort() + request.getContextPath() + "/cancel.jsp")
                        .putMetadata("locationId", String.valueOf(locationId))
                        .addLineItem(
                                SessionCreateParams.LineItem.builder()
                                        .setQuantity(1L)
                                        .setPriceData(
                                                SessionCreateParams.LineItem.PriceData.builder()
                                                        .setCurrency("usd")
                                                        .setUnitAmount(1000L) // Amount in cents
                                                        .setProductData(
                                                                SessionCreateParams.LineItem.PriceData.ProductData
                                                                        .builder()
                                                                        .setName("Payment for location " + locationId)
                                                                        .build())
                                                        .build())
                                        .build())
                        .build();

                Session session = Session.create(params);

                // Return session ID as JSON
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("id", session.getId());
                response.getWriter().write(jsonResponse.toString());
            } else {
                // Handle other payment methods
                PaymentService paymentService = new PaymentService(
                        new AgencyPaymentStrategy(new RendezVousDAO(connection)));
                paymentService.processPayment(locationId, clientId, data);

                // Return success response as JSON
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Paiement réussi.");
                response.getWriter().write(jsonResponse.toString());
            }
        } catch (Exception e) {
            // Return error response as JSON
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("success", false);
            errorResponse.put("error", e.getMessage());
            response.getWriter().write(errorResponse.toString());
        }
    }
}
