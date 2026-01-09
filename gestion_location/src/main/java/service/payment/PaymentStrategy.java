package service.payment;

import java.util.Map;

/**
 * Interface for payment strategies.
 */
public interface PaymentStrategy {
    void pay(int locationId, int clientId, Map<String, String> data) throws Exception;
}
