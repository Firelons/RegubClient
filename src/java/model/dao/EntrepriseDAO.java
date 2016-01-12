/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Entreprise;
import model.util.HibernateUtil;
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
    
    public static Entreprise enregistrerEntreprise(Entreprise ent) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        if (ent.getNom() == null) {
            session.beginTransaction();
            session.save(ent);
            session.getTransaction().commit();
        } else {
            try {
                session.beginTransaction();
                Entreprise entreprise = (Entreprise) session.load(Entreprise.class, 1);
                entreprise.setNom(ent.getNom());
                entreprise.setAdresse(ent.getAdresse());
                entreprise.setCode(ent.getCode());
                entreprise.setVille(ent.getVille());
                entreprise.setTelephone(ent.getTelephone());
                entreprise.setMail(ent.getMail());
                session.update(entreprise);
                session.getTransaction().commit();
                return entreprise;
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        }
        session.close();
        return null;
    }

}
