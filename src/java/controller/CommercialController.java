/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Client;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.dao.VideoDAO;
import entities.Compte;
import entities.Typecompte;
import entities.ClientConnecte;
import entities.Video;
import model.dao.ClientDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author loïc
 */
@Controller
public class CommercialController {
    
    
    @RequestMapping(value = "/commercial", method = RequestMethod.GET)
    protected String listClientAction(HttpSession session,Model model) {
        ClientConnecte cli = new ClientConnecte((Client)session.getAttribute("UserConnected"));
        
        try{
            List<Client> lst = ClientDAO.listclient();
            model.addAttribute("client",lst);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "commercial";
      }
    
    @RequestMapping("/acceuil")
      public String acceuilAction(HttpSession session ) {
         session.removeAttribute("UserConnected");
         return "redirect:/accueil";
      }
    
    @RequestMapping("/contras")
      public String contrasAction(HttpSession session ) {
         session.removeAttribute("UserConnected");
         return "redirect:/contras";
      }
}
