package doo;

import entity.Client;
import entity.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

public class UserDAO {
    
    /** Récupère l'utilisateur par username */
    public User findByUsername(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM User u WHERE u.username = :username";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("username", username);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean addUser(User u) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Si un clientId est défini, récupérer la référence au client
            if (u.getClientId() != null && u.getClient() == null) {
                Client client = session.get(Client.class, u.getClientId());
                u.setClient(client);
            }
            
            session.persist(u);
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
}
