/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.util;

/**
 *
 * @author Mesmerus
 */
import entities.Client;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class sendEmail {

    public sendEmail() {
    }

    public static void sendpass(Client cli) throws Exception {
        final String username = "regubclient@gmail.com ";
        final String password = "regieVideos";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(cli.getEmail()));
            message.setSubject("regubClient " + cli.getSociete());
            message.setText("Bonjour " + cli.getSociete()
                    + ",\n\nBienvienue sur l'application regubClient, nous vous remercions pour votre confiance."
                    + ",\nVoici vos informations de connexion: "
                    + "\n Votre login :"+cli.getEmail()
                    + "\n Votre mdp :"+cli.getMotDePasse()
                    + "\n\n Bonne journée."
                    + "\n\n\n <<Service regubClient onLine>>");

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    
    public static void send(Client cli,String Link) throws Exception {
        final String username = "regubclient@gmail.com ";
		final String password = "regieVideos";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(cli.getEmail()));
			message.setSubject("regubClient " +cli.getSociete() );
			message.setText("Bonjour "+cli.getSociete()
                                + ",\n\nBienvienue sur l'application regubClient, nous vous remercions pour votre confiance."
				+ ",\nPour Activer votre compte, veuillez cliquer sur ce lien:\n\n"
                                +Link
                                +  "\n\n Bonne journée."
                                +  "\n\n\n <<Service reguClient onLine>>");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
    }
}
