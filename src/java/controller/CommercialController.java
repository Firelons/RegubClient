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
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import model.dao.RegionDAO;
import model.dao.TypeRayonDAO;
import model.dao.VideoDAO;
import model.util.Devis;
import model.util.Facture;
import model.util.sendEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

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

    //recup de l'id du contrat selectionné qui est à modifier
    private int clecontrat;

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
            if (CompteDAO.updateCommercial(cpt) != null) {
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
            try {
                sendEmail.sendpass(cli);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //model.addAttribute("societe", cli.getSociete());
        return "redirect:/regub/commercial/";
    }

    @RequestMapping(value = "/regub/commercial/modifierclient", method = RequestMethod.POST)
    public @ResponseBody
    String Afficherformmodif(@RequestParam("id") Integer id) {
        Client cli = ClientDAO.getClient(id);

        return "[{id : 1}]";
    }

    @RequestMapping(value = "/regub/commercial/{id}", method = RequestMethod.GET)
    public String deleteclient(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer IdClient) {
        CliBDD.deleteClient(IdClient);
        return "redirect:/regub/commercial/";
    }

    @RequestMapping(value = "/regub/commercial/modif/{id}", method = RequestMethod.GET)
    public String afficherpagemodifclient(HttpServletRequest request, HttpSession session, Model model, Client cli, @PathVariable("id") Integer IdClient) {
        cli = CliBDD.getClient(IdClient);
        model.addAttribute("cli", cli);
        return "modifierUtil";
    }

    @RequestMapping(value = "/regub/commercial/commodifcli", method = RequestMethod.POST)
    public String modifierclient(@ModelAttribute("cli") Client cli) {
        System.out.println("ce cli : " + cli.getSociete() + cli.getEmail() + cli.getTelephone());
        CliBDD.updClient(cli);
        return "redirect:/regub/commercial/";
    }

    //By T.Serge
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

            //Pour désactiver ou activer les boutons de visibilités des factures par Lons
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");
            java.util.Date date = new java.util.Date();
            model.addAttribute("now", sdf.parse(sdf.format(date)));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "contrats";
    }

    //value="regub/commercial/contrats/modifiercontratcom", method = RequestMethod.POST

    @RequestMapping(value = "regub/commercial/contrats/ajoutercontratcom")
    String formajoutcontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) {
        //List<Client> lst = ClientDAO.Charge(cleclient);
        Client lst = ClientDAO.getClient(cleclient);

        model.addAttribute("ajout", lst.getSociete());
        model.addAttribute("cleclient", cleclient);
        return "comformajoutcontrat";
    }

    //By T.Serge
    //methode utilisée pour convertir la date au format date de sql pr la BDD
    public java.sql.Date ConvertToSqlDate(String date) {
        DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
        Date d = null;
        try {
            d = dateformat.parse(date);
        } catch (ParseException ex) {
            Logger.getLogger(CommercialController.class.getName()).log(Level.SEVERE, null, ex);
        }
        //System.out.println(""+dateformat.format(datecourante));

        java.sql.Date sqldate = new java.sql.Date(d.getTime());

        return sqldate;
    }

    /*
     Modif T.serge
     methode permettant de convertir la liste des choix recupérés ss forme de string dans le formulaire
     en une liste datecourante'entiers de type Set 
     */
    protected Set<Region> tableaureg(String[] lst) {
        //int[] array = Arrays.asList(lst).stream().mapToInt(Integer::parseInt).toArray();
        Set<Region> numbers = new HashSet<>();
        //Set numbers = new HashSet();
        /*for (Integer m : array) {
         Region reg = new Region(m);
         numbers.add(reg);
         }*/
        for (String lst1 : lst) {
            numbers.add(RegionDAO.RegionPrec(lst1).get(0));
        }
        return numbers;
    }

    protected Set<Typerayon> tableauray(String[] lst) {
        //int[] array = Arrays.asList(lst).stream().mapToInt(Integer::parseInt).toArray();
        Set<Typerayon> numbers = new HashSet<>();
        //Set numbers = new HashSet();
        /*for (Integer m : array) {
         Typerayon ray = new Typerayon(m);
         numbers.add(ray);
         }*/
        for (String lst1 : lst) {
            numbers.add(TypeRayonDAO.RayonPrec(lst1).get(0));
        }
        return numbers;
    }

    //action appelée après saisie des infos dans le formulaire datecourante'ajout datecourante'un contrat
    @RequestMapping("regub/commercial/contrats/comajoutcontrat")
    public String ajoutcontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model,
            @RequestParam("file") MultipartFile file) throws ParseException, InterruptedException {

        //Pour pouvoir conserver l'Id du client pour lequel 
        //l'ajout du contrat est fait
        int id = cleclient;

        String[] choixrayon = request.getParameterValues("rayon");
        String[] choixregion = request.getParameterValues("region");
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
        Compte comcompt = (Compte) session.getAttribute("compteConnected");

        DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
        Date currentDate = new Date();
        String datecourante = dateformat.format(currentDate);

        Video vid = new Video(client, comcompt, titrecontrat,
                Integer.parseInt(freqcontrat), Integer.parseInt(durecontrat),
                ConvertToSqlDate(datedebutcontrat), ConvertToSqlDate(datefincontrat),
                ConvertToSqlDate(daterecepcontrat), ConvertToSqlDate(datecourante),
                Double.parseDouble(tarifcontrat), Integer.parseInt(choixstatut),
                mySetregion, mySettyperayon);

        int videoid = VidBDD.addComContrat(vid);// appelle de la méthode pr inserer dans la table video et recup de l'id de l'element qui a été inséré

        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();

                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                //System.out.println(""+rootPath+File.separator);
                //System.out.println(""+file.getOriginalFilename());

                // Create the file on server
                //file.getOriginalFilename() permet de recup le nom du fichier original selectionné
                //Mon chemein de test
                //File serverFile = new File("A:\\test"+ File.separator + 20 + ".mp4");//ça marche
                //Chemin officiel du serveur
                File serverFile = new File(rootPath + File.separator + "webapps" + File.separator + "manager"
                        + File.separator + "videos" + File.separator + videoid + ".mp4");
                System.out.println("" + serverFile);
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("You failed to upload ");
        }

        //return "redirect:/regub/commercial";
        return "redirect:/regub/commercial/contrats/" + vid.getClient().getIdClient();

    }

    //By T.serge
    //Méthode utilisée pour convertir la date du format sql au format 'dd-mm-yyyy'
    public String ConvertToDate(Date date) {
        DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
        String d = dateformat.format(date);
        return d;
    }

    //By T.serge
    /*Action exec lorsk un com modifie un contrat d'un client
     method = RequestMethod.POST, peut etre ajouté en paramètre mais c pas nécessaire
     */
    @RequestMapping(value = "regub/commercial/contrats/modifiercontratcom")
    String formmodifiercontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) {

        Client lst = ClientDAO.getClient(cleclient);
        int idContrat = Integer.parseInt(request.getParameter("idvideo"));
        clecontrat = idContrat;

        //recup des infos du contrat selectionné
        Video vid = VidBDD.modifcontrat(idContrat);

        request.setAttribute("regselected", vid.getRegions());//recup des régions déjà selectionné correspondant au contrat à modifier
        request.setAttribute("rayselected", vid.getTyperayons());
        request.setAttribute("statselected", vid.getStatut());

        //System.out.println(""+vid.getRegions().size());
        System.out.println("" + vid.getStatut());
        Set<Region> lt = vid.getRegions();
        /*lt.stream().forEach((str) -> {
         System.out.println(str.getIdRegion()+" "+ str.getLibelle());
         });*/
        /*for (Region str : lt) {
         System.out.println(str.getIdRegion()+" "+ str.getLibelle());
         }*/

        model.addAttribute("contratselected", vid);

        model.addAttribute("datedebut", ConvertToDate(vid.getDateDebut()));
        model.addAttribute("datereception", ConvertToDate(vid.getDateReception()));
        model.addAttribute("datefin", ConvertToDate(vid.getDateFin()));
        model.addAttribute("datevalidation", ConvertToDate(vid.getDateValidation()));

        model.addAttribute("ajout", lst.getSociete());
        model.addAttribute("cleclient", cleclient);

        return "comformmodifiercontrat";
    }

    //By T.serge
    //action de chargement ds données pr le click du bouton modifier
    @RequestMapping("regub/commercial/contrats/commodifiercontrat")
    String modifiercontratAction(
            HttpServletRequest request,
            HttpSession session,
            Model model) throws InterruptedException {

        int idContrat = clecontrat;

        String[] choixrayon = request.getParameterValues("rayon");
        String[] choixregion = request.getParameterValues("region");
        //String titrecontrat = request.getParameter("titre");
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

        //Chargement des infos liées au contrat qui se sera modifié
        Video vid = VidBDD.modifcontrat(idContrat);

        vid.setFrequence(Integer.parseInt(freqcontrat));
        vid.setDuree(Integer.parseInt(durecontrat));
        //System.out.println(""+titrecontrat);
        System.out.println("" + datedebutcontrat);
        //vid.setDateDebut(ConvertToSqlDate(datedebutcontrat));
        vid.setDateFin(ConvertToSqlDate(datefincontrat));
        //vid.setDateReception(ConvertToSqlDate(daterecepcontrat));
        //vid.setDateValidation(ConvertToSqlDate(datevalidcontrat));
        if (Integer.parseInt(choixstatut) == 1) {
            DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
            Date currentDate = new Date();
            String datecourante = dateformat.format(currentDate);
            vid.setDateValidation(ConvertToSqlDate(datecourante));
        }
        vid.setStatut(Integer.parseInt(choixstatut));
        vid.setTarif(Double.parseDouble(tarifcontrat));
        vid.setRegions(mySetregion);
        vid.setTyperayons(mySettyperayon);

        //Thread.sleep(2000);
        VidBDD.updComContrat(vid, "modifier");
        return "redirect:/regub/commercial/contrats/" + vid.getClient().getIdClient();
        //return listClientAction(request, session, model);
    }

    @RequestMapping(value = "regub/commercial/contrats/annulercontratcom", method = RequestMethod.POST)
    public String annulercontratAction(HttpServletRequest request, HttpSession session, Model model) throws ParseException {
        //ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        //session.removeAttribute("UserConnected");
        int idContrat = Integer.parseInt(request.getParameter("idvideo"));
        DateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");

        Video vid = VidBDD.modifcontrat(idContrat);

        String datedebut = ConvertToDate(vid.getDateDebut());
        Date ddebut = dateformat.parse(datedebut);
        //System.out.println(""+datedebut);
        //System.out.println("Con De type Date:"+ddebut);

        Date currentDate = new Date();
        String datecourante = dateformat.format(currentDate);
        Date dcourante = dateformat.parse(datecourante);
        //System.out.println(""+datecourante);
        //System.out.println("Cu De type Date:"+dcourante);

        //Raccourci la date de validation du contrat à la date courante
        if (dcourante.after(ddebut) || dcourante.equals(ddebut)) {
            //System.out.println("Date courant sup ou egale à celle du cntrat");
            vid.setDateFin(ConvertToSqlDate(datecourante));
            VidBDD.updComContrat(vid, "annuler");
        } else {
            //supprime le contrat si il n'est pas commencé
            //System.out.println("Date courant inf à celle du cntrat");
            VidBDD.deleteComContrat(idContrat);
        }

        //return listClientAction(request, session, model);
        //return "redirect:/regub/commercial";
        return "redirect:/regub/commercial/contrats/" + vid.getClient().getIdClient();
    }

    @RequestMapping(value = "regub/commercial/contrats/deviscom", method = RequestMethod.POST)
    //public @ResponseBody
    String devisAction(
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        Client cli = (Client) request.getAttribute("clicom");
        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Devis devis = new Devis();
        devis.Consulter(VidBDD.VideoPrec(idvideo).get(0).getClient(), VidBDD.VideoPrec(idvideo).get(0), request.getServletContext());
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        int BUFFER_SIZE = 4096;
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("");
        System.out.println(appPath);

        try {

            File downloadFile = new File(appPath + "\\resources\\reports\\devis.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath + "\\resources\\reports\\devis.pdf");
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
            System.out.println("MIME type: " + mimeType);

            // set content attributes for the response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // set headers for the response
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"",
                    downloadFile.getName());
            response.setHeader(headerKey, headerValue);

            // get output stream of the response
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead = -1;

            // write bytes read from the input stream into the output stream
            while ((bytesRead = fis.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            fis.close();
            outStream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "redirect:/regub/commercial/contrats/" + cli.getIdClient();
    }

    @RequestMapping(value = "regub/commercial/contrats/facturecom", method = RequestMethod.POST)
    //public @ResponseBody
    String factureAction(
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Facture facture = new Facture();
        facture.Consulter(VidBDD.VideoPrec(idvideo).get(0).getClient(), VidBDD.VideoPrec(idvideo).get(0), request.getServletContext());
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        int BUFFER_SIZE = 4096;
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("");
        System.out.println(appPath);

        try {

            File downloadFile = new File(appPath + "\\resources\\reports\\facture.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath + "\\resources\\reports\\facture.pdf");
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
            System.out.println("MIME type: " + mimeType);

            // set content attributes for the response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // set headers for the response
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"",
                    downloadFile.getName());
            response.setHeader(headerKey, headerValue);

            // get output stream of the response
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead = -1;

            // write bytes read from the input stream into the output stream
            while ((bytesRead = fis.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            fis.close();
            outStream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "redirect:/regub/commercial/contrats/" + VidBDD.VideoPrec(idvideo).get(0).getClient().getIdClient();
    }

    //List des contrats passes
    @RequestMapping(value = "regub/commercial/derniercontrats")
    protected String listcontratspasses(Model model) {
       List<Video> lst= VideoDAO.listContratspasses();
       model.addAttribute("derniercontrats", lst);
        return "listderniercontrats";
    }
    
    // devis générer sur la jsp listderniercontrat
    @RequestMapping(value = "regub/commercial/deviscom", method = RequestMethod.POST)
    //public @ResponseBody
    String devis2Action(
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        Client cli = (Client) request.getAttribute("clicom");
        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Devis devis = new Devis();
        devis.Consulter(VidBDD.VideoPrec(idvideo).get(0).getClient(), VidBDD.VideoPrec(idvideo).get(0), request.getServletContext());
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        int BUFFER_SIZE = 4096;
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("");
        System.out.println(appPath);

        try {

            File downloadFile = new File(appPath + "\\resources\\reports\\devis.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath + "\\resources\\reports\\devis.pdf");
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
            System.out.println("MIME type: " + mimeType);

            // set content attributes for the response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // set headers for the response
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"",
                    downloadFile.getName());
            response.setHeader(headerKey, headerValue);

            // get output stream of the response
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead = -1;

            // write bytes read from the input stream into the output stream
            while ((bytesRead = fis.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            fis.close();
            outStream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "redirect:/regub/commercial/derniercontras";
    }
    
    // facture générer sur la jsp listderniercontrat
    @RequestMapping(value = "regub/commercial/facturecom", method = RequestMethod.POST)
    //public @ResponseBody
    String facture2Action(
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Facture facture = new Facture();
        facture.Consulter(VidBDD.VideoPrec(idvideo).get(0).getClient(), VidBDD.VideoPrec(idvideo).get(0), request.getServletContext());
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        int BUFFER_SIZE = 4096;
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("");
        System.out.println(appPath);

        try {

            File downloadFile = new File(appPath + "\\resources\\reports\\facture.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath + "\\resources\\reports\\facture.pdf");
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
            System.out.println("MIME type: " + mimeType);

            // set content attributes for the response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // set headers for the response
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"",
                    downloadFile.getName());
            response.setHeader(headerKey, headerValue);

            // get output stream of the response
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead = -1;

            // write bytes read from the input stream into the output stream
            while ((bytesRead = fis.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            fis.close();
            outStream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "redirect:/regub/commercial/contrats/derniercontrats";
    }
}
