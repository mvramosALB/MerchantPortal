/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

import Models.Users;
import java.io.IOException;
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
public class ChangePassword extends HttpServlet {

    Users U = new Users();
    //  LOGS logs = new LOGS();
    //  Client CF = new Client();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //   String ClientIP = CF.getClientIp(request);
        String Password = request.getParameter("newpass");
        //  int action = Integer.parseInt(request.getParameter("action"));
        HttpSession session = request.getSession();

        String UserID = session.getAttribute("USERNAME").toString();
        String UserType = U.GetUsersInfo(UserID, "User_Group");

        String mess = "", color = "", title = "";

        try {
            //Update
            if (U.UpdatePassword(UserID, Password)) {
                title = "Success";
                color = "success";
                mess = "Password changed!";
                    session.removeAttribute("USERID");
        session.removeAttribute("USERNAME");
        session.removeAttribute("UserType");
        session.invalidate();
                //  logs.AddLog("SECPASS", "SUCCHANGEPASS", UserID, ClientIP,"");
                // logs.AddLog("Success", "Security", "Changing of password", UserID, "Change Password", ClientIP);
            } else {
                title = "Alert";
                color = "danger";
                mess = "Password changing failed!";
                //  logs.AddLog("SECPASS", "FAICHANGEPASS", UserID, ClientIP,"");
                //   logs.AddLog("Failed", "Security", "Changing of password", UserID, "Change Password", ClientIP);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ChangePassword.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + UserType);
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
