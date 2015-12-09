/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Client;
import entities.Entreprise;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;


/**
 *
 * @author Mesmerus
 */
public class EntrepriseDAO {
    public static Entreprise getEnt (Integer IdClient) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try{
             Entreprise ent = (Entreprise) session.load(Entreprise.class, new Integer(1));
             
             return ent;
        }catch (Exception e) {
            e.printStackTrace();
        }
        session.close();
        HibernateUtil.getSessionFactory().close();
        return null;
    }
}
