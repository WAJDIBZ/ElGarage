package doo;

import entity.Client;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class ClientDAO implements Icoocli {

    @Override
    public void ajouterClient(Client c) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            transaction = session.beginTransaction();
            session.persist(c);
            transaction.commit();
            System.out.println("✅ Client ajouté avec succès !");
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            System.out.println("❌ Erreur d'ajout: " + e.getMessage());
        }
    }

    public int ajouterClientRetourId(Client c) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            transaction = session.beginTransaction();
            session.persist(c);
            transaction.commit();
            return c.getCodeClient(); // L'ID est automatiquement mis à jour après persist
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public List<Client> getAllClients() {
        List<Client> clients = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            System.out.println("🔍 Récupération des clients...");
            clients = session.createQuery("FROM Client", Client.class).list();
            System.out.println("✅ Nombre de clients récupérés: " + clients.size());
        } catch (Exception e) {
            System.out.println("❌ Erreur lors de la récupération des clients: " + e.getMessage());
        }
        return clients;
    }

    @Override
    public void modifierClient(Client c) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(c);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void supprimerClient(int codeClient) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Client client = session.get(Client.class, codeClient);
            if (client != null) {
                session.remove(client);
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
    public Client getClientById(String codeClient) {
        Client client = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            int id = Integer.parseInt(codeClient);
            client = session.get(Client.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return client;
    }
    
    // Méthode supplémentaire pour récupérer un client par ID (int)
    public Client getClientById(int codeClient) {
        Client client = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            client = session.get(Client.class, codeClient);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return client;
    }
}
