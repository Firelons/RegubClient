/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entities.Client;
import javax.servlet.http.HttpSession;
import model.dao.ClientDAO;
import entities.ClientConnecte;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.util.sendEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccueilController {

    private final ClientDAO CliBDD = new ClientDAO();
    private Client cl = new Client();

    @RequestMapping(method = RequestMethod.POST, value = "/connection")
    public @ResponseBody
    String login(
            @RequestParam("inputEmail") String email,
            @RequestParam("inputPassword") String password,
            HttpSession session) {
        try {
            ClientConnecte cli = new ClientConnecte(CliBDD.checkLogin(email, password));
            if (cli.getCli() != null) {
                session.setAttribute("UserConnected", cli.getCli());
                if(cli.getCli().isValide()){
                    return "client";
                }else{
                    session.setAttribute("usersigned", cli.getCli());
                    return "inscription";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "accueil";
    }

    @RequestMapping(value = "/inscription", method = RequestMethod.POST)
    public @ResponseBody
    String signin(
            @ModelAttribute("cli") Client cli,
            @RequestParam("confirmation") String confirmation,
            HttpSession session) {
        if (!cli.getMotDePasse().equals(confirmation)) {
            return "accueil";
        } else if (cli.getMotDePasse().length() < 8) {
            return "accueil";
        } else if (CliBDD.addClient(cli)) {
            try {
                session.setAttribute("usersigned", cli);
                sendEmail.send(cli, "http://localhost:8080/RegubClient/XY0Ao25pTASC"+cli.getIdClient()+"45xRGB");
                return "inscripClient";
            } catch (Exception ex) {
                Logger.getLogger(AccueilController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return "accueil";
    }

    @RequestMapping(value = "/inscription", method = RequestMethod.GET)
    public String sign(HttpSession session) {
        return "inscripClient";
    }

    @RequestMapping(value = "/accueil", method = RequestMethod.GET)
    protected String accAction(Model model) {
        return "accueil";
    }

    @RequestMapping(value = "/XY0Ao25pTASC{id}45xRGB", method = RequestMethod.GET)
    public String activerClient(HttpServletRequest request, HttpSession session, Model model,
            @PathVariable("id") Integer IdClient) {
        CliBDD.activerClient(IdClient);
        session.setAttribute("userActivated",CliBDD.getClient(IdClient));
        model.addAttribute("info", "Votre compte a été activé ! ");
        return "activerClient";
    }
}
