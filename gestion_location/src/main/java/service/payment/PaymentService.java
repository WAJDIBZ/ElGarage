package service.payment;

import java.util.Map;

/**
 * Service for handling payments using different strategies.
 */
public class PaymentService {
    private PaymentStrategy strategy;

    public PaymentService(PaymentStrategy strategy) {
        this.strategy = strategy;
    }

    public void processPayment(int locationId, int clientId, Map<String, String> data) throws Exception {
        strategy.pay(locationId, clientId, data);
    }
}
