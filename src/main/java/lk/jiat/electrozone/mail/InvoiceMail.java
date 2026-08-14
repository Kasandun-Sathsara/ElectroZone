package lk.jiat.ElectroZone.mail;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import lk.jiat.ElectroZone.util.Env;

public class InvoiceMail extends Mailable {
    private final String to;
    private final String subject;
    private final String htmlContent;

    public InvoiceMail(String to, String subject, String htmlContent) {
        this.to = to;
        this.subject = subject;
        this.htmlContent = htmlContent;
    }

    @Override
    public void build(Message message) throws MessagingException {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setContent(htmlContent, "text/html; charset=utf-8");
    }
}
