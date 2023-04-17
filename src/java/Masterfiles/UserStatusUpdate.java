/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Masterfiles;

import Models.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IT-Programmer
 */
public class UserStatusUpdate extends HttpServlet {

    Users U = new Users();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int action = Integer.parseInt(request.getParameter("action"));
        String USERID = request.getParameter("id");
        String mess = "", color = "", title = "";

        if (U.UpdateUserStatus(USERID, action)) {
            title = "Success";
            color = "success";
            mess = "Update Success!";
        } else {
            title = "Alert";
            color = "danger";
            mess = "Update Failed!";
        }
           response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + USERID);
     }

}
