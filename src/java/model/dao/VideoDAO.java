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

/**
 *
 * @author Mesmerus
 */
public class VideoDAO {

    public static List<Video> layDS(Integer idClient) {

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
        return lst;
    }
    
    public static List<Typerayon> Rayonliste() {

        List<Typerayon> listrayon = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Typerayon";
            Query query = session.createQuery(hql);
            listrayon = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listrayon;
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
    
    public static List<Region> Regionliste() {
    Session session = HibernateUtil.getSessionFactory().openSession();
        List<Region> listregion = null;
        try {
            
            String hql = "from Region";
            Query query = session.createQuery(hql);
            listregion = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return listregion;
        
    }
    
    public void addComContrat(Video vid) {
        System.out.println("TST: ouverture session");
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            //Session session = HibernateUtil.getSessionFactory().openSession();
            //Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            session.beginTransaction();
            session.save(vid);
            session.getTransaction().commit();
            //System.out.println("TST: ajout effectué");;
        } catch (Exception e) {
            e.printStackTrace();
        }
          finally {
            session.close();
        }
        //HibernateUtil.getSessionFactory().close();
        System.out.println("TST: fermeture session");
    }
    
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
        
        public  void updCliVideo(Video vid) {
         Session session = HibernateUtil.getSessionFactory().openSession();
        try {
           
            session.beginTransaction();
            session.update(vid);
            session.getTransaction().commit();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        
    }
        
        
}
