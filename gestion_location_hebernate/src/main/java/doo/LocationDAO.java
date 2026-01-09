package doo;

import entity.Client;
import entity.Location;
import entity.Voiture;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO implements ILocationDAO {
    
    @Override
    public void ajouterLocation(Location l) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Récupérer les références complètes aux entités liées
            if (l.getClient() == null && l.getCodeClient() > 0) {
                Client client = session.get(Client.class, l.getCodeClient());
                l.setClient(client);
            }
            
            if (l.getVoiture() == null && l.getMatricule() != null) {
                Voiture voiture = session.get(Voiture.class, l.getMatricule());
                l.setVoiture(voiture);
            }
            
            // Définir le statut par défaut si non spécifié
            if (l.getStatut() == null) {
                l.setStatut("En cours");
            }
            
            session.persist(l);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    public List<Location> getLocationsByClient(String codeClient) {
        List<Location> list = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            int clientId = Integer.parseInt(codeClient);
            String hql = "FROM Location l WHERE l.client.codeClient = :clientId ORDER BY l.dateDebut DESC";
            Query<Location> query = session.createQuery(hql, Location.class);
            query.setParameter("clientId", clientId);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public List<Location> getAllLocations() {
        List<Location> list = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            list = session.createQuery("FROM Location", Location.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public void modifierLocation(Location l) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Récupérer les références complètes aux entités liées si nécessaire
            if (l.getClient() == null && l.getCodeClient() > 0) {
                Client client = session.get(Client.class, l.getCodeClient());
                l.setClient(client);
            }
            
            if (l.getVoiture() == null && l.getMatricule() != null) {
                Voiture voiture = session.get(Voiture.class, l.getMatricule());
                l.setVoiture(voiture);
            }
            
            session.merge(l);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    @Override
    public void supprimerLocation(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Location location = session.get(Location.class, id);
            if (location != null) {
                session.remove(location);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    @Override
    public Location getLocationById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Location.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
