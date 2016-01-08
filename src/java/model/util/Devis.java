/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.util;

import entities.Client;
import entities.Entreprise;
import entities.Magasin;
import entities.Region;
import entities.Typerayon;

import entities.Video;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.swing.table.DefaultTableModel;
import model.dao.EntrepriseDAO;
import model.dao.MagasinDAO;
import model.dao.RegionDAO;
import model.dao.TypeRayonDAO;
import model.dao.VideoDAO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRTableModelDataSource;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author Lons
 */
public class Devis {
    
    private int nombremagasin=0;
    DefaultTableModel tableModel;
    private Map parameters;
    private String [][] data = new String [100][3];
    private DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
     
      public Devis() {
    }

    public  void Consulter(Client cli, Video vid) throws IOException {
        String curDir = System.getProperty("user.dir");
    System.out.println ("Le répertoire courant est: "+curDir);
      
        
        
       
        JasperPrint jasperPrint = null;
        net.sf.jasperreports.engine.JasperReport x = null; 
        TableModelData(cli, vid);
        try {
            x = JasperCompileManager.compileReport("resources/reports/devis.jrxml");
            //JasperCompileManager.compileReportToFile("reports/report1.jrxml");
            jasperPrint = JasperFillManager.fillReport(x, parameters,
                    new JRTableModelDataSource(tableModel));
            //JasperViewer jasperViewer = new JasperViewer(jasperPrint);
            //jasperViewer.setVisible(true);
            JasperViewer.viewReport(jasperPrint, false);
        } catch (JRException ex) {
            ex.printStackTrace();
        }
    }
     private void TableModelData (Client cli, Video vid) {
             
              parameters = new HashMap();  
         this.getClient(cli);
         this.getVideo(vid);
       
        
            
         
        
        String[] columnNames = {"Nom", "Adresse", "Code"};
        String[][] data = {{"test"},{"test"},{"test"}
            //Pour le client
        };
        
      
            getEntreprise();
       
        if (this.nombremagasin==0) parameters.put("Info", "Aucune diffusion ne pourra être faite car aucun magasin ne comporte le rayon demandé dans les régions souhaitées "); 
        else parameters.put("Info", "");
        tableModel = new DefaultTableModel(this.data,columnNames);
    
    }
     private void  getEntreprise()  {
        
        Entreprise ent = EntrepriseDAO.getEnt(1);
        
        System.out.println ("L'entrprise a des infos: " + ent.getMail());
       
                parameters.put("Enom", ent.getNom());
            
                parameters.put("Eadresse", ent.getAdresse());
                parameters.put("Ecode", ent.getCode());
                parameters.put("Eville", ent.getVille());
                parameters.put("Etelephone", ent.getTelephone());
                parameters.put("Email", ent.getMail());

    }
     private void  getClient(Client cli)  {
        
        
        parameters.put("Nom", cli.getSociete());
         parameters.put("Adresse", cli.getAddrLigne1());
         parameters.put("Code", cli.getCodePostal());
         parameters.put("Ville", cli.getVille());
         parameters.put("Numero", cli.getTelephone());
         parameters.put("Mail", cli.getEmail());

    }
     
     private void  getVideo(Video vid)  {
         
        List<Typerayon> listrayon = VideoDAO.RayonSelect(vid);
        List<Region> listregion = VideoDAO.RegionSelect(vid);
        long diff;
        int diffInDays;
        diff=vid.getDateFin().getTime()-vid.getDateDebut().getTime();
		diffInDays = (int) ((diff) / (1000 * 60 * 60 * 24))+1;
        int i=0;
        Magasin mare;
        Magasin mara;
         parameters.put("Titre",vid.getTitre());
         parameters.put("Duree",Integer.toString(vid.getDuree()));
         parameters.put("Debut",df.format(vid.getDateDebut()));
         parameters.put("Fin",df.format(vid.getDateFin()));
         parameters.put("Frequence", Integer.toString(vid.getFrequence()));
         parameters.put("Tarif",Double.toString(vid.getTarif()));
         
         
         
         
         parameters.put("Regions", Integer.toString(vid.getRegions().size()));
         parameters.put("Rayons", Integer.toString(vid.getTyperayons().size()));
         
         for(Typerayon ra : listrayon){
             for(Region re : listregion){
                 ra.getMagasins().iterator().next();
                 mare = (Magasin) re.getMagasins().iterator().next();
                 mara = (Magasin) ra.getMagasins().iterator().next();
                 if(mara.getIdMagasin()==mare.getIdMagasin()){
                     
                     data[i][0]=re.getLibelle();
                    data[i][1]=mara.getNom();
                    data[i][2]=ra.getLibelle();
                        this.nombremagasin++;
                        i++;
                 }             
            }
         }
         for(int k=this.nombremagasin;k<100;k++)
                    for (int j=0;j<3;j++)
                         data[k][j]="";

         parameters.put("Magasins", Integer.toString(this.nombremagasin));
         parameters.put("Prix_Unitaire", Double.toString(vid.getTarif()*vid.getDuree()));
         parameters.put("Nombre_Diff", Double.toString(diffInDays*vid.getFrequence()*this.nombremagasin));
         parameters.put("Duree_Diff", Double.toString(diffInDays));
         parameters.put("montant", Double.toString(vid.getFrequence() * vid.getDuree()* vid.getTarif() * diffInDays*this.nombremagasin));    
         

    }
   
    
}

