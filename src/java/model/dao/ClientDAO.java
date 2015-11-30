package model.dao;

import entities.Client;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Mesmerus
 */
public class ClientDAO {

    public Client checkLogin(String email, String motDePasse) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        List<Client> list = new ArrayList<Client>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        String SQL_QUERY = "from Client as cli where cli.email=? and cli.motDePasse= SHA2( CONCAT( ? , cli.salt),256)";
        Query query = session.createQuery(SQL_QUERY);
        query.setParameter(0, email);
        query.setParameter(1, motDePasse);
        list = query.list();
        System.out.println("LA LISTE:   " + list.listIterator(0));
        if ((list.size() > 0)) {
            return list.get(0);
        }
        session.close();
        return null;
    }

    public String encode(String mdp, String sel) {
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

    public static List<Client> listclient() {

        List<Client> lst = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Client";
            Query query = session.createQuery(hql);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }

    public boolean addClient(Client cli) {
        System.out.println("TST:");
        List<Client> list = new ArrayList<Client>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            cli.setSalt("sel");
            session.beginTransaction();
            session.save(cli);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return false;
    }

    public boolean deleteClient(Integer idCli) {

        List<Client> list = new ArrayList<Client>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            Client suppcli = (Client) session.load(Client.class, idCli);
                session.beginTransaction();
                session.delete(suppcli);
                session.getTransaction().commit();
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return false;
    }

    public Client updClient(Client cli) {
        System.out.println("TEST1:");
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            System.out.println("TEST:");
            session.beginTransaction();
            Client updcli = (Client) session.load(Client.class, cli.getIdClient());
            updcli.setAddrLigne1(cli.getAddrLigne1());
            updcli.setAddrLigne2(cli.getAddrLigne2());
            updcli.setCodePostal(cli.getCodePostal());
            updcli.setEmail(cli.getEmail());
            updcli.setSociete(cli.getSociete());
            updcli.setTelephone(cli.getTelephone());
            updcli.setVille(cli.getVille());
            updcli.setMotDePasse(cli.getMotDePasse());
            session.update(updcli);
            session.getTransaction().commit();
            System.out.println("FIN:");
            return updcli;
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        System.out.println("ERROR:");
        return null;
    }
    
    
}
