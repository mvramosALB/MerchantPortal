/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Sending.SendEmail;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IT-Programmer
 */
public class TestEmailSending extends HttpServlet {

    SendEmail SE = new SendEmail();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Sending.SendEmail.SendEmail(1, "vgponciano@allbank.ph", "Veron", "your OTP is <b>12354</b>", "", "Disclaimer", "Footer", "Test Subject","");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TestEmailSending.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
