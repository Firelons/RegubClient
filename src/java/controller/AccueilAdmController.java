/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import entities.Compte;
import entities.Typecompte;
import java.security.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Calendar;
import java.util.Date;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import model.dao.AdministrateurDAO;
import org.apache.taglibs.standard.functions.Functions;
import static org.apache.tomcat.jni.OS.random;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    @RequestMapping(value = "Ajoutuser")
    protected String creerUserAction(Model model) {
        return "creerUtilisateur";
    }
    @RequestMapping(value = "update")
    protected String modifierUserAction(Model model) {
        return "modifierUtilisateur";
    }  
    @RequestMapping(value = "delete")
    protected String deleteUserAction(Model model) {
        return "";
    }
    @RequestMapping(value = "region")
    protected String regionAction(Model model) {
        return "gestionRegion";
    }
    
    @RequestMapping(value = "admin")
    protected String retourAction(Model model) {
        return "accueilAdm";
    }
    
    //traitement de la page creation du client   
    
    @RequestMapping(value = "CreationUser", method = RequestMethod.POST)
    protected String boutonCreationUserAction(HttpServletRequest request, Model model) {
        
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
              /* byte[] bSalt = new byte[8];
               random.nextBytes(bSalt);
               String sSalt = byteToBase64(bSalt);*/
               int nb = (int)Math.random()*10000+255;
               String salt = Integer.toBinaryString(nb);
               salt= auth.encode(salt);
               salt= Functions.substring(salt, 0, 31);
               mdp = auth.encode(mdp.concat(salt));
               SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yy hh:mm:ss");
               Date date = new Date();
               System.out.println(formater.format(date));
               
               adm = new Compte(tcpt, nom, prenom, login, mdp, salt, date );
               //adm1 = new Compte(tcpt, nom, prenom, login, mdp, salt, null);
                System.out.println("nom:"+ nom);
                System.out.println("prenom:"+prenom);
                System.out.println("login:"+login);
                System.out.println("mdp:"+mdp);
                System.out.println("typec:"+typec);
                System.out.println("salt:"+salt);
                System.out.println("date:"+date);
                ajout = auth.addCompte(adm);
                System.out.println("ajout:"+ajout); 

            }else{
                /*String st = "Tous les champs ne sont pas renseignés";
                    JOptionPane.showMessageDialog(null,st);*/
                System.out.println("veuillez renseigner tous les champs");
            }
            return "test";   
        }catch (Exception e) {
            System.out.println("catch du controller");   
            e.printStackTrace();   
           
        }
        return "compteUtilisateur";
    }
    
    @RequestMapping(value = "AnnuleCreationUser", method = RequestMethod.POST)
    protected String annuleCreationUserAction(Model model) {
        return "compteUtilisateur";
    }
}