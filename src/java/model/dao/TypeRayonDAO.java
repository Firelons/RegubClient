/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Region;
import entities.Typerayon;
import java.util.ArrayList;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Lons
 */
public class TypeRayonDAO {
    
    
        public static List<Typerayon> Rayonliste() {

        List<Typerayon> listrayon = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            //"from Rayon as Ra WHERE EXISTS ( FROM Magasin as Ma WHERE Ma.rayon = Ra ) "
            String hql = "select distinct f.typerayons from Magasin f";
            Query query = session.createQuery(hql);
            listrayon = query.list();
            //System.out.println(listrayon);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listrayon;
    }
        
         public static List<Typerayon> RayonPrec(String tr) {
        
        int typerayon = Integer.parseInt(tr);
        List<Typerayon> listrayons = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Typerayon as Re where idTypeRayon= ? ";
            Query query = session.createQuery(hql);
            query.setParameter(0, typerayon);
            listrayons = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listrayons;
    }
    
        public static List<Typerayon> Rayons() {
        
        
        List<Typerayon> rayons = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Typerayon as R ";
            Query query = session.createQuery(hql);
            rayons = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rayons;
    }  
     
        
        public static List<Typerayon> addRayon(Typerayon ray) {
         
        List<Typerayon> list = new ArrayList<Typerayon>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        
            session.beginTransaction();
            session.save(ray);
            session.getTransaction().commit();
            
       
        session.close();
        return list;
    }
          public static Typerayon getRayon(Integer IdRayon) {

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Typerayon ray = (Typerayon) session.load(Typerayon.class, IdRayon);
            System.out.println(ray);
            return ray;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
       
   
       
    
        public boolean deleteRayon(Integer idRay) {

        List<Typerayon> list = new ArrayList<Typerayon>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Typerayon suppray = (Typerayon) session.load(Typerayon.class, idRay);
            session.beginTransaction();
            session.delete(suppray);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return false;
    }
        
        public Typerayon updRayon(Integer id, String lib) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            Typerayon updray = (Typerayon) session.load(Typerayon.class, id);
            updray.setLibelle(lib);
            session.update(updray);
            session.getTransaction().commit();
            return updray;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
    
  
}
