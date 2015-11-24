/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Client;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.dao.ClientDAO;
import entities.ClientConnecte;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AccueilController {

    private final ClientDAO CliBDD = new ClientDAO();

    @RequestMapping(method = RequestMethod.POST, value = "/connection")
    public String login(HttpServletRequest request,
            @RequestParam("inputEmail") String email,
            @RequestParam("inputPassword") String password,
            HttpSession session,
            Model model) {
        try {
            ClientConnecte cli = new ClientConnecte(CliBDD.checkLogin(email, password));
            if (cli.getCli() != null) {
                session.setAttribute("UserConnected", cli.getCli());
                return "redirect:client";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("Err", "Erreur");
        return "accueil";
    }

    @RequestMapping(value = "/inscription",method = RequestMethod.POST)
    public String singin(HttpServletRequest request,
            @ModelAttribute("cli") Client cli, Model model) {
      /* if( CliBDD.addClient(cli)){
           model.addAttribute("msg", "Enregistrement effectué");
       }*/
       
        //model.addAttribute("societe", cli.getSociete());
        return "inscripClient";
    }
    @RequestMapping(value = "/inscription", method = RequestMethod.GET)
    protected String inscrp(Model model) {
        return "regub";
    }

    @RequestMapping(value = "/accueil", method = RequestMethod.GET)
    protected String accAction(Model model) {
        return "accueil";
    }


}
