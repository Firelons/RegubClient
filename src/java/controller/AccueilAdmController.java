/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Client;
import entities.Compte;
import entities.Typecompte;
//import entities.ClientConnecte;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.dao.AdministrateurDAO;
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
    private final Compte adm = new Compte();
    
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
    
    @RequestMapping(value = "retour")
    protected String retourAccueilAction(Model model) {
        return "accueilAdm";
    }
    @RequestMapping(value = "creer")
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
    
    
}