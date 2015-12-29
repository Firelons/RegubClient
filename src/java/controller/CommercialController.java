/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import entities.Client;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.dao.VideoDAO;
import entities.Compte;
import entities.Typecompte;
import entities.ClientConnecte;
import entities.Typerayon;
import entities.Video;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.dao.AdministrateurDAO;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import org.springframework.stereotype.Controller;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author loïc
 */
@Controller
public class CommercialController {

    private final ClientDAO CliBDD = new ClientDAO();
    //private final AdministrateurDAO auth = new AdministrateurDAO();
    //private final Compte adm = new Compte();
    private VideoDAO modif = new VideoDAO();

    //recup de l'id du client
    private int cleclient;

    @RequestMapping(value = "/regub/commercial", method = RequestMethod.GET)
    protected String listClientAction(HttpServletRequest request, HttpSession session, Model model) {

        try {
            List<Client> lst = ClientDAO.listclient();
            model.addAttribute("client", lst);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "commercial";
    }
    
    @RequestMapping(value = "/regub/commercial/paramCommercial", method = RequestMethod.POST)
    public @ResponseBody
    String modifparam(
            HttpSession session,
            @ModelAttribute("com") Compte com,
            @RequestParam("password_confirmation") String confirmation,
            @RequestParam("oldpassword") String oldmotdepasse) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        Compte cpt = (Compte) session.getAttribute("CommercialConnected");
         if (!cpt.getPassword().equals(CompteDAO.encode(oldmotdepasse, cpt.getSalt()))) {
            return "erroroldmdp";
        } else if (!com.getPassword().equals(confirmation)) {
            return "errorconfirm";
        } else {
            cpt.setNom(com.getNom());
            cpt.setPrenom(com.getPrenom());
            cpt.setLogin(com.getLogin());
            cpt.setPassword(com.getPassword());
            if (CompteDAO.updateCommercial(cpt)!=null) {
                session.setAttribute("CommercialConnected", CompteDAO.updateCommercial(cpt));
                return "success";
            }
        }
        return "error";
    }

    @RequestMapping(value = "/regub/commercial/ajoutclient", method = RequestMethod.POST)
    public String ajoutclient(HttpServletRequest request,
            @ModelAttribute("cli") Client cli, HttpSession session, Model model) {
        cli.setMotDePasse("");
        if (CliBDD.addClient(cli)) {
            model.addAttribute("msg", "Enregistrement effectué");
        } else {
            model.addAttribute("msg", "Erreur inscription");
        }
        //model.addAttribute("societe", cli.getSociete());
        listClientAction(request, session, model);
        return "commercial";
    }

    @RequestMapping(value = "/regub/commercial/modifierclient", method = RequestMethod.POST)
    public @ResponseBody
    String Afficherformmodif(@RequestParam("id") Integer id) {
        System.out.println("svfkfDFHEAFUNaefebnfuANEFUNafuneaFUNaenfANEFaunefANUEFUanefuNEAFUNZEUNZFNUZQEFNZQEFUEFZ"+id);
        Client cli = ClientDAO.getClient(id);
        
         return "[{id : 1}]";
    }

    @RequestMapping(value = "/regub/commercial/modcli", method = RequestMethod.GET)
    protected String AfficherFormmodif(HttpSession session, Model model) {
        try {
            List<Client> lst = ClientDAO.listclient();
            model.addAttribute("client", lst);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "commercial";
    }

    @RequestMapping(value = "/regub/commercial/{id}", method = RequestMethod.GET)
    public String deleteclient(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer IdClient) {
        CliBDD.deleteClient(IdClient);
        return "redirect:/regub/commercial/";
    }

    @RequestMapping("regub/commercial/contrats/{id}")
    public String contratsAction(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer idClient) {
        //ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        //session.removeAttribute("UserConnected");
        try {
            cleclient = idClient;
            List<Video> lst = VideoDAO.layDS(idClient);
            List<Client> lstcli = ClientDAO.Charge(idClient);
            model.addAttribute("nomclient", lstcli.get(0).getSociete());
            model.addAttribute("video", lst);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "contrats";
    }

    @RequestMapping("regub/commercial/contrats/comformajoutcontrat")
    String formajoutcontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        //Client contrat = contratclient.chargerclient(cleclient);
        List<Client> lst = ClientDAO.Charge(cleclient);
        //List<Typerayon> listrayon = VideoDAO.layDS();
        model.addAttribute("ajout", lst.get(0).getSociete());
        model.addAttribute("cleclient", cleclient);
        return "comformajoutcontrat";
    }

    //action appelée après saisie des infos dans le formulaire d'ajout d'un contrat
    @RequestMapping("regub/commercial/contrats/comajoutcontrat")
    String ajoutcontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        String[] choix = request.getParameterValues("rayon");
        List<Client> lst = ClientDAO.Charge(cleclient);
        //List<Typerayon> listrayon = VideoDAO.layDS();
        model.addAttribute("ajout", lst.get(0).getSociete());
        model.addAttribute("cleclient", cleclient);
        return "test";
    }

    //action de chargement ds données pr le click du bouton modifier
    @RequestMapping(value = "regub/commercial/contrats/commmodifiercontrat/{id}", method = RequestMethod.GET)
    //public @ResponseBody
    void modifiercontratAction(
            HttpServletRequest request,
            HttpSession session,
            @ModelAttribute("video") Video video,
            @PathVariable(value = "id") Integer id) {
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        //return "comformmodifiercontrat";
    }

    @RequestMapping("regub/commercial/contrats/annulercontrat/{id}")
    public String annulercontratAction(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer idContrat) {
        //ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        //session.removeAttribute("UserConnected");

        try {
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "contrats";
    }

}
