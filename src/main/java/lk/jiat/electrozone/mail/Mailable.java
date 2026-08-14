package lk.jiat.ElectroZone.mail;

import io.rocketbase.mail.EmailTemplateBuilder;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lk.jiat.ElectroZone.provider.MailServiceProvider;
import lk.jiat.ElectroZone.util.Env;

public abstract class Mailable implements Runnable {
    private final MailServiceProvider mailServiceProvider;
    private final EmailTemplateBuilder.EmailTemplateConfigBuilder emailTemplateConfigBuilder;

    public Mailable() {
        this.mailServiceProvider = MailServiceProvider.getInstance();
        this.emailTemplateConfigBuilder = EmailTemplateBuilder.builder();
    }

    @Override
    public void run() {
        try {
            Session mailSession = Session.getInstance(mailServiceProvider.getProperties(), mailServiceProvider.getAuthenticator());
            MimeMessage mimeMessage = new MimeMessage(mailSession);
            String fromEmail = Env.get("mail.username");
            if (fromEmail == null || fromEmail.isBlank()) {
                fromEmail = Env.get("app.mail");
            }
            mimeMessage.setFrom(new InternetAddress(fromEmail, Env.get("app.name")));
            build(mimeMessage);
            if (mimeMessage.getRecipients(Message.RecipientType.TO) != null && mimeMessage.getRecipients(Message.RecipientType.TO).length > 0) {
                System.out.println("Attempting to send email via SMTP to: " + mimeMessage.getRecipients(Message.RecipientType.TO)[0]);
                Transport.send(mimeMessage);
                System.out.println("\u001B[32mEmail sending successful!\u001B[0m");
            } else {
                System.err.println("Email recipients cannot be empty.");
            }
        } catch (Exception e) {
            System.err.println("Mailable execution failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public abstract void build(Message message) throws MessagingException;

    public EmailTemplateBuilder.EmailTemplateConfigBuilder getEmailTemplateBuilder(){
        return emailTemplateConfigBuilder;
    }
}
