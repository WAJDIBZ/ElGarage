package doo;

import entity.Parc;
import entity.Voiture;
import entity.VehiculeParc;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class VehiculeParcDAO {
    
    /** Récupère l'historique complet d'un parc */
    public List<VehiculeParc> getHistoryByParc(int codeParc) {
        List<VehiculeParc> list = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM VehiculeParc vp WHERE vp.parc.codeParc = :codeParc";
            Query<VehiculeParc> query = session.createQuery(hql, VehiculeParc.class);
            query.setParameter("codeParc", codeParc);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /** Liste des véhicules actuellement présents (dateDepart IS NULL) */
    public List<Voiture> getActiveVehiclesByParc(int codeParc) {
        List<Voiture> list = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT vp.voiture FROM VehiculeParc vp " +
                         "WHERE vp.parc.codeParc = :codeParc AND vp.dateDepart IS NULL";
            Query<Voiture> query = session.createQuery(hql, Voiture.class);
            query.setParameter("codeParc", codeParc);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /** Compte les véhicules actifs dans un parc */
    public int countActiveByParc(int codeParc) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(vp) FROM VehiculeParc vp " +
                         "WHERE vp.parc.codeParc = :codeParc AND vp.dateDepart IS NULL";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("codeParc", codeParc);
            Long count = query.uniqueResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    /** Enregistre l'arrivée d'un véhicule dans un parc */
    public boolean addArrival(String matricule, int codeParc) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Récupérer les références aux entités
            Voiture voiture = session.get(Voiture.class, matricule);
            Parc parc = session.get(Parc.class, codeParc);
            
            if (voiture != null && parc != null) {
                VehiculeParc vp = new VehiculeParc();
                vp.setVoiture(voiture);
                vp.setParc(parc);
                vp.setDateArrivee(LocalDateTime.now());
                
                session.persist(vp);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    
    /** Enregistre le départ (libération) d'un véhicule */
    public boolean addDeparture(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            VehiculeParc vp = session.get(VehiculeParc.class, id);
            if (vp != null) {
                vp.setDateDepart(LocalDateTime.now());
                session.merge(vp);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
}
