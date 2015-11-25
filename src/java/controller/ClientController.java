/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import model.dao.VideoDAO;
import entities.Client;
import entities.ClientConnecte;
import entities.Video;
import javax.servlet.http.HttpServletRequest;
import model.dao.ClientDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Mesmerus
 */
@Controller
public class ClientController{
    private final ClientDAO CliBDD = new ClientDAO();
    @RequestMapping(value = "/client",method = RequestMethod.GET)
    protected String listVideoAction(HttpSession session,Model model) {
        ClientConnecte cli = new ClientConnecte((Client)session.getAttribute("UserConnected"));
        try{
             model.addAttribute("usr",cli.getCli().getSociete());
        }
        catch(Exception e){
           e.printStackTrace();
        }
        try{
            List<Video> lst = VideoDAO.layDS(cli.getCli().getIdClient());
            model.addAttribute("video",lst);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "client";
    }
    @RequestMapping(value = "/modifierclient", method = RequestMethod.POST)
    public String singin(HttpServletRequest request,
            @ModelAttribute("cli") Client cli,@RequestParam("confirmation") String confirmation,
            @RequestParam("oldmotdepasse") String oldmotdepasse,Model model) {
        if (!cli.getMotDePasse().equals(confirmation)) {
            model.addAttribute("msg", "Erreur confirmation");
        }else if (!cli.getMotDePasse().equals(oldmotdepasse)) {
            model.addAttribute("msg", "Erreur oldmotdepasse");
        }else if (CliBDD.updClient(cli)) {
            model.addAttribute("msg", "Enregistrement effectué");
        }
        return "redirect:client";
    }
    @RequestMapping("/logout")
      public String logoutAction(HttpSession session ) {
         session.removeAttribute("UserConnected");
         return "redirect:/accueil";
      }
    
}
