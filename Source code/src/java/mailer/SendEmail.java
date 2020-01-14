package mailer;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendEmail
{

    public void sendEmail(String mail,String msg){
        mail = mail.trim();
        
        if(!msg.isEmpty())
            msg = msg.trim();
        
        String result;
	//Recipient's email ID needs to be mentioned.
	String to = "pmanas10001@gmail.com";

	// Sender's email ID needs to be mentioned  username should also be your email
	String from = "system.sigms@gmail.com";
	final String username = "system.sigms@gmail.com";
	final String password = "System.out.println(\"sigms\")";

        //host here we are using gsmtp
	String host = "smtp.gmail.com";         //while using gsmtp your sender should be a gmail account

	Properties props = new Properties();
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.port", "587");

	//Get the Session object.
	Session mailSession = Session.getInstance(props,
			new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username,
							password);
				}
			});

	try {
		// Create a default MimeMessage object.
		Message message = new MimeMessage(mailSession);

		// Set From: header field of the header.
		message.setFrom(new InternetAddress(from));

		// Set To: header field of the header.
		message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(to));

		// Set Subject: header field
		message.setSubject("Testing Subject");

		// Now set the actual message
		message.setText("Hello, this is sample for to check send "
				+ "email using JavaMailAPI in JSP ");

		// Send message
		Transport.send(message);

		System.out.println("Sent message successfully....");
		result = "Sent message successfully....";

	} catch (MessagingException e) {
		e.printStackTrace();
		result = "Error: unable to send message....";

	}
    }
}
