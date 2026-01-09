package service.payment;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import dao.RendezVousDAO;
import entity.RendezVous;

/**
 * Payment strategy for agency payments.
 */
public class AgencyPaymentStrategy implements PaymentStrategy {
    private RendezVousDAO rendezVousDAO;

    public AgencyPaymentStrategy(RendezVousDAO rendezVousDAO) {
        this.rendezVousDAO = rendezVousDAO;
    }

    @Override
    public void pay(int locationId, int clientId, Map<String, String> data) throws Exception {
        String rendezVousDateStr = data.get("rendezVousDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date rendezVousDate = sdf.parse(rendezVousDateStr);
        Date dateDebut = sdf.parse(data.get("dateDebut"));

        if (!rendezVousDate.before(dateDebut)) {
            throw new Exception("Rendez-vous date must be strictly before the start date.");
        }

        RendezVous rv = new RendezVous();
        rv.setLocationId(locationId);
        rv.setClientId(clientId);
        rv.setPhone(data.get("telephone"));
        rv.setNcin(data.get("ncin"));
        rv.setAddress(data.get("adresse"));
        rv.setRendezVousDate(rendezVousDate);

        rendezVousDAO.save(rv);
    }
}
