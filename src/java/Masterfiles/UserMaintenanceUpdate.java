/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Masterfiles;

import Models.AuditLogs;
import Models.Users;
import Security.Client;
import Security.Hashing;
import Sending.SendEmail;
import Sending.SendSMS;
import Tools.CodeGenerator;
import java.io.IOException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IT-Programmer
 */
public class UserMaintenanceUpdate extends HttpServlet {

    Users U = new Users();
    Client CF = new Client();
    AuditLogs logs = new AuditLogs();
    CodeGenerator CG = new CodeGenerator();
    SendSMS SMS = new SendSMS();
    SendEmail Email = new SendEmail();
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ClientIP = CF.getClientIp(request);
        HttpSession session = request.getSession();
        String UserID = session.getAttribute("USERID").toString();
        int action = Integer.parseInt(request.getParameter("action"));
        String mess = "", color = "", title = "";
        String UserGroup = request.getParameter("UserGroup");
        String FullName = request.getParameter("UserFname");
        String UserName = request.getParameter("Username");
        String MobileNumber = request.getParameter("UserMobileNumber");
        String Email = request.getParameter("UserEmail");
        String MerchID = request.getParameter("Merchant");
        String BranchID = "";
        String UsedUserID = "";
        if (UserGroup.equals("5")) {
            String[] BranchIDArray = request.getParameterValues("Branch");
            BranchID = Arrays.toString(BranchIDArray).replace("[", "").replace("]", "").replace(" ", "");
        } else {
            BranchID = request.getParameter("Branch");
        }

        String TerminalID = request.getParameter("Terminal");
        if (action == 1) {

            //Check if username Exist
            if (!U.CheckUserExist(UserName)) {
                
                        String PassNotif = request.getParameter("PassNotif");
                        String PasswordGenerated = CG.RandomCode(8);
                        String Password = Hashing.getShai256(UserName);
                        String CreatedBy = UserID;
                        String UserIDCreated = U.AddUser(FullName, UserName, Password, CreatedBy, CreatedBy, UserGroup);
                        if (U.AddUserInfo(UserIDCreated, MobileNumber, Email, CreatedBy, MerchID, BranchID, TerminalID)) {
                            title = "Success";
                            color = "success";
                            mess = "Add Success!";
                            if (PassNotif.equals("SMS")) {
                                SMS.SendSMS(MobileNumber, "You Temporary Password is :" + PasswordGenerated, CreatedBy,"RisingTide");
                            } else {
                                try {
                                    Sending.SendEmail.SendEmail(1, Email, FullName, "You Temporary Password is <b>"+PasswordGenerated+"</b>", "", "Disclaimer", "Footer", "Merchant Portal",UserID);
                                } catch (ClassNotFoundException ex) {
                                    Logger.getLogger(UserMaintenanceUpdate.class.getName()).log(Level.SEVERE, null, ex);
                                }

                            }
                            logs.AddLog("MASTERUPDATE", "SUCADDUSER", UserID, ClientIP, UserIDCreated);
                        } else {
                            title = "Alert";
                            color = "danger";
                            mess = "Add Failed!";
                            logs.AddLog("MASTERUPDATE", "FAIADDUSER", UserID, ClientIP, "");
                        }
                        UsedUserID = UserIDCreated;
//                if (!U.CheckUserMobileExist(MobileNumber)) {
//                    if (!U.CheckUserEmailExist(Email)) {
//                    } else {
//                        title = "Alert";
//                        color = "danger";
//                        mess = "Email Address Already Exist!";
//                        logs.AddLog("MASTERUPDATE", "FAIADDUSER", UserID, ClientIP, "UserName : " + UserName);
//                    }
//                } else {
//                    title = "Alert";
//                    color = "danger";
//                    mess = "Mobile Number Already Exist!";
//                    logs.AddLog("MASTERUPDATE", "FAIADDUSER", UserID, ClientIP, "UserName : " + UserName);
//                }

            } else {
                title = "Alert";
                color = "danger";
                mess = "Username Already Exist!";
                logs.AddLog("MASTERUPDATE", "FAIADDUSER", UserID, ClientIP, "UserName : " + UserName);
            }

        } else {
            String ToEditUserID = request.getParameter("UserID");
            UsedUserID = ToEditUserID;
            if (U.UpdateUser(ToEditUserID, FullName, UserName, UserGroup, MobileNumber, Email, MerchID, BranchID, TerminalID, UserID)) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("MASTERUPDATE", "SUCUPDATEUSER", UserID, ClientIP, ToEditUserID);
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("MASTERUPDATE", "FAIUPDATEUSER", UserID, ClientIP, ToEditUserID);
            }

        }

        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + UsedUserID);
    }
}
