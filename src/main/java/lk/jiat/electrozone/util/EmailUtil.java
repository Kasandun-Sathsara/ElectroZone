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
        String host = Env.get("mail.host");
        String port = Env.get("mail.port");
        String user = Env.get("mail.username");
        String password = Env.get("mail.password");
        String appName = Env.get("app.name");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", host != null ? host : "*");
        props.put("mail.smtp.host", host != null ? host : "smtp.gmail.com");
        props.put("mail.smtp.port", port != null ? port : "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user, appName));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            message.setSubject(subject);
            message.setContent(messageContent, "text/html; charset=utf-8");
            
            System.out.println("Sending email to " + toAddress + "...");
            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
