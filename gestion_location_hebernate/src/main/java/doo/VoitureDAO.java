package doo;

import entity.Voiture;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class VoitureDAO implements IvoitureDAO {

    @Override
    public void ajouterVoiture(Voiture v) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            transaction = session.beginTransaction();
            session.persist(v);
            transaction.commit();
            System.out.println("✅ Voiture ajoutée avec succès !");
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            System.out.println("❌ Erreur d'ajout: " + e.getMessage());
        }
    }

    @Override
    public List<Voiture> getAllVoitures() {
        List<Voiture> voitures = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            System.out.println("🔍 Récupération des voitures...");
            voitures = session.createQuery("FROM Voiture", Voiture.class).list();
            System.out.println("✅ Nombre de voitures récupérées: " + voitures.size());
        } catch (Exception e) {
            System.out.println("❌ Erreur lors de la récupération des voitures: " + e.getMessage());
        }
        return voitures;
    }

    @Override
    public void modifierVoiture(Voiture v) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();
            session.merge(v);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void supprimerVoiture(String matricule) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try{
            transaction = session.beginTransaction();
            Voiture voiture = session.get(Voiture.class, matricule);
            if (voiture != null) {
                session.remove(voiture);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }


    public Voiture getVoitureById(String matricule) {
        Voiture voiture = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            voiture = session.get(Voiture.class, matricule);
        } catch (Exception e) {
            System.out.println("❌ Erreur lors de la recherche de la voiture : " + e.getMessage());
        }
        return voiture;
    }


    public List<Voiture> getAvailableVoitures(String marque, String modele, Date dateDebut, Date dateFin) {
        List<Voiture> list = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            String hql = "FROM Voiture v WHERE v.marque = :marque AND v.modele = :modele " +
                    "AND v.matricule NOT IN (SELECT l.voiture.matricule FROM Location l " +
                    "WHERE NOT (l.dateFin < :dateDebut OR l.dateDebut > :dateFin))";
            
            Query<Voiture> query = session.createQuery(hql, Voiture.class);
            query.setParameter("marque", marque);
            query.setParameter("modele", modele);
            query.setParameter("dateDebut", dateDebut);
            query.setParameter("dateFin", dateFin);
            
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAllMarques() {
        List<String> list = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            String hql = "SELECT DISTINCT v.marque FROM Voiture v";
            Query<String> query = session.createQuery(hql, String.class);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Voiture> rechercherVehiculesDisponibles(String marque, String modele, String dateDebut, String dateFin) {
        boolean hasMarque = marque != null && !marque.isBlank();
        boolean hasModele = modele != null && !modele.isBlank();
        boolean hasDates = dateDebut != null && !dateDebut.isBlank() && dateFin != null && !dateFin.isBlank();

        // Cas d'arrivée sur la page (aucun filtre): afficher toutes les voitures.
        if (!hasMarque && !hasModele && !hasDates) {
            return getAllVoitures();
        }

        Date dDebut = null;
        Date dFin = null;
        if (hasDates) {
            try {
                dDebut = Date.valueOf(dateDebut);
                dFin = Date.valueOf(dateFin);
            } catch (IllegalArgumentException ex) {
                hasDates = false;
            }
        }

        List<Voiture> list = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            StringBuilder hql = new StringBuilder("FROM Voiture v WHERE 1=1");
            if (hasMarque) {
                hql.append(" AND v.marque = :marque");
            }
            if (hasModele) {
                hql.append(" AND v.modele = :modele");
            }
            if (hasDates) {
                hql.append(" AND v.matricule NOT IN (");
                hql.append("   SELECT l.voiture.matricule FROM Location l ");
                hql.append("    WHERE NOT (l.dateFin < :dateDebut OR l.dateDebut > :dateFin)");
                hql.append(" )");
            }

            Query<Voiture> query = session.createQuery(hql.toString(), Voiture.class);
            if (hasMarque) {
                query.setParameter("marque", marque);
            }
            if (hasModele) {
                query.setParameter("modele", modele);
            }
            if (hasDates) {
                query.setParameter("dateDebut", dDebut);
                query.setParameter("dateFin", dFin);
            }
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getModelesParMarque(String marque) {
        List<String> list = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try  {
            String hql = "SELECT DISTINCT v.modele FROM Voiture v WHERE v.marque = :marque";
            Query<String> query = session.createQuery(hql, String.class);
            query.setParameter("marque", marque);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public Voiture getVoitureByMatricule (String m) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Voiture voiture = null;
        try {
            String hql = "FROM Voiture v WHERE v.matricule = :matricule";
            Query<Voiture> query = session.createQuery(hql, Voiture.class);
            query.setParameter("matricule", m);
            voiture = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return voiture;
    }
}