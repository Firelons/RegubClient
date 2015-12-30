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
    
    public static List<Region> Regionliste() {

        List<Region> listregion = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Region";
            Query query = session.createQuery(hql);
            listregion = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listregion;
    }
    
    public static Video modifcontrat(Integer idContrat) {
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
        
        public static void updCliVideo(Video vid) {
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
