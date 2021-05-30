package controller.tool;

import javax.mail.MessagingException;

public class EmailRunnable implements Runnable{
    private String target;
    private String title;
    private String html;

    public EmailRunnable(String target, String title, String html) {
        this.target = target;
        this.title = title;
        this.html = html;
    }
    @Override
    public void run(){
        try {
            EmailManager.sendMail(target, title, html);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
