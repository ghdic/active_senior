package controller.tool;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;
import javax.mail.*;
import javax.mail.PasswordAuthentication;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailManager{
    final static String user = "irony0728@gmail.com";
    final static String password = "test0728!";
    private static Properties prop;

    static {
        prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", 465);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
    }

    public static int sendMail(String target, String title, String html) throws MessagingException {
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(target));
        message.setSubject(title, "utf-8");
        message.setContent(html, "text/html; charset=utf-8");

        try {
            Transport.send(message);
            return 0;
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static String getRandomPassword(int len) {
        char[] randomName = new char[len];
        for(int i = 0; i < len; i++) {
            int randInt = ThreadLocalRandom.current().nextInt(0, 36);
            if(randInt < 10)
                randomName[i] = (char) ('0' + randInt);
            else
                randomName[i] = (char) ('a' + randInt - 10);
        }
        return String.valueOf(randomName);
    }
}
