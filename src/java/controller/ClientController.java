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
import entities.Compte;
import entities.Region;
import entities.Typerayon;
import entities.Video;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import model.dao.RegionDAO;
import model.dao.TypeRayonDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Mesmerus
 */
@Controller
public class ClientController {

    private final ClientDAO CliBDD = new ClientDAO();
    private VideoDAO vidBDD = new VideoDAO();
    private final CompteDAO ComBDD = new CompteDAO();

    @RequestMapping(value = "/client", method = RequestMethod.GET)
    protected String listVideoAction(HttpSession session, Model model) {
        ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        try {
            model.addAttribute("usr", cli.getCli().getSociete());
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            List<Video> lst = VideoDAO.layDS(cli.getCli().getIdClient());
            model.addAttribute("video", lst);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "client";
    }

    @RequestMapping(value = "/modifierclient", method = RequestMethod.POST)
    public @ResponseBody
    String singin(
            HttpSession session,
            @ModelAttribute("cli") Client cli,
            @RequestParam("password_confirmation") String confirmation,
            @RequestParam("oldpassword") String oldmotdepasse) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        ClientConnecte cl = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        if (!cli.getMotDePasse().equals(confirmation)) {
            System.out.println("mdp:" + cl.getCli().getMotDePasse() + " et " + CliBDD.encode(oldmotdepasse, cl.getCli().getSalt()));
            return "erroroldmdp";
        } else if (!cli.getMotDePasse().equals(confirmation)) {
            return "errorconfirm";
        } else {
            cli.setIdClient(cl.getCli().getIdClient());
            cli.setSalt(cl.getCli().getSalt());
            if (CliBDD.updClient(cli)!=null) {
                session.setAttribute("UserConnected", CliBDD.updClient(cli));
                return "success";
            }
        }
        return "error";
    }

    @RequestMapping("/logout")
    public String logoutAction(HttpSession session) {
        session.removeAttribute("UserConnected");
        session.removeAttribute("compteConnected");
        return "redirect:/accueil";
    }
    
    @RequestMapping(value="/modifiercontrat", method = RequestMethod.GET)
    //public @ResponseBody
    String modifiercontratAction(
            HttpServletRequest request,
            HttpSession session, 
            Model model) {
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        return "cliEditContrat";
    }
    @RequestMapping(value="/ajoutercontrat", method = RequestMethod.POST)
    //public @ResponseBody
    String ajoutercontratAction(
            HttpServletRequest request,
            Model model,
            HttpSession session
             ) throws ParseException, InterruptedException {
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        
         Set<Region> regions = new HashSet<>();
         Set<Typerayon> typerayons = new HashSet<>();
         
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");
        ClientConnecte cl = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        
        List<Compte> listCompte= CompteDAO.RegionCompte();
        
        String [] choixrayon = request.getParameterValues("rayon");
        String [] choixregion = request.getParameterValues("region");
        
        for(int i=0; i< choixrayon.length; i++){
            typerayons.add(TypeRayonDAO.RayonPrec(choixrayon[i]).get(0));
            System.out.println(choixrayon[i]);
        }
        for(int i=0; i< choixregion.length; i++){
            regions.add(RegionDAO.RegionPrec(choixregion[i]).get(0));
           
            System.out.println(choixregion[i]);
        }
        String titrecontrat = request.getParameter("titre");
        String freqcontrat = request.getParameter("frequence");
        String durecontrat = request.getParameter("duree");
        String datedebutcontrat = request.getParameter("dateDebut");  
        String datefincontrat = request.getParameter("dateFin");
        String daterecepcontrat = request.getParameter("dateReception");
        String datevalidcontrat = request.getParameter("dateValidation");
        String tarifcontrat = request.getParameter("tarif");
        String choixstatut = request.getParameter("statut");
        
        Video vid = new Video(cl.getCli()
                ,listCompte.get(0), titrecontrat, 
                Integer.parseInt(freqcontrat), Integer.parseInt(durecontrat), 
                 sdf.parse(datedebutcontrat),  sdf.parse(datefincontrat), 
                 sdf.parse(daterecepcontrat),  sdf.parse(datevalidcontrat), 
                Double.parseDouble(tarifcontrat), Integer.parseInt(choixstatut));
        
        vid.setRegions(regions);
        vid.setTyperayons(typerayons);
        
        if(vidBDD.addcliVideo(vid)){
            return "redirect:/client";
          }else{
            return "cliEditContrat";
            }
        
    }
     @RequestMapping(value="/ajoutercontrat", method = RequestMethod.GET)
    //public @ResponseBody
    String contratAction(
            HttpServletRequest request,
            HttpSession session, 
            Model model) {
        
        final Video form = new Video();
       model.addAttribute("vid", form);
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        return "cliEditContrat";
    }

}
