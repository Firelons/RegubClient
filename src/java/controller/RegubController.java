/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Client;
import entities.ClientConnecte;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.dao.ClientDAO;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Mesmerus
 */
public class RegubController {
     private final ClientDAO auth = new ClientDAO();

    @RequestMapping(method = RequestMethod.POST, value = "/connect")
    public String login(HttpServletRequest request,
            @RequestParam("inputEmail") String email,
            @RequestParam("inputPassword") String password,
            HttpSession session,
            Model model) {
        try {
            ClientConnecte cli = new ClientConnecte(auth.checkLogin(email, password));
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
   
}
