/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;
import entities.Region;
import java.util.ArrayList;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
/**
 *
 * @author Lons
 */
public class RegionDAO {
    public static List<Region> Regionliste() {

        List<Region> listregion = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Region as Re WHERE EXISTS ( FROM Magasin as Ma WHERE Ma.region = Re ) ";
            Query query = session.createQuery(hql);
            listregion = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listregion;
    }
    
    public static List<Region> RegionPrec(String reg) {
        
        int region = Integer.parseInt(reg);
        List<Region> listregion = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Region as Re where IdRegion= ? ";
            Query query = session.createQuery(hql);
            query.setParameter(0, region);
            listregion = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listregion;
    }
               public static List<Region> listregion() {

        List<Region> lst = null;
        //Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Region";
            Query query = session.createQuery(hql);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //session.close();
        
        return lst;
    }
       
    public static List<Region> addRegion(Region reg) {
         System.out.println("TST:");
        List<Region> list = new ArrayList<Region>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        
            session.beginTransaction();
            session.save(reg);
            session.getTransaction().commit();
            
       
        session.close();
        return list;
    }
    
    public Region updRegion(Integer id, String lib) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            Region updreg = (Region) session.load(Region.class, id);
            updreg.setLibelle(lib);
            session.update(updreg);
            session.getTransaction().commit();
            return updreg;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
     
      public  Region getRegion(Integer IdRegion) {

        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Region reg = (Region) session.load(Region.class, IdRegion);
            System.out.println(reg);
            return reg;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
