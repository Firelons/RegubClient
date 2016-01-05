/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import entities.Client;
import entities.Compte;
import entities.Region;
import entities.Typerayon;
import entities.Video;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import model.dao.VideoDAO;
import model.util.sendEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author loïc
 */
@Controller
public class CommercialController {

    private final ClientDAO CliBDD = new ClientDAO();
    //private final AdministrateurDAO auth = new AdministrateurDAO();
    //private final Compte adm = new Compte();
    private VideoDAO VidBDD = new VideoDAO();

    //recup de l'id du client
    private int cleclient;
    
    private Compte cpt;
    
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
        cli.setMotDePasse("comajoutcli");
        if (CliBDD.addClient(cli)) {
            model.addAttribute("msg", "Enregistrement effectuÃ©");
        } else {
            model.addAttribute("msg", "Erreur inscription");
        }
        try {
            sendEmail.sendpass(cli);
        } catch (Exception e) {
            e.printStackTrace();
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


    @RequestMapping(value = "/regub/commercial/{id}", method = RequestMethod.GET)
    public String deleteclient(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer IdClient) {
        CliBDD.deleteClient(IdClient);
        return "redirect:/regub/commercial/";
    }
    
    @RequestMapping(value = "/regub/commercial/modif/{id}", method = RequestMethod.GET)
    public String modifierlient(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer IdClient) {
        cli =  CliBDD.getClient(IdClient);
        model.addAttribute("cli",cli);
        return "modifierUtil";
    }
    
    
    @RequestMapping("regub/commercial/contrats/{id}")
    public String contratsAction(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer idClient) {
        //ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        //session.removeAttribute("UserConnected");
        try {
            cleclient = idClient;
            List<Video> lst = VideoDAO.layDS(idClient);
            model.addAttribute("video", lst);
            List<Client> lstcli = ClientDAO.Charge(idClient);
            //Client client = ClientDAO.Charge(idClient).get(0); //lstcli.get(0)
            //Client lstcli = ClientDAO.getClient(idClient); 
            model.addAttribute("nomclient", lstcli.get(0).getSociete());
            
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
        //List<Client> lst = ClientDAO.Charge(cleclient);
        Client lst = ClientDAO.getClient(cleclient);
        //List<Typerayon> listrayon = VideoDAO.layDS();
        model.addAttribute("ajout", lst.getSociete());
        model.addAttribute("cleclient", cleclient);
        return "comformajoutcontrat";
    }
    
    //By T.Serge
    //methode utilisée pour convertir la date au format date de sql pr la BDD
    public java.sql.Date ConvertToSqlDate(String date){
        //System.out.println(""+date);
        DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
        Date d = null;
        try {
            d = dateformat.parse(date);
        } catch (ParseException ex) {
            Logger.getLogger(CommercialController.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(""+dateformat.format(d));
        
        java.sql.Date sqldate = new java.sql.Date(d.getTime());
        //System.out.println(""+sqldate);
        return sqldate;
    }
    
    /*
        Modif T.serge
        methode permettant de convertir la liste des choix recupérés ss forme de string dans le formulaire
        en une liste d'entiers de type Set 
    */
    protected Set<Region> tableaureg( String [] lst) {
        int[] array = Arrays.asList(lst).stream().mapToInt(Integer::parseInt).toArray();
        Set<Region> numbers = new HashSet<>();
        //Set numbers = new HashSet();
        for (Integer m : array) {
            Region reg = new Region(m);
            numbers.add(reg);
        }
        return numbers;
    }
    
    protected Set<Typerayon> tableauray( String [] lst) {
        int[] array = Arrays.asList(lst).stream().mapToInt(Integer::parseInt).toArray();
        Set<Typerayon> numbers = new HashSet<>();
        //Set numbers = new HashSet();
        for (Integer m : array) {
            Typerayon ray = new Typerayon(m);
            numbers.add(ray);
        }
        return numbers;
    }
    
    //action appelée après saisie des infos dans le formulaire d'ajout d'un contrat
    @RequestMapping("regub/commercial/contrats/comajoutcontrat")
    public String ajoutcontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) throws ParseException, InterruptedException {
        //Pour pouvoir conserver l'Id du client pour lequel 
        //l'ajout du contrat est fait
        int id = cleclient;
        
        String [] choixrayon = request.getParameterValues("rayon");
        String [] choixregion = request.getParameterValues("region");
        String titrecontrat = request.getParameter("titre");
        String freqcontrat = request.getParameter("frequence");
        String durecontrat = request.getParameter("duree");
        String datedebutcontrat = request.getParameter("datedebut");  
        String datefincontrat = request.getParameter("datefin");
        String daterecepcontrat = request.getParameter("datereception");
        String datevalidcontrat = request.getParameter("datevalidation");
        String tarifcontrat = request.getParameter("tarif");
        String choixstatut = request.getParameter("statut");
        
        Set<Region> mySetregion = tableaureg(choixregion);
        Set<Typerayon> mySettyperayon = tableauray(choixrayon);
        
        Client client = ClientDAO.Charge(id).get(0);
        Compte comcompt = (Compte)session.getAttribute("compteConnected");
        
        Video vid = new Video(client, comcompt, titrecontrat, 
                Integer.parseInt(freqcontrat), Integer.parseInt(durecontrat), 
                ConvertToSqlDate(datedebutcontrat), ConvertToSqlDate(datefincontrat), 
                ConvertToSqlDate(daterecepcontrat), ConvertToSqlDate(datevalidcontrat), 
                Double.parseDouble(tarifcontrat), Integer.parseInt(choixstatut),
                mySetregion, mySettyperayon);
        
        VidBDD.addComContrat(vid);// appelle de la méthode pr inserer dans la table video
        //Thread.sleep(3000);
        return listClientAction(request, session, model);
        
    }
    
    //Action exec lorsk un com modifie un contrat d'un client
    @RequestMapping("regub/commercial/contrats/comformmodifiercontrat/{id}")
    String formmodifiercontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model,
            @PathVariable("id") Integer idContrat) {
        Client lst = ClientDAO.getClient(cleclient);
        
        //recup des infos du contrat selectionné
        Video vid = VidBDD.modifcontrat(idContrat);
        
        model.addAttribute("contratselected", vid);
                
        model.addAttribute("ajout", lst.getSociete());
        model.addAttribute("cleclient", cleclient);
        return "comformmodifiercontrat";
    }

    //action de chargement ds données pr le click du bouton modifier
    @RequestMapping(value = "regub/commercial/contrats/commmodifiercontrat", method = RequestMethod.GET)
    //public @ResponseBody
    String modifiercontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model,
            @ModelAttribute("video") Video video,
            @PathVariable(value = "id") Integer id) {
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        request.setAttribute("Modify", this.VidBDD.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        //return "comformmodifiercontrat";
        int idContrat = id;
        
        String [] choixrayon = request.getParameterValues("rayon");
        String [] choixregion = request.getParameterValues("region");
        String titrecontrat = request.getParameter("titre");
        String freqcontrat = request.getParameter("frequence");
        String durecontrat = request.getParameter("duree");
        String datedebutcontrat = request.getParameter("datedebut");  
        String datefincontrat = request.getParameter("datefin");
        String daterecepcontrat = request.getParameter("datereception");
        String datevalidcontrat = request.getParameter("datevalidation");
        String tarifcontrat = request.getParameter("tarif");
        String choixstatut = request.getParameter("statut");
        
        Set<Region> mySetregion = tableaureg(choixregion);
        Set<Typerayon> mySettyperayon = tableauray(choixrayon);
        
        Client client = ClientDAO.Charge(id).get(0);
        Compte comcompt = (Compte)session.getAttribute("compteConnected");
        
        Video vid = new Video(client, comcompt, titrecontrat, 
                Integer.parseInt(freqcontrat), Integer.parseInt(durecontrat), 
                ConvertToSqlDate(datedebutcontrat), ConvertToSqlDate(datefincontrat), 
                ConvertToSqlDate(daterecepcontrat), ConvertToSqlDate(datevalidcontrat), 
                Double.parseDouble(tarifcontrat), Integer.parseInt(choixstatut),
                mySetregion, mySettyperayon);
        
        VidBDD.addComContrat(vid);// appelle de la méthode pr inserer dans la table video
        //Thread.sleep(3000);
        return listClientAction(request, session, model);
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
