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
public class entrepriseDAO {
    public Entreprise getClient(Integer IdClient) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Entreprise ent = (Entreprise) session.load(Entreprise.class, new Integer(1));
        session.close();
        return ent;
    }
}
