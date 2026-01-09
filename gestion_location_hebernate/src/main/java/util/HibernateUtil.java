package util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Classe utilitaire pour gérer la session Hibernate
 */
public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();
    
    private static SessionFactory buildSessionFactory() {
        try {
            // Créer le SessionFactory à partir de hibernate.cfg.xml
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Échec de la création initiale du SessionFactory : " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    
    public static void shutdown() {
        // Fermer les caches et les pools de connexion
        getSessionFactory().close();
    }
}
