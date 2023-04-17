/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

import Models.Users;
import java.io.IOException;
import java.io.PrintWriter;
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
public class ResetPassword extends HttpServlet {

    Users U = new Users();
    //LOGS logs = new LOGS();
    //Client CF = new Client();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ResetPassword");
        String mess = "", color = "", title = "";
        String UserType="";
        try {
            String Password = request.getParameter("newpass");
            HttpSession session = request.getSession();
            String UserID = session.getAttribute("NewPassUsername").toString();
            if (UserID.equals("")) {
                UserID = session.getAttribute("USERNAME").toString();
            }
            if (U.ResetPassword(UserID, Password)) {
                U.UpdateUserStatus(UserID, 1);
                U.UpdateUserLastLogin(UserID);

                session.setAttribute("NewUserLogin", U.GetUsersInfo(UserID, "last_login"));
                System.out.println("NewUserLogin : " + session.getAttribute("NewUserLogin").toString());
                title = "Success";
                color = "success";
                mess = "Password changed!";
            } else {
                title = "Alert";
                color = "danger";
                mess = "Password changing failed!";
                //   logs.AddLog("SECPASS", "FAIRESETPASS", UserID, ClientIP, "");
                //    logs.AddLog("Failed", "Security", "Password changing failed", UserID, "Reset Password",ClientIP);
                UserType=U.GetUsersInfo(UserID, "user_group");
            }
            System.out.println(title + ";;" + color + ";;" + mess + ";;");
            response.getWriter().print(title + ";;" + color + ";;" + mess + ";;"+UserType);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ResetPassword.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
