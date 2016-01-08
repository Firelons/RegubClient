/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import entities.Compte;
import entities.Magasin;
import entities.Region;
import entities.Typecompte;
import entities.Typerayon;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
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
import model.dao.CompteDAO;
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
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author batchanou
 */
@Controller
public class AdmController {
    
    private final AdministrateurDAO auth = new AdministrateurDAO();
    private Compte adm ;
    protected int id = 0;
    
   
    // 1- lien GESTION DES COMPTES de la page admAccueil
    @RequestMapping(value = "user", method = RequestMethod.GET)
    protected String userAction(HttpServletRequest request, Model model) {
        try{
           if(auth.compteUser()!= null){
               request.setAttribute("compte", auth.compteUser());
               return "admCompteUtilisateur";
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "admCompteUtilisateur";   
    }
    
    //  2- lien GESTION DES RAYONS de la page admAccueil
     @RequestMapping(value = "rayon", method = RequestMethod.POST)
    protected String rayonAction() {
        
        return "typeRayon";   
    }
    
    //  3- lien GESTION DES MAGASINS de la page admAccueil
     @RequestMapping(value = "magasin", method = RequestMethod.GET)
    protected String magasinAction(HttpServletRequest request, Model model) { 
        try {
             if(auth.magasin()!=null){
                 request.setAttribute("magasin", auth.magasin());
             }
             
         } catch (Exception e) {
             e.printStackTrace();
         }
        return "admGestionMagasin";   
    }
    
    // 4- lien GESTION DES REGIONS de la page admAccueil
     @RequestMapping(value = "region")
    protected String regionAction(Model model) {
        return "admRegionUtilisateur";
    }
    
    
    
    //  bouton ajout de la page compte utilisateur
    @RequestMapping(value = "ajoutCompte")
    protected String ajoutCompteAction(Model model) {
        return "admCreerUtilisateur";
    }
    
     //  bouton ajout de la page magasin
    @RequestMapping(value = "ajoutMagasin")
    protected String ajoutMagasinAction(HttpServletRequest request, Model model) {
        try {
            if(auth.region()!=null){
                request.setAttribute("regionlist", auth.region());
                System.out.println(auth.region().get(0).getLibelle());
            }
            if(auth.typerayon()!=null){
                request.setAttribute("trayonlist", auth.typerayon());
                System.out.println(auth.typerayon().get(0).getLibelle());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admCreerMagasin";
    }
    
     //  bouton modifier de la page compte utilisateur
    @RequestMapping(value = "ModifCompte{id}", method = RequestMethod.GET)
    protected String modifierCompteAction(HttpServletRequest request,  Model model, @PathVariable(value = "id") Integer id) {
       this.id = id;
       try {
            if(auth.selectCompte(id)!=null){
                request.setAttribute("compte", auth.selectCompte(id));   
            }  
        } catch (Exception e) {
        }
        return "admModifierUtilisateur";
    }
    
     //  bouton modifier de la page magasin
    @RequestMapping(value = "ModifMagasin{id}", method = RequestMethod.GET)
    protected String modifierMagasinAction(HttpServletRequest request,  Model model, @PathVariable(value = "id") Integer id) {
       /*this.id = id;
       try {
            if(auth.selectCompte(id)!=null){
                request.setAttribute("compte", auth.selectCompte(id));   
            }  
        } catch (Exception e) {
        }*/
        return "admModifierMagasin";
    } 
    
    
    //  bouton supprimer de la page compte utilisateur
    @RequestMapping(value = "SuppCompte{id}", method = RequestMethod.GET)
    protected String supprimerCompteAction(HttpServletRequest request, Model model, @PathVariable(value = "id") Integer ide) {
        boolean suppr = false;
        try {
            if(auth.selectCompte(ide)!=null){
                suppr = auth.deleteCompte(ide);
                System.out.println(suppr);
            }   
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userAction(request, model);
    }  
    
     //  bouton supprimer de la page compte utilisateur
     @RequestMapping(value = "SuppMagasin{id}", method = RequestMethod.GET)
    protected String supprimerMagasinAction(HttpServletRequest request, Model model, @PathVariable(value = "id") Integer ide) {
       /*boolean suppr = false;
        try {
            if(auth.selectCompte(ide)!=null){
                suppr = auth.deleteCompte(ide);
                System.out.println(suppr);
            }   
        } catch (Exception e) {
            e.printStackTrace();
        }*/
        return userAction(request, model);
    }
    
    
     //bouton annuler du compte utilsateur
    @RequestMapping(value = "AnnuleCreationUser")
    protected String annuleCreationUserAction(HttpServletRequest request, Model model) {
        return userAction(request, model);
    }
    @RequestMapping(value = "AnnuleMagasin")
    protected String annuleMagasinAction(HttpServletRequest request, Model model) {
        return magasinAction(request, model);
    }
    
    
    
     // traitement de la page creation du compte  
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
               ajout = auth.addCompte(adm);
               
            }else{
                String st = "Tous les champs ne sont pas renseignés";
                    JOptionPane.showMessageDialog(null,st);
                System.out.println("veuillez renseigner tous les champs");
            }
            return userAction(request, model);   
        }catch (Exception e) {
            System.out.println("catch du controller");   
            e.printStackTrace();   
           
        }
        return userAction(request, model);
    }
    
     // traitement de la page creation du magasin  
    @RequestMapping(value = "CreationMagasin", method = RequestMethod.POST)
    protected String creationMagasinAction(HttpServletRequest request, Model model, @ModelAttribute("magasin")Magasin magasin){
       /*String nom = request.getParameter("nom");
       String rue = request.getParameter("addrLigne1");
       String complement = request.getParameter("addrLigne2");
       String codep = request.getParameter("codepostal");
       String ville = request.getParameter("ville");*/
       int idregion = Integer.parseInt(request.getParameter("region"));
       Region R = new Region();
       R.setIdRegion(idregion);
        boolean ajout = true;
        try {
            magasin.setRegion(R);
            ajout = auth.addMagasin(magasin);
        } catch (Exception e) {
            e.printStackTrace();
        }
    return magasinAction(request, model);
    }
    
    // traitement de la page modification du compte utilisateur
    @RequestMapping(value = "ModifDataCompte", method=RequestMethod.POST)
    protected String modifierDataCompteAction(HttpServletRequest request, Model model) {
         boolean modif=false;

         String nom = request.getParameter("nom");
         String prenom = request.getParameter("prenom");
         String login = request.getParameter("login");
         int tcpt = Integer.parseInt(request.getParameter("typecompte"));
         
         Typecompte T = new Typecompte();
         T.setIdTypeCompte(tcpt);
         try {
             System.out.println(this.id);
             System.out.println(nom);
             modif = auth.updateCompte(this.id, nom, prenom, login, T);
            System.out.println(modif); 
    
        } catch (Exception e) {
            e.printStackTrace();
        }       
        return userAction(request, model);
    }
    
    
    
     // bouton accueil de la navigation
    @RequestMapping(value = "admin")
    protected String retourAction(Model model) {
        return "admAccueil";
    }
    
   
    //  bouton parametre de la navigation
    @RequestMapping(value = "RegubClient/admin/paramAdminitrateur/", method = RequestMethod.POST)
    public @ResponseBody
    String modifparam(
            HttpSession session,
            @ModelAttribute("com") Compte com,
            @RequestParam("password_confirmation") String confirmation,
            @RequestParam("oldpassword") String oldmotdepasse) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        Compte cpt = (Compte) session.getAttribute("compteConnected");
         if (!cpt.getPassword().equals(CompteDAO.encode(oldmotdepasse, cpt.getSalt()))) {
            return "erroroldmdp";
        } else if (!com.getPassword().equals(confirmation)) {
            return "errorconfirm";
        } else {
            cpt.setNom(com.getNom());
            cpt.setPrenom(com.getPrenom());
            cpt.setLogin(com.getLogin());
            cpt.setPassword(com.getPassword());
            if (CompteDAO.updateCommercial(cpt)!=null) {
                session.setAttribute("compteConnected", CompteDAO.updateCommercial(cpt));
                return "success";
            }
        }
        return "error";
    }
}
