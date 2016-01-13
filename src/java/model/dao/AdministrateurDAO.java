/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Compte;
import entities.Magasin;
import entities.Region;
import entities.Typecompte;
import entities.Typerayon;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Clock;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
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
    
    public List<Magasin> magasin(){
        ArrayList<Magasin> list = new ArrayList<Magasin>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Magasin");

            list = (ArrayList<Magasin>) query.list();
            if (list.size() > 0) {

                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
    
    public List<Region> region(){
        ArrayList<Region> list = new ArrayList<Region>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Region");

            list = (ArrayList<Region>) query.list();
            if (list.size() > 0) {

                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
    
    public List<Typerayon> typerayon(){
        ArrayList<Typerayon> list = new ArrayList<Typerayon>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Typerayon");

            list = (ArrayList<Typerayon>) query.list();
            if (list.size() > 0) {

                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        return null;
    }
    
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
    public boolean addMagasin(Magasin magasin){
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            session.save(magasin);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        
        return false;
    
    }
    
    public Compte selectCompte(int id){
         ArrayList<Compte> list = new ArrayList<Compte>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Compte as cpt where cpt.idCompte=?");
            query.setParameter(0, id);
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
    public Magasin selectMagasin(int id){
         ArrayList<Magasin> list = new ArrayList<Magasin>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Magasin as mag where mag.idMagasin=?");
            query.setParameter(0, id);
            list = (ArrayList<Magasin>) query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ((list.size() > 0)) {
            return list.get(0);
        }
        session.close();
        return null;
    }
    
    public Compte selectCompte1(String log){
         ArrayList<Compte> list = new ArrayList<Compte>();

        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("from Compte as cpt where cpt.login=?");
            query.setParameter(0, log);
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
    
 
    
    public boolean updateCompte(int id, String nom, String prenom, String login, Typecompte T){
        Session session = HibernateUtil.getSessionFactory().openSession();
        
        try {
            session.beginTransaction();
            Compte cpt = (Compte)session.load(Compte.class, id);
            cpt.setNom(nom);
            cpt.setPrenom(prenom);
            cpt.setLogin(login);
            cpt.setTypecompte(T);
            
            session.update(cpt);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        //HibernateUtil.getSessionFactory().close();
        
        return false;
    }
    public boolean updateMagasin(int id, Region R, String nom, String a1, String a2, String cp, String ville, Set trayon){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Set<Typerayon> typeR =  new HashSet<Typerayon>() ;
        Iterator<Typerayon> it = trayon.iterator();
        try {
           session.beginTransaction();
           
           Magasin mag = (Magasin)session.load(Magasin.class, id);
           mag.setNom(nom);        mag.setRegion(R);
           mag.setAddrLigne1(a1);  mag.setAddrLigne2(a2);
           mag.setCodePostal(cp);  mag.setVille(ville);
           
           /*typeR = mag.getTyperayons();
           if(! trayon.isEmpty()){
               while(it.hasNext()){
                   typeR.add(it.next());
               }
           }
           mag.setTyperayons(typeR);*/
           session.update(mag);
           session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        //HibernateUtil.getSessionFactory().close();
        
        return false;
    }
    
    public boolean deleteCompte(Integer id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Compte cpt = (Compte)session.load(Compte.class, id);
            session.beginTransaction();
            session.delete(cpt);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
       HibernateUtil.getSessionFactory().close();
        
        return false;
    }
     public boolean deleteMagasin(Integer id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Magasin mag = (Magasin)session.load(Magasin.class, id);
            session.beginTransaction();
            session.delete(mag);
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

