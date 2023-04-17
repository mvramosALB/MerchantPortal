/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Sending;

import Models.AuditLogs;
import Models.SystemConfigurations;
import com.sun.mail.smtp.SMTPTransport;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author IT-Programmer
 */
public class SendEmail {
    

    AuditLogs logs = new AuditLogs();

    SystemConfigurations SC = new SystemConfigurations();

    private static String emailDestinatario;
    private static String Subject = "";
    private static String msg = "";
    private static String mess = "";
    private static String Disclaimer = "";
    private static String footer = "";
     private static String EmailLogID = "";

    public static boolean SendEmail(int Type, String ReceiverEmail, String Receivername, String Message, String FilePath, String Disclaimer1, String Footer1, String Subject1, String Userid) throws ClassNotFoundException {
        boolean returno = false;
         
        msg = EmailFormat(Type, Message, Receivername);

        emailDestinatario = ReceiverEmail;
        Subject = Subject1;
        EmailLogID = AuditLogs.AddEmailLog(ReceiverEmail, Subject, Message, FilePath, Userid);
//             
//        if (Type == 1) {// OTP
//            Subject = "Cash Card Enrollment Form";
//        } else if (Type == 2) {// Notif
//            Subject = "New Incident Alert";
//        }

        if (enviarGmail(FilePath)) {
            returno = true;
        }
        return returno;
    }

