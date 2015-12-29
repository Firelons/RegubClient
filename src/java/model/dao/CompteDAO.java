/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;
import entities.Compte;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
/**
 *
 * @author Lons
 */
public class CompteDAO {
    public static List<Compte> RegionCompte() {

        List<Compte> listcompte = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Compte";
            Query query = session.createQuery(hql);
            listcompte = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listcompte;
    }
}