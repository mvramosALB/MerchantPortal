/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

import Models.Users;
import Models.keys;
import static Sending.SendEmail.SendEmail;
import Sending.SendSMS;
import Tools.CodeGenerator;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.validator.constraints.Email;

/**
 *
 * @author IT-Programmer
 */
public class ForgotPassword extends HttpServlet {

    Users U = new Users();
    SendSMS sms = new SendSMS();
    CodeGenerator Code = new CodeGenerator();
    keys k = new keys();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String UserID = "";
        String mess = "", color = "", title = "";

        String action = request.getParameter("action");
        if (action.equals("1")) {
            //Step 1
            String UserName = request.getParameter("UserName");
            String OTPType = request.getParameter("OTPType");
            if (U.CheckUserExist(UserName)) {
                UserID = U.GetUsersInfo(UserName, "userid");
                String OTP = Code.RandomCode(6);
                while (k.CheckKeyExists(OTP)) {
                    OTP = Code.RandomCode(6).toString();
                }
                if ((!"".equals(U.GetUsersInfo2(UserID, "mobile_number")) && OTPType.equals("sms")) || (!"".equals(U.GetUsersInfo2(UserID, "email")) && OTPType.equals("email"))) {
                    if (OTPType.equals("sms")) {
                        //ADD Sending of Code to SMS
                        if (sms.SendSMS(U.GetUsersInfo2(UserID, "mobile_number"), "Your One Time Password (OTP) is " + OTP, UserName,"RisingTide")) {
                            title = "Success";
                            color = "success";
                            mess = "Enter OTP";
                        } else {
                            title = "Alert";
                            color = "danger";
                            mess = "Failed to Send OTP";
                        }
                    } else if (OTPType.equals("email")) {
                        System.out.println("Sending Email");
                        try {
                            if (Sending.SendEmail.SendEmail(1, U.GetUsersInfo2(UserID, "email"), U.GetUsersInfo(UserName, "USER_FULLNAME"), "Your One Time Password (OTP) is <b>" + OTP + "</b>", "", "Disclaimer", "Footer", "Merchant Portal",UserID)) {
                                title = "Success";
                                color = "success";
                                mess = "Enter OTP";
                            } else {
                                title = "Alert";
                                color = "danger";
                                mess = "Failed to Send OTP";
                            }
                        } catch (ClassNotFoundException ex) {
                            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }

                    //save key to database
                    k.AddKey(UserName, OTP);

                } else {
                    title = "Alert";
                    color = "danger";
                    mess = "No Mobile Number is registered! Please contact your System Admin for mobile Registration";
                }

            } else {
                title = "Alert";
                color = "danger";
                mess = "User is not registered!";
                // logs.AddLog("SECPASS", "FAISENDOTP2", Email, ClientIP, "");
                //     logs.AddLog("Failed", "Security", "Email Address is not registered", Email, "Forgot Password",ClientIP);
            }

        } else if (action.equals("2")) {//Step 2

            String UserName = request.getParameter("UserName");
            String OTP = request.getParameter("OTP");
            if (k.VerifyKey(OTP, UserName).equals("1")) {
                title = "Alert";
                color = "danger";
                mess = "OTP Already Used!";
                //    logs.AddLog("SECPASS", "FAICHECKOTP", Email, ClientIP, "");
                //       logs.AddLog("Failed", "Security", "OTP Already Used", Email, "Forgot Password",ClientIP);
            } else if (k.VerifyKey(OTP, UserName).equals("0")) {
                HttpSession session = request.getSession();
                session.setAttribute("NewPassUsername", UserName);
                title = "Success";
                color = "success";
                mess = "Enter New Password";
                //   logs.AddLog("SECPASS", "SUCCHECKOTP", Email, ClientIP, "");
                //     logs.AddLog("Success", "Security", "OTP Matched", Email, "Forgot Password",ClientIP);
            } else {
                title = "Alert";
                color = "danger";
                mess = k.VerifyKey(OTP, UserName);
            }

        }

        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;");
    }
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.getWriter().print("Forgot Password Get");
    }
}
