/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import entities.Client;
import entities.Compte;
import entities.Entreprise;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import model.dao.AdministrateurDAO;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import model.dao.EntrepriseDAO;
import model.dao.MagasinDAO;
import model.dao.RegionDAO;
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
    private final TypeRayonDAO RayBDD = new TypeRayonDAO();
    private final RegionDAO regBDD = new RegionDAO();


    protected int idC = 0;
    protected int idM = 0;

    
   
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
     @RequestMapping(value = "rayon", method = RequestMethod.GET)
    protected String listRayonAction(Model model) {
       try {
            List<Typerayon> lst = TypeRayonDAO.Rayons();
            model.addAttribute("rayon", lst);
        } catch (Exception e) {
            e.printStackTrace();
        }
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
                //System.out.println(auth.region().get(0).getLibelle());
            }
            if(auth.typerayon()!=null){
                request.setAttribute("trayonlist", auth.typerayon());
                //System.out.println(auth.typerayon().get(0).getLibelle());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admCreerMagasin";
    }
    
    //  bouton ajout de la page type rayon
    @RequestMapping(value = "ajoutrayon",method = RequestMethod.POST )
    public String ajoutRayonAction(HttpServletRequest request,@RequestParam("ray") Typerayon ray, Model model, HttpSession session) {
        TypeRayonDAO.addRayon(ray);
        listRayonAction(model);
        return "typeRayon";
    }
    
    //modification de rayon
       @RequestMapping(value = "modifierrayon-{id}", method = RequestMethod.GET)
    public String afficherpagemodifrayon(HttpServletRequest request, HttpSession session, Model model, Typerayon ray, @PathVariable("id") Integer IdRayon) {
        ray =   RayBDD.getRayon(IdRayon);
        model.addAttribute("ray",ray);
        return "admModifierRayon";
    }
    @RequestMapping(value = "modifierrayon", method = RequestMethod.POST)
    public String modifierrayon(@RequestParam("idRayon") Integer idRayon,
            @RequestParam("libelle") String lib,Model model) {
        RayBDD.updRayon(idRayon,lib);
        listRayonAction(model);
        return "redirect:/rayon";
    }
    
    //bouton de suppression de rayon
     @RequestMapping(value = "supprimerrayon-{id}", method = RequestMethod.GET)
    public String deletrayon(HttpServletRequest request, HttpSession session, Model model, Typerayon ray, @PathVariable("id") Integer IdRayon) {
        RayBDD.deleteRayon(IdRayon);
        return "redirect:/rayon";
    }

    
     //  bouton modifier de la page compte utilisateur
    @RequestMapping(value = "ModifCompte{id}", method = RequestMethod.GET)
    protected String modifierCompteAction(HttpServletRequest request,  Model model, @PathVariable(value = "id") Integer id) {
       this.idM = id;
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
       this.idM = id;
       try {
            if(auth.selectMagasin(id)!=null){
                request.setAttribute("magasin", auth.selectMagasin(id));  
                request.setAttribute("regionlist", auth.region());
                request.setAttribute("trayonlist", auth.typerayon());
            }  
            System.out.println("region:"+auth.selectMagasin(id).getRegion().getLibelle());
        } catch (Exception e) {
        }
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
       boolean suppr = false;
        try {
            if(auth.selectMagasin(ide)!=null){
                suppr = auth.deleteMagasin(ide);
                //System.out.println(suppr);
            }   
        } catch (Exception e) {
            e.printStackTrace();
        }
        return magasinAction(request, model);
    }
    
    
     //bouton annuler du compte utilsateur
    @RequestMapping(value = "AnnuleCreationUser")
    protected String annuleCreationUserAction(HttpServletRequest request, Model model) {
        return userAction(request, model);
    }
     //bouton annuler du compte utilsateur
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
    

     // traitement de la page creation du magasin  
    @RequestMapping(value = "CreationMagasin", method = RequestMethod.POST)
    protected String creationMagasinAction(HttpServletRequest request, Model model){
       Set<Typerayon> typeR =  new HashSet<Typerayon>() ;
       
       Region R = new Region();
       String nom = request.getParameter("nom");
       String rue = request.getParameter("addrLigne1");
       String complement = request.getParameter("addrLigne2");
       String codep = request.getParameter("codepostal");
       String ville = request.getParameter("ville");
       int idregion = Integer.parseInt(request.getParameter("Region"));
       String[] trayon = request.getParameterValues("typerayon");
       R.setIdRegion(idregion);
      
       for(int i=0; i< trayon.length; i++){
            typeR.add(TypeRayonDAO.RayonPrec(trayon[i]).get(0));  
        }
        boolean ajout = true;
        try {
            Magasin magasin = new Magasin(R, nom, rue, complement, codep, ville);
            magasin.setTyperayons(typeR);
            ajout = auth.addMagasin(magasin);
            System.out.println(ajout);
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
             modif = auth.updateCompte(this.idC, nom, prenom, login, T);
        } catch (Exception e) {
            e.printStackTrace();
        }       
        return userAction(request, model);
    }
   
    

     // traitement de la page modification du compte utilisateur
    @RequestMapping(value = "ModifDataMagasin", method=RequestMethod.POST)
    protected String modifierDataMagasinAction(HttpServletRequest request, Model model) {
        boolean modif=false;
        Set<Typerayon> typeR =  new HashSet<Typerayon>() ;
        
        String nom = request.getParameter("nom");
        String rue = request.getParameter("addrLigne1");
        String complement = request.getParameter("addrLigne2");
        String codep = request.getParameter("codepostal");
        String ville = request.getParameter("ville");
        int idregion = Integer.parseInt(request.getParameter("Region"));
        Region R = new Region();
        R.setIdRegion(idregion);
        String[] trayon = request.getParameterValues("typerayon");
       
        for(int i=0; i< trayon.length; i++){
            typeR.add(TypeRayonDAO.RayonPrec(trayon[i]).get(0)); 
        }
         try {
             
             System.out.println("region:"+idregion);
                modif = auth.updateMagasin(this.idM, R, nom, rue, complement, codep, ville, typeR);
             System.out.println("region:"+idregion);
        } catch (Exception e) {
            e.printStackTrace();
        }       
        return magasinAction(request, model);
    }
    

    
     // bouton accueil de la navigation
    @RequestMapping(value = "admin")
    protected String retourAction(Model model) {
        return "admAccueil";
    }
    
    /*@RequestMapping(value = "/regub/administrateur/ajoutrayon", method = RequestMethod.POST)
    protected String ajoutRayonAction(HttpServletRequest request,
            @ModelAttribute("rayon") Typerayon ray, HttpSession session, Model model) {
        RayBDD.addRayon(ray);
        
        return "typeRayon";
    }*/
    
   
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
    
    // traitemant region
    
    @RequestMapping(value = "region" ,method = RequestMethod.GET)
    protected String listeregion( Model model) {
        try {
            List<Region> regions = RegionDAO.listregion();
            model.addAttribute("region", regions);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admRegionUtilisateur";
    }
    
    @RequestMapping(value = "ajoutregion", method = RequestMethod.POST)
    public String ajoutregion(HttpServletRequest request,
            @RequestParam("reg") Region reg,Model model) {
       
        RegionDAO.addRegion(reg);
           
        //model.addAttribute("societe", cli.getSociete());
        listeregion(model);
        return "admRegionUtilisateur";
    }
    
      
    @RequestMapping(value = "modifierregion-{id}", method = RequestMethod.GET)
    public String afficherpagemodifregion(HttpServletRequest request, HttpSession session, Model model, Region reg, @PathVariable("id") Integer IdRegion) {
        reg =  regBDD.getRegion(IdRegion);
        model.addAttribute("reg",reg);
        return "admModifierRegion";
    }
    @RequestMapping(value = "modifierregion", method = RequestMethod.POST)
    public String modifierregion(@RequestParam("idRegion") Integer idRegion,
            @RequestParam("libelle") String lib,Model model) {
        regBDD.updRegion(idRegion,lib);
        listeregion(model);
        return "redirect:/region";
    }
   
    @RequestMapping(value = "supprimerregion-{id}", method = RequestMethod.GET)
    public String deleteregion(HttpServletRequest request, HttpSession session, Model model, Region reg, @PathVariable("id") Integer IdRegion) {
        regBDD.deleteRegion(IdRegion);
        return "redirect:/region";
    }
    
    @RequestMapping(value = "magasinsregion-{id}", method = RequestMethod.GET)
    public String listmagasins(HttpServletRequest request, HttpSession session, Model model, Region reg, @PathVariable("id") Integer IdRegion) {
         Compte cpt = (Compte) session.getAttribute("AdministrateurConnected");
        List<Magasin> listmagasins = MagasinDAO.getmagasins(IdRegion);
        model.addAttribute("magasins",listmagasins);
        Region region = RegionDAO.getRegion(IdRegion);
        String nameregion = region.getLibelle();
         model.addAttribute("nomregion",nameregion);
        return "admMagasinsRegion";
    }
    // bouton enregistrer de entreprise
    @RequestMapping(value = "entrepriseenregistrer", method = RequestMethod.POST)
    @ResponseBody
    public String modifiEntreprise(@ModelAttribute("ent") Entreprise ent, HttpSession session) {
        EntrepriseDAO.enregistrerEntreprise(ent);   
        return "regub"; //facultatif géré ds la js administrateur
    }
    
    
    
    
}
