package service.payment;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import java.util.Map;

/**
 * Payment strategy for Stripe payments.
 */
public class StripePaymentStrategy implements PaymentStrategy {
    @Override
    public void pay(int locationId, int clientId, Map<String, String> data) {
        System.out.println("Stripe chosen for location " + locationId);

        // Read secret key from environment variable (do not hardcode secrets)
        String stripeSecretKey = System.getenv("STRIPE_SECRET_KEY");
        if (stripeSecretKey == null || stripeSecretKey.isBlank()) {
            throw new IllegalStateException("Missing STRIPE_SECRET_KEY environment variable.");
        }
        Stripe.apiKey = stripeSecretKey;

        try {
            // Create a Checkout Session
            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl("http://localhost:8080/gestion_location/success.jsp")
                    .setCancelUrl("http://localhost:8080/gestion_location/cancel.jsp")
                    .addLineItem(
                            SessionCreateParams.LineItem.builder()
                                    .setQuantity(1L)
                                    .setPriceData(
                                            SessionCreateParams.LineItem.PriceData.builder()
                                                    .setCurrency("usd")
                                                    .setUnitAmount(1000L) // Amount in cents (e.g., $10.00)
                                                    .setProductData(
                                                            SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                    .setName("Payment for location " + locationId)
                                                                    .build())
                                                    .build())
                                    .build())
                    .build();

            Session session = Session.create(params);
            System.out.println("Checkout Session created: " + session.getUrl());

            // Return the session URL to the client
            data.put("checkoutUrl", session.getUrl());
        } catch (StripeException e) {
            System.err.println("Stripe payment failed: " + e.getMessage());
        }
    }
}
