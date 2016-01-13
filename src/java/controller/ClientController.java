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
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.dao.ClientDAO;
import model.dao.CompteDAO;
import model.dao.RegionDAO;
import model.dao.TypeRayonDAO;
import model.util.Devis;
import model.util.Facture;
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
 * @author Mesmerus
 */
@Controller
public class ClientController {

    private final ClientDAO CliBDD = new ClientDAO();
    private VideoDAO vidBDD = new VideoDAO();
    private final CompteDAO ComBDD = new CompteDAO();

    @RequestMapping(value = "/client", method = RequestMethod.GET)
    protected String listVideoAction(HttpSession session, Model model) throws ParseException {
        //Pour désactiver ou activer les boutons de visibilités des factures par Lons
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date date = new java.util.Date();
        model.addAttribute("now", sdf.parse(sdf.format(date)));

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

        //Verouillage des champs
        return "client";
    }

    @RequestMapping(value = "/modifiercontrat", method = RequestMethod.POST)
    protected String DetailVideoAction(HttpSession session, Model model, HttpServletRequest request) {

        List<Typerayon> listrayon = TypeRayonDAO.Rayonliste();
        List<Region> listregion = RegionDAO.Regionliste();

        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        if (vidBDD.modifcontrat(idvideo) == null) {
            System.out.println("Not good");
        } else {
            System.out.println("Good");
        }

        try {
            model.addAttribute("video", vidBDD.modifcontrat(idvideo));
            model.addAttribute("listrayon", listrayon);
            model.addAttribute("listregion", listregion);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cliModifContrat";
    }

    @RequestMapping(value = "/modifycontrat", method = RequestMethod.POST)
    protected String UpdateVideoAction(HttpSession session,
            Model model,
            HttpServletRequest request) throws ParseException, InterruptedException {
        ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        SimpleDateFormat sdnow = new SimpleDateFormat("dd/MM/yy");
        java.util.Date date = new java.util.Date();
        model.addAttribute("now", sdf.parse(sdf.format(date)));

        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Set<Region> regions = new HashSet<>();
        Set<Typerayon> typerayons = new HashSet<>();

        String[] choixrayon = request.getParameterValues("rayon");
        String[] choixregion = request.getParameterValues("region");

        for (int i = 0; i < choixrayon.length; i++) {
            typerayons.add(TypeRayonDAO.RayonPrec(choixrayon[i]).get(0));
            System.out.println(choixrayon[i]);
        }
        for (int i = 0; i < choixregion.length; i++) {
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

        //vidBDD.modifcontrat(idvideo)
        Video vid = vidBDD.modifcontrat(idvideo);
        //Video vid = new Video();

        if (vid == null) {
            System.out.println("Not good");
        } else {
            System.out.println("Good");
        }

        vid.setTitre(titrecontrat);
        vid.setFrequence(Integer.parseInt(freqcontrat));

        vid.setDuree(Integer.parseInt(durecontrat));
        vid.setDateDebut(sdf.parse(datedebutcontrat));
        vid.setDateFin(sdf.parse(datefincontrat));
        vid.setDateReception(sdf.parse(daterecepcontrat));
        vid.setDateValidation(sdf.parse(datevalidcontrat));
        vid.setStatut(Integer.parseInt(choixstatut));
        vid.setTarif(Double.parseDouble(tarifcontrat));
        vid.setRegions(regions);
        vid.setTyperayons(typerayons);

        try {
            this.vidBDD.updCliVideo(vid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (vidBDD.updCliVideo(vid) != null) {
            return "redirect:/client";
        }

        return "error";
    }

    @RequestMapping(value = "/modifierclient", method = RequestMethod.POST)
    public @ResponseBody
    String singin(
            HttpSession session,
            @ModelAttribute("cli") Client cli,
            @RequestParam("password_confirmation") String confirmation,
            @RequestParam("oldpassword") String oldmotdepasse) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        ClientConnecte cl = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        if (!cl.getCli().getMotDePasse().equals(CliBDD.encode(oldmotdepasse, cl.getCli().getSalt()))) {
            System.out.println("mdp:" + cl.getCli().getMotDePasse() + " et " + CliBDD.encode(oldmotdepasse, cl.getCli().getSalt()));
            return "erroroldmdp";
        } else if (!cli.getMotDePasse().equals(confirmation)) {
            return "errorconfirm";
        } else {
            cli.setIdClient(cl.getCli().getIdClient());
            cli.setSalt(cl.getCli().getSalt());
            if (CliBDD.updClient(cli) != null) {
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
        session.removeAttribute("CommercialConnected");
        return "redirect:/accueil";
    }

    /*
     Modif T.serge
     methode permettant de convertir la liste des choix recupérés ss forme de string dans le formulaire
     en une liste de type Set<Region> 
     */
    protected Set<Region> tableaureg(String[] lst) {
        Set<Region> numbers = new HashSet<>();
        for (String lst1 : lst) {
            numbers.add(RegionDAO.RegionPrec(lst1).get(0));
        }
        return numbers;
    }
    
    /*
     Modif T.serge
     methode permettant de convertir la liste des choix recupérés ss forme de string dans le formulaire
     en une liste de type Set<Typerayon> 
     */
    protected Set<Typerayon> tableauray(String[] lst) {
        Set<Typerayon> numbers = new HashSet<>();
        for (String lst1 : lst) {
            numbers.add(TypeRayonDAO.RayonPrec(lst1).get(0));
        }
        return numbers;
    }
    
    @RequestMapping(value = "/ajoutercontrat", method = RequestMethod.POST)
    String ajoutercontratAction(
            HttpServletRequest request,
            Model model,
            HttpSession session,
            @RequestParam("file") MultipartFile file) throws ParseException, InterruptedException {

        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        
        Set<Region> regions = new HashSet<>();
        Set<Typerayon> typerayons = new HashSet<>();
        
        java.util.Date date = new java.util.Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
        ClientConnecte cl = new ClientConnecte((Client) session.getAttribute("UserConnected"));

        List<Compte> listCompte = CompteDAO.RegionCompte();

        String[] choixrayon = request.getParameterValues("rayon");
        String[] choixregion = request.getParameterValues("region");

        for (int i = 0; i < choixrayon.length; i++) {
            typerayons.add(TypeRayonDAO.RayonPrec(choixrayon[i]).get(0));
            System.out.println(choixrayon[i]);
        }
        for (int i = 0; i < choixregion.length; i++) {
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

        Video vid = new Video(cl.getCli(), listCompte.get(0), titrecontrat,
                Integer.parseInt(freqcontrat), Integer.parseInt(durecontrat),
                sdf.parse(datedebutcontrat), sdf.parse(datefincontrat),
                sdf.parse(sdf.format(date)), sdf.parse(sdf.format(date)),
                0,
                2);
        
        
        vid.setRegions(regions);
        vid.setTyperayons(typerayons);

        int i = vidBDD.addcliVideo(vid);

        if (i != 0) {
            if (!file.isEmpty()) {
                try {
                    byte[] bytes = file.getBytes();

                    // Creating the directory to store file
                    String rootPath = System.getProperty("catalina.home");

                    // Create the file on server
                    //Chemin officiel du serveur
                    File serverFile = new File(rootPath + File.separator + "webapps" + File.separator + "manager"
                            + File.separator + "videos" + File.separator + i + ".mp4");
                    System.out.println("" + serverFile);
                    try (BufferedOutputStream stream = new BufferedOutputStream(
                            new FileOutputStream(serverFile))) {
                        stream.write(bytes);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println("You failed to upload ");
            }
            return "redirect:/client";
        } else {
            return "cliEditContrat";
        }

    }

    @RequestMapping(value = "/ajoutercontrat", method = RequestMethod.GET)
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

    @RequestMapping(value = "/devis", method = RequestMethod.POST)
    //public @ResponseBody
    String devisAction(
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        Client cli = (Client) session.getAttribute("UserConnected");
        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Devis devis = new Devis();
        devis.Consulter(cli, vidBDD.VideoPrec(idvideo).get(0),request.getServletContext());
        //if(request.getSession()){
        //int test = Integer.parseInt(request.getParameter("select")) ;
        //request.setAttribute("Modify", this.modif.modifcontrat(id));
        //}
        //session.setAttribute("Modify", this.modif.modifcontrat(id));
        // get your file as InputStream

        /**
         * Size of a byte buffer to read/write file
         */
        int BUFFER_SIZE = 4096;
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("");
        System.out.println(appPath);

        try {

            File downloadFile = new File(appPath+"\\resources\\reports\\devis.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath+"\\resources\\reports\\devis.pdf");
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

        return "/";
    }

    @RequestMapping(value = "/facture", method = RequestMethod.POST)
    //public @ResponseBody
    String factureAction(
            HttpServletRequest request,HttpServletResponse response,
            HttpSession session,
            Model model) throws IOException {

        Client cli = (Client) session.getAttribute("UserConnected");
        int idvideo = Integer.parseInt(request.getParameter("idvideo"));
        Facture facture = new Facture();
        facture.Consulter(cli, vidBDD.VideoPrec(idvideo).get(0),request.getServletContext());
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

            File downloadFile = new File(appPath+"\\resources\\reports\\facture.pdf");
            FileInputStream fis = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(appPath+"\\resources\\reports\\facture.pdf");
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

        return "/";
    }

    @RequestMapping("/annuler")
    public String annulercontratAction(HttpServletRequest request, HttpSession session) throws ParseException {
        //ClientConnecte cli = new ClientConnecte((Client) session.getAttribute("UserConnected"));
        //session.removeAttribute("UserConnected");

        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
        int idvideo = Integer.parseInt(request.getParameter("idvideo"));

        Video vid = vidBDD.VideoPrec(idvideo).get(0);

        //System.out.println(""+datedebut);
        //System.out.println("Con De type Date:"+ddebut);
        Date currentDate = new Date();
        String datecourante = sdf.format(currentDate);
        Date dcourante = sdf.parse(datecourante);
        //System.out.println(""+datecourante);
        //System.out.println("Cu De type Date:"+dcourante);

        //Raccourci la date de validation du contrat à la date courante
        if (dcourante.after(vid.getDateDebut()) || dcourante.equals(vid.getDateDebut())) {
            //System.out.println("Date courant sup ou egale à celle du cntrat");
            vid.setDateFin(dcourante);
            this.vidBDD.updComContrat(vid, "annuler");
        } else {
            //supprime le contrat si il n'est pas commencé
            //System.out.println("Date courant inf à celle du cntrat");
            vidBDD.deleteComContrat(idvideo);
        }

        return "redirect:/client";
    }

}
