/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Region;
import entities.Typerayon;
import entities.Magasin;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Lons
 */
public class MagasinDAO {
     public static List<Magasin> MagPrec(Typerayon Tr, Region Re) {

        List<Magasin> listMag = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "select distinct Ma from Magasin Ma , Typerayon Tr, Region Re  where Ma in elements(?) and Ma in elements(?) " ;
            Query query = session.createQuery(hql);
            query.setParameter(0, Tr.getMagasins());
            query.setParameter(1, Re.getMagasins());
            listMag = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listMag;
    }

    public static List<Magasin> getmagasins(int id) {
         List<Magasin> lst = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Magasin as mag where mag.region.idRegion =?";
            Query query = session.createQuery(hql);
            query.setParameter(0, id);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        //session.close();
        return lst; 
    }
}
