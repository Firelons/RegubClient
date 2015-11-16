/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import entities.Video;
import java.util.List;
import model.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Mesmerus
 */
public class regubDAO {

    public static List<Video> layDS(Integer idClient) {

        List<Video> lst = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            String hql = "from Video as vid where vid.client.idClient =?";
            Query query = session.createQuery(hql);
            query.setParameter(0, idClient);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
}