    public static boolean enviarGmail(String FilePath) throws ClassNotFoundException {
        String SMTP_SERVER = SystemConfigurations.GetSysConfig("EMAILSERVER");
        String USERNAME = SystemConfigurations.GetSysConfig("EMAILID");
        String PASSWORD = SystemConfigurations.GetSysConfig("EMAILPASS");
        String EMAIL_FROM = USERNAME; //SystemConfigurations.GetSysConfig("EMAILADDRESS");

        System.out.println("Receiver :" + emailDestinatario);
        boolean returno = false;
        Properties prop = System.getProperties();
        prop.put("mail.smtp.host", SMTP_SERVER); //optional, defined in SMTPTransport
        prop.put("mail.smtp.auth", "false");
        prop.put("mail.smtp.port", SystemConfigurations.GetSysConfig("EMAILPORT")); // default port 25

        Session session = Session.getInstance(prop, null);
        Message msgs = new MimeMessage(session);

        try {

            // from
            msgs.setFrom(new InternetAddress(EMAIL_FROM, SystemConfigurations.GetSysConfig("EMAILNAME")));

            // to
            msgs.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(emailDestinatario, false));

            // cc
//            msg.setRecipients(Message.RecipientType.CC,
//                    InternetAddress.parse(getEmailDestinatarioCC(), false));
            // subject
            msgs.setSubject(Subject);

//            // content
//            msgs.setText(msg);
            // HTML email
            msgs.setDataHandler(new DataHandler(new HTMLDataSource(msg)));

            msgs.setSentDate(new Date());
            //Message msg = new MimeMessage(session);

            try {

                // text
                MimeBodyPart p1 = new MimeBodyPart();
                //   p1.setContent(this.msg, "text/html; charset=utf-8");
                p1.setDataHandler(new DataHandler(new HTMLDataSource(msg)));

                // file
                MimeBodyPart p2 = new MimeBodyPart();
                FileDataSource fds = new FileDataSource("C:\\ALB\\ALBlogo.png");
                p2.setDataHandler(new DataHandler(fds));
                p2.setDisposition(MimeBodyPart.INLINE);
                p2.setHeader("Content-ID", "<ALBlogo.png>");
                p2.setFileName(fds.getName());

//                //   Form
//                MimeBodyPart p3 = new MimeBodyPart();
//                FileDataSource fds2 = new FileDataSource(FilePath);
//                p3.setDataHandler(new DataHandler(fds2));
//                p3.setDisposition(MimeBodyPart.ATTACHMENT);
//                p3.setFileName(fds2.getName());
                Multipart mp = new MimeMultipart();
                mp.addBodyPart(p1);
                mp.addBodyPart(p2);
//                mp.addBodyPart(p3);

                msgs.setContent(mp);

                // Get SMTPTransport
                SMTPTransport t = (SMTPTransport) session.getTransport("smtp");

                // connect
                t.connect(SMTP_SERVER, USERNAME, PASSWORD);

                // send
                t.sendMessage(msgs, msgs.getAllRecipients());
                AuditLogs.UpdateEmailLog(EmailLogID, "1", t.getLastServerResponse());
                System.out.println("Response: " + t.getLastServerResponse());

                t.close();
                returno = true;
            } catch (MessagingException e) {
                e.printStackTrace();
            }

        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(SendEmail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returno;
    }

    private static String EmailFormat(int Type, String Message, String Receivername) {
        String message = "";
        if (Type == 1) {
            StringBuffer texto = new StringBuffer();
            texto.append(" <head>\n"
                    //     + "        <!--link href=\"startbootstrap-sb-admin-3.3.7/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
                    + "\n"
                    + "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                    + "        <title>JSP Page</title> \n"
                    + "    <h1>\n"
                    + "\n"
                    + "    </h1>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "\n"
                    + "    <table width=\"100%\">\n"
                    + "        <tbody>\n"
                    + "<tr>\n"
                    + "    <td>\n"
                    + "<center>\n"
                    + "    <div class=\"col-lg-4\"></div>\n"
                    + "    <div class=\"panel panel-green col-lg-5\">\n"
                    + "        <div class=\"panel-heading clearfix\">\n"
                    + "        </div>\n"
                    + "        <div class=\"panel-body\">\n"
                    + "            <div>\n"
                    + "                <h3><p align=\"left\">\n"
                    + "                    Hi \n" + "");

            texto.append(Receivername);
            texto.append("!  <br/>\n"
                    + "<br/>\n"
                    + "                </p></h3>\n"
                    + "            </div>\n"
                    + "<div>\n"
                    + "                <p align=\"left\">\n"
                    + "                     \n" + " Good Day! <br></p>\n"
                    + "            </div>"
                    + "            <div>\n"
                    + "                <p align=\"left\">\n"
                    + "                     \n" + "<br>");
            texto.append(Message);
            texto.append("    </p>\n"
                    + "            </div>"
                    + "<div>\n"
                    + "            <hr>    <h5><p align=\"left\">\n"
                    + "                    " + Disclaimer + "  <br/>\n"
                    + "<br/>\n"
                    + "                </p></h5>\n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "    <div class=\"col-lg-4\"></div>\n"
                    + "    \n"
                    + "\n"
                    + "\n"
                    + "</center>\n"
                    + "</td>\n"
                    + "</tr>\n"
                    + "\n"
                    + "</tbody>\n"
                    + "</table>\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "</body>\n"
                    + "");
            //  texto.append("<h4 align='left'>Powered by:<img align=\"center\" src='https://www.allbank.ph/wp-content/uploads/2017/11/cropped-logo-2.png' width=\"150\" height=\"50\" alt='https://allbank.ph/'/></h4>");
            texto.append(" <div>" + Disclaimer + "</div> <br> <br> <br> <em style=\"font-size:small\">Powered by </em> <br /><a href=\"http://10.232.236.14\"><img width=\"126\" height=\"50\" style=\"width:126px\" alt=\"Powered By ALB-Intranet\" src=\"cid:ALBlogo.png\" /></a> ");
            message = texto.toString();
        } else if (Type == 2) {
            StringBuffer texto = new StringBuffer();
            texto.append(" <head>\n"
                    //     + "        <!--link href=\"startbootstrap-sb-admin-3.3.7/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
                    + "\n"
                    + "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                    + "  \n"
                    + "    <h1>\n"
                    + "\n"
                    + "    </h1>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "\n"
                    + "    <table width=\"100%\">\n"
                    + "        <tbody>\n"
                    + "<tr>\n"
                    + "    <td>\n"
                    + "\n"
                    + "    <div class=\"col-lg-4\"></div>\n"
                    + "    <div class=\"panel panel-green col-lg-5\">\n"
                    + "        <div class=\"panel-heading clearfix\">\n"
                    + "        </div>\n"
                    + "        <div class=\"panel-body\">\n"
                    + "            <div>\n"
                    + "                <h3><p align=\"left\">\n"
                    + "                    Hi \n" + "");

            texto.append(Receivername);
            texto.append("!\n"
                    + "\n"
                    + "                </p></h3>\n"
                    + "            </div>\n"
                    + "<div>\n"
                    + "            </div>"
                    + "            <div>\n"
                    + "                <p align=\"left\">\n"
                    + "                     \n" + "");
            texto.append(Message);
            texto.append("    </p>\n"
                    + "            </div>"
                    + "<div>\n"
                    + "            <hr>    <h5><p align=\"left\">\n"
                    + "                    <br/>\n"
                    + "<br/>\n"
                    + "                </p></h5>\n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "    <div class=\"col-lg-4\"></div>\n"
                    + "    \n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "</td>\n"
                    + "</tr>\n"
                    + "\n"
                    + "</tbody>\n"
                    + "</table>\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "</body>\n"
                    + "");
            //  texto.append("<h4 align='left'>Powered by:<img align=\"center\" src='https://www.allbank.ph/wp-content/uploads/2017/11/cropped-logo-2.png' width=\"150\" height=\"50\" alt='https://allbank.ph/'/></h4>");
            texto.append(" <div>To view or respond to the Incident, please login to the Incident Report Management system.</div> <br> <em style=\"font-size:small\">Powered by </em> <br /><a href=\"http://10.232.236.14\"><img width=\"126\" height=\"50\" style=\"width:126px\" alt=\"Powered By ALB-Intranet\" src=\"cid:ALBlogo.png\" /></a> ");
            message = texto.toString();
        }

        return message;
    }

    static class HTMLDataSource implements DataSource {

        private String html;

        public HTMLDataSource(String htmlString) {
            html = htmlString;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            if (html == null) {
                throw new IOException("html message is null!");
            }
            return new ByteArrayInputStream(html.getBytes());
        }

        @Override
        public OutputStream getOutputStream() throws IOException {
            throw new IOException("This DataHandler cannot write HTML");
        }

        @Override
        public String getContentType() {
            return "text/html";
        }

        @Override
        public String getName() {
            return "HTMLDataSource";
        }
    }
}
