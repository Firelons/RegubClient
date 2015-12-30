/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Compte;
import entities.Typecompte;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Clock;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author batchanou
 */
public class AdministrateurDAO {

    Session session = null;

    public Compte connexion(String login, String password) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        ArrayList<Compte> list = new ArrayList<Compte>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Compte as cpt where cpt.login=? and cpt.password=SHA2( CONCAT( ? , cpt.salt),256)");
            query.setParameter(0, login);
            query.setParameter(1, password);
            list = (ArrayList<Compte>) query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ((list.size() > 0)) {
            return list.get(0);
        }

        session.close();
        return null;
    }

    public List<Compte> compteUser() {
        ArrayList<Compte> list = new ArrayList<Compte>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Compte");

            list = (ArrayList<Compte>) query.list();
            if (list.size() > 0) {

                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
    /*public List<Typecompte> typeCompteUser(){
        ArrayList<Typecompte> list = new ArrayList<Typecompte>();
        
        try{
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from typecompte");
            list = (ArrayList<Typecompte>) query.list();
            
            if (list.size() > 0) {
                return list;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }*/
   
 
    public String encode(String mdp) {
        return sha256(mdp);
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
    
    public boolean addCompte(Compte compte){
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            session.save(compte);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        
        return false;
    
    }
    public Compte selectCompte(String login){
         ArrayList<Compte> list = new ArrayList<Compte>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Compte as cpt where cpt.login=?");
            query.setParameter(0, login);
            list = (ArrayList<Compte>) query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ((list.size() > 0)) {
            return list.get(0);
        }
        session.close();
        return null;
    }
    public boolean updateCompte(int id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Compte cpt = new Compte();
        
        try {
            session.beginTransaction();
            cpt.setIdCompte(id);
            session.update(cpt);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        
        return false;
    }
    public boolean deleteCompte(Compte compte){
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            session.delete(compte);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        
        return false;
    }
}

