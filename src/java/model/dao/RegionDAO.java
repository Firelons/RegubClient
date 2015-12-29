/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;
import entities.Region;
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
            String hql = "from Region as Re WHERE EXISTS ( FROM Magasin as Ma WHERE Ma.region = Re) ";
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
}
