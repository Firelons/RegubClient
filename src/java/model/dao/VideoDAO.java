/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Client;
import entities.Region;
import entities.Typerayon;
import entities.Video;
import java.util.ArrayList;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.SessionFactoryUtils;

/**
 *
 * @author Mesmerus
 */
public class VideoDAO {

    public static List<Video> layDS(Integer idClient) {
        //Session session = HibernateUtil.getSessionFactory().openSession();
        List<Video> lst = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Video as vid where vid.client.idClient =?";
            Query query = session.createQuery(hql);
            query.setParameter(0, idClient);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //session.close();
        return lst;
    }
    
    public static List<Typerayon> RayonSelect(Video vid) {
        
        List<Typerayon> listrayons = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "select distinct f.typerayons from Video f where f.idVideo=?";
            Query query = session.createQuery(hql);
            query.setParameter(0, vid.getIdVideo());
            listrayons = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listrayons;
    }
    
    //By T.serge
    //Methode effectuant l'insertion d'un contrat effectué par le com pour un client
    public void addComContrat(Video vid) {
        //System.out.println("TST: ouverture session");
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            session.save(vid);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        //HibernateUtil.getSessionFactory().close();
        //System.out.println("TST: fermeture session");
    }
    
    //By T.serge
    //Methode effectuant l'update d'un contrat pour un client fait par le com
    public void updComContrat(Video vid, String s) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            Video updcontrat = (Video) session.load(Video.class, vid.getIdVideo());
            if(s.equalsIgnoreCase("modifier")){
                updcontrat.setTitre(vid.getTitre());
                updcontrat.setFrequence(vid.getFrequence());
                updcontrat.setDuree(vid.getDuree());
                updcontrat.setDateDebut(vid.getDateDebut());
                updcontrat.setDateFin(vid.getDateFin());
                updcontrat.setDateReception(vid.getDateReception());
                updcontrat.setDateValidation(vid.getDateValidation());
                updcontrat.setStatut(vid.getStatut());
                updcontrat.setTarif(vid.getTarif());
                updcontrat.setRegions(vid.getRegions());
                updcontrat.setTyperayons(vid.getTyperayons());
            }
            if(s.equalsIgnoreCase("annuler")){
                updcontrat.setDateFin(vid.getDateFin());
            }
            
            session.update(updcontrat);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        //HibernateUtil.getSessionFactory().close();
    }
    
    public boolean deleteComContrat(Integer idContrat) {

        List<Client> list = new ArrayList<Client>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Video suppcontrat = (Video) session.load(Video.class, idContrat);
            session.beginTransaction();
            session.delete(suppcontrat);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return false;
    }
    
    //Methode appellée pour charger les infos d'un contrat
    public Video modifcontrat(Integer idContrat) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Video modif = (Video) session.load(Video.class, idContrat);
            return modif;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return null;
    }
    
    // Ajouté par Aurélien Touche pas Serge
        public boolean addcliVideo(Video vid) {
        System.out.println("TST:");
        
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            
            session.beginTransaction();
            session.save(vid);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return false;
    }
        
        public  Video updCliVideo(Video vid) {
         Session session = HibernateUtil.getSessionFactory().openSession();
        try {
           
            session.beginTransaction();
            Video updvid = (Video) session.load(Video.class, vid.getIdVideo());
            updvid.setTitre(vid.getTitre());
            updvid.setFrequence(vid.getFrequence());
            updvid.setDuree(vid.getDuree());
            updvid.setDateDebut(vid.getDateDebut());
            updvid.setDateFin(vid.getDateFin());
            updvid.setDateReception(vid.getDateReception());
            updvid.setDateValidation(vid.getDateValidation());
            updvid.setStatut(vid.getStatut());
            updvid.setTarif(vid.getTarif());
            session.update(updvid);
            session.getTransaction().commit();
            return updvid;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return null;
    }       
}
