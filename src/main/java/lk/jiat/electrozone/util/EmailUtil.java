package lk.jiat.ElectroZone.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    
    // Replace with real SMTP details when deploying
    private static final String SMTP_HOST = "smtp.example.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USER = "your-email@example.com";
    private static final String SMTP_PASSWORD = "your-password";

    public static void sendEmail(String toAddress, String subject, String messageContent) {
        // MOCK EMAIL SENDER - Just logs to console for now
        System.out.println("========== EMAIL SENT ==========");
        System.out.println("To: " + toAddress);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + messageContent);
        System.out.println("=================================");

        /* Real Implementation Example:
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            message.setSubject(subject);
            message.setText(messageContent);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        */
    }
}
