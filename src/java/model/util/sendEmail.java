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

    public static void send(Client client) throws Exception {
        final String username = "****@gmail.com";
		final String password = "****";

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
			message.setFrom(new InternetAddress("mesmerloic@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("mesmerloic@yahoo.fr"));
			message.setSubject("Testing Subject");
			message.setText("Bonjour,"
				+ "\n\n Pour confirmer votre compte, veuillez cliquer sur ce lien:\n\n "
                                +  "");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
    }
}
