package doo;

import entity.Parc;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ParcDAO {
    
    /** Récupère tous les parcs */
    public List<Parc> getAllParcs() {
        List<Parc> list = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            list = session.createQuery("FROM Parc", Parc.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /** Récupère un parc par son code */
    public Parc getParcById(int codeParc) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Parc.class, codeParc);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /** Ajoute un nouveau parc */
    public boolean addParc(Parc p) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Définir les dates de création et mise à jour
            if (p.getCreatedAt() == null) {
                p.setCreatedAt(LocalDateTime.now());
            }
            if (p.getUpdatedAt() == null) {
                p.setUpdatedAt(LocalDateTime.now());
            }
            
            session.persist(p);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    
    /** Met à jour un parc existant */
    public boolean updateParc(Parc p) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Mettre à jour la date de mise à jour
            p.setUpdatedAt(LocalDateTime.now());
            
            session.merge(p);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    
    /** Supprime un parc */
    public boolean deleteParc(int codeParc) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Parc parc = session.get(Parc.class, codeParc);
            if (parc != null) {
                session.remove(parc);
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
