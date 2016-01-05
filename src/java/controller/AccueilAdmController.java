/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import entities.Compte;
import entities.Typecompte;
import entities.Typerayon;
import java.security.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import model.dao.AdministrateurDAO;
import model.dao.TypeRayonDAO;
import org.apache.taglibs.standard.functions.Functions;
import static org.apache.tomcat.jni.OS.random;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author batchanou
 */
@Controller
public class AccueilAdmController {
    
    private final AdministrateurDAO auth = new AdministrateurDAO();
    private Compte adm ;
    protected int id = 0;
    
    @RequestMapping(value = "user", method = RequestMethod.GET)
    protected String userAction(HttpServletRequest request, Model model) {
        try{
           if(auth.compteUser()!= null){
               request.setAttribute("compte", auth.compteUser());
               return "compteUtilisateur";
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "compteUtilisateur";   
    }
    
    @RequestMapping(value = "retour")   // retour vers la page accueil
    protected String retourAccueilAction(Model model) {
        return "redirect:accueilAdm";
    }
    @RequestMapping(value = "ajoutCompte")
    protected String ajoutCompteAction(Model model) {
        return "creerUtilisateur";
    }
    @RequestMapping(value = "ModifCompte/{id}", method = RequestMethod.GET)
    protected String modifierCompteAction(HttpServletRequest request,  Model model, @PathVariable(value = "id") Integer id) {
       this.id = id;
       try {
            if(auth.selectCompte(id)!=null){
                request.setAttribute("compte", auth.selectCompte(id));   
            }  
        } catch (Exception e) {
        }
        return "modifierUtilisateur";
    }  
    @RequestMapping(value = "SuppCompte/{id}", method = RequestMethod.GET)
    protected String supprimerCompteAction(HttpServletRequest request, Model model, @PathVariable(value = "id") Integer ide) {
        try {
             boolean suppr = auth.deleteCompte(ide);
             System.out.println(suppr);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userAction(request, model);
    }
    @RequestMapping(value = "region")
    protected String regionAction(Model model) {
        return "gestionRegion";
    }
    
    @RequestMapping(value = "admin")
    protected String retourAction(Model model) {
        return "accueilAdm";
    }
    
    //traitement de la page creation du compte   
    
    @RequestMapping(value = "CreationUser", method = RequestMethod.POST)
    protected String creationCompteAction(HttpServletRequest request, Model model) {
        String nom = request.getParameter("Nom");
        String prenom = request.getParameter("Prenom");
        String login = request.getParameter("Login");
        String mdp = request.getParameter("Motdepasse");
        int typec = Integer.parseInt(request.getParameter("Compte"));
        boolean ajout = true;
        
        try {
            if(nom!=null && prenom!=null && login!=null && mdp!=null && typec!=0){
               Typecompte tcpt = new Typecompte();
               tcpt.setIdTypeCompte(typec);
              
               SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yy hh:mm:ss");
               Date date = new Date();
               System.out.println(formater.format(date));
               
               adm = new Compte(tcpt, nom, prenom, login, mdp, "sel", date );
               
                /*System.out.println("nom:"+ nom);
                System.out.println("prenom:"+prenom);
                System.out.println("login:"+login);
                System.out.println("mdp:"+mdp);
                System.out.println("typec:"+typec);
                System.out.println("date:"+date);*/
                ajout = auth.addCompte(adm);
                //System.out.println("ajout:"+ajout); 

            }else{
                /*String st = "Tous les champs ne sont pas renseignés";
                    JOptionPane.showMessageDialog(null,st);*/
                System.out.println("veuillez renseigner tous les champs");
            }
            return userAction(request, model);   
        }catch (Exception e) {
            System.out.println("catch du controller");   
            e.printStackTrace();   
           
        }
        return userAction(request, model);
    }
    
    @RequestMapping(value = "AnnuleCreationUser")
    protected String annuleCreationUserAction(HttpServletRequest request, Model model) {
        return userAction(request, model);
    }
    
    //traitement de la page modification du compte
    
    @RequestMapping(value = "ModifDataCompte", method=RequestMethod.POST)
    protected String modifierDataCompteAction(HttpServletRequest request, Model model) {
         boolean modif=false;
       
         String nom = request.getParameter("nom");
         String prenom = request.getParameter("prenom");
         String login = request.getParameter("login");
         int tcpt = Integer.parseInt(request.getParameter("typecompte"));
         //int id = auth.selectCompte1(login).getIdCompte();
         
         try {
             System.out.println(this.id);
             System.out.println(nom);
             modif = auth.updateCompte(this.id, nom, prenom, login, tcpt);
            System.out.println(modif); 
            
        } catch (Exception e) {
            e.printStackTrace();
        }       
        return userAction(request, model);
    }
    
    @RequestMapping(value = "rayon", method = RequestMethod.POST)
    protected String rayonAction() {
        
        return "typeRayon";   
    }
    
}
