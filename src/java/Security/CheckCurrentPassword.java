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
public class CheckCurrentPassword extends HttpServlet {
    

    Users U = new Users();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mess = "", color = "", title = "";
        HttpSession session = request.getSession();
        String UserID = session.getAttribute("USERNAME").toString();
        String CPassword = request.getParameter("cpass");
        if (U.CheckUserLogin(UserID, CPassword)) {
            title = "Success";
            color = "success";
            mess = "Matched!";
        } else {
            title = "Alert";
            color = "danger";
            mess = "Wrong!";
        }
        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;");
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
