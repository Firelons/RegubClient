
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Compte;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.dao.AdministrateurDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Mesmerus
 */
@Controller
public class RegubController {
     private final AdministrateurDAO auth = new AdministrateurDAO();

    @RequestMapping(value = "admconnect",method = RequestMethod.POST)
    public String login(HttpServletRequest request,
            @RequestParam("login") String login,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {
        try {
            if(auth.connexion(login, password) != null){
                if(auth.connexion(login, password).getTypecompte().getIdTypeCompte()==1){
                    return "accueilAdm";
                }else if(auth.connexion(login, password).getTypecompte().getIdTypeCompte()==2){
                    return "accueilCom";
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("Err", "Erreur");
        return "accueil";
    }
    
    @RequestMapping(value = "/regub",method = RequestMethod.GET)
    protected String regubAction(Model model) {
        return "regub";
    }
}

