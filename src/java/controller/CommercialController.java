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
import javax.servlet.http.HttpServletRequest;
import model.dao.ClientDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author loïc
 */
@Controller
public class CommercialController {
    
    private final ClientDAO CliBDD = new ClientDAO();
    
    @RequestMapping(value = "/regub/commercial", method = RequestMethod.GET)
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
    
     @RequestMapping(value = "/regub/commercial/ajoutclient", method = RequestMethod.POST)
    public String ajoutclient(HttpServletRequest request,
            @ModelAttribute("cli") Client cli,HttpSession session,Model model) {
        cli.setMotDePasse("");
       if (CliBDD.addClient(cli)) {
            model.addAttribute("msg", "Enregistrement effectué");
        }else{
            model.addAttribute("msg", "Erreur inscription");
       }
        //model.addAttribute("societe", cli.getSociete());
       listClientAction(session,model);
        return "commercial";
    }
    
    @RequestMapping(value = "/regub/commercial/{id}", method = RequestMethod.GET)
    public String deleteclient(HttpServletRequest request,HttpSession session,Model model, Client cli, @PathVariable("id") Integer IdClient) {
       System.out.println("test "+IdClient);
       if (CliBDD.deleteClient(IdClient)) {
           
           model.addAttribute("msg", "Suppression effectué");
       }else{
           model.addAttribute("msg", "Suppression non effectué");
       
       }
       return retouraccueil(session,model);   
    }
    
     @RequestMapping("/regub/commercial/accueil")
      public String retouraccueil(HttpSession session ,Model model) {
          listClientAction( session, model);
         return "commercial";
      }
      
    @RequestMapping("regub/commercial/contrats")
      public String contratsAction(HttpSession session ,Model model) {
        ClientConnecte cli = new ClientConnecte((Client)session.getAttribute("UserConnected"));
         session.removeAttribute("UserConnected");
         try{
            List<Video> lst = VideoDAO.layDS(cli.getCli().getIdClient());
            model.addAttribute("video",lst);
        }
        catch(Exception e){
            e.printStackTrace();
        }
         return "contrats";
      }
}
