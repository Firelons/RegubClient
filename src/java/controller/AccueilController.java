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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccueilController {

    private final ClientDAO CliBDD = new ClientDAO();

    @RequestMapping(method = RequestMethod.POST, value = "/connection")
    public @ResponseBody String login(
            @RequestParam("inputEmail") String email,
            @RequestParam("inputPassword") String password,
            HttpSession session) {
        try {
            ClientConnecte cli = new ClientConnecte(CliBDD.checkLogin(email, password));
            if (cli.getCli() != null) {
                session.setAttribute("UserConnected", cli.getCli());
                return "client";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "accueil";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/conn")
    public @ResponseBody
    String test ( @RequestParam("inputEmail") String email,
            @RequestParam("inputPassword") String password,BindingResult result){
 
        return "toto";

    }

    @RequestMapping(value = "/inscription", method = RequestMethod.POST)
    public String singin(HttpServletRequest request,
            @ModelAttribute("cli") Client cli, @RequestParam("confirmation") String confirmation, Model model) {
        if (!cli.getMotDePasse().equals(confirmation)) {
            model.addAttribute("Err", "Erreur confirmation");
            return "accueil";
        } else if (CliBDD.addClient(cli)) {
            model.addAttribute("msg", "Enregistrement effectué");
            return "inscripClient";
        }
        //model.addAttribute("societe", cli.getSociete());
        model.addAttribute("Err", "Erreur inscription");
        return "accueil";
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
