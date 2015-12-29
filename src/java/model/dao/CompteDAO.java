/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Compte;
import java.security.MessageDigest;
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

    public static Compte updateCommercial(Compte cpt) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            Compte updcompt = (Compte) session.load(Compte.class, cpt.getIdCompte());
            updcompt.setNom(cpt.getNom());
            updcompt.setPrenom(cpt.getPrenom());
            updcompt.setLogin(cpt.getLogin());
            updcompt.setPassword(cpt.getPassword());
            session.update(updcompt);
            session.getTransaction().commit();
            return updcompt;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return null;
    }

    public static String encode(String mdp, String sel) {
        return sha256(mdp.concat(sel));
    }

    public static String sha256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }
}
