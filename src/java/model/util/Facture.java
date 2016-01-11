/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.util;

import entities.Client;
import entities.Diffusions;
import entities.Entreprise;
import entities.Magasin;
import entities.Region;
import entities.Typerayon;

import entities.Video;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author Lons
 */
public class Facture {
    
    private int nombremagasin=0;
    DefaultTableModel tableModel;
    private Map parameters;
    private String [][] data = new String [100][4];
    private DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    private int nbrregions=0;
    private int nbrrayons=0;
    
     
      public Facture() {
    }

    public  void Consulter(Client cli, Video vid) throws IOException {
        String curDir = System.getProperty("user.dir");
    System.out.println ("Le répertoire courant est: "+curDir);
      
     
       
        JasperPrint jasperPrint = null;
        net.sf.jasperreports.engine.JasperReport x = null; 
        TableModelData(cli, vid);
        try {
            x = JasperCompileManager.compileReport("C:/Users/Lons/Documents/NetBeansProjects/RegubClient/reports/facture.jrxml");
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
       
        
            
         
        
        String[] columnNames = {"Nom", "Adresse", "Code", "Diffusions"};
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
        Set<Diffusions> liste_diff ;
        liste_diff = (Set) vid.getDiffusionses();
        long diff;
        int diffInDays;
        diff=vid.getDateFin().getTime()-vid.getDateDebut().getTime();
		diffInDays = (int) ((diff) / (1000 * 60 * 60 * 24))+1;
        int i=0;
       int  nbrra = 0;
       int nbrre=0;
        Magasin mara;
         parameters.put("Titre",vid.getTitre());
         parameters.put("Duree",Integer.toString(vid.getDuree()));
         parameters.put("Debut",df.format(vid.getDateDebut()));
         parameters.put("Fin",df.format(vid.getDateFin()));
         parameters.put("Frequence", Double.toString(vid.getDiffusionses().size()/diffInDays));
         parameters.put("Tarif",Double.toString(vid.getTarif()));
         
         for(Diffusions dif : liste_diff){
             
                     
                    data[i][0]=dif.getMagasin().getRegion().getLibelle();
                    data[i][1]=dif.getMagasin().getNom();
                    data[i][2]=dif.getTyperayon().getLibelle();
                    data[i][3]=dif.getDateDiffusion().toString();
                        this.nombremagasin++;
                        i++;
                        for(Typerayon tr : listrayon){
                            if(dif.getTyperayon().getIdTypeRayon()==tr.getIdTypeRayon())
                                nbrra++;
                        }
                        for(Region re : listregion){
                            if(re.getIdRegion()==dif.getMagasin().getRegion().getIdRegion())
                                nbrre++;
                        }
                 }             
           
         for(int k=this.nombremagasin;k<100;k++)
                    for (int j=0;j<4;j++)
                         data[k][j]="";
         /*
         parameters.put("Regions", Integer.toString(nbrre));
         parameters.put("Rayons",  Integer.toString(nbrra));
         */
         parameters.put("Magasins", Integer.toString(vid.getDiffusionses().size()));
         parameters.put("Prix_Unitaire", Double.toString(vid.getTarif()*vid.getDuree()));
         parameters.put("Nombre_Diff", Integer.toString(vid.getDiffusionses().size()));
         parameters.put("Duree_Diff", Double.toString(diffInDays));
         parameters.put("montant",Double.toString(vid.getTarif()*vid.getDuree()*vid.getDiffusionses().size()));    
        
    }    
}

