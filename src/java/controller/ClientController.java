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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Mesmerus
 */
@Controller
public class ClientController{

    @RequestMapping("/client")
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
    @RequestMapping("/logout")
      public String logoutAction(HttpSession session ) {
         session.removeAttribute("UserConnected");
         return "redirect:/accueil";
      }
    
}
