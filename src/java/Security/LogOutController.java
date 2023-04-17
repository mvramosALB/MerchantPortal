/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

import Models.AuditLogs;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IT-Programmer
 */
public class LogOutController extends HttpServlet {

    AuditLogs logs = new AuditLogs();
    Client CF = new Client();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Logging out .... ");
        String ClientIP = CF.getClientIp(request);
        HttpSession session = request.getSession();
//        String UserType = session.getAttribute("UserType").toString();
        logs.AddLog("AUTH", "SUCLOGOUT", session.getAttribute("USERID").toString(), ClientIP, "");
        session.removeAttribute("USERID");
        session.removeAttribute("USERNAME");
        session.removeAttribute("UserType");
        session.invalidate();
        String mess = "", color = "", title = "";
        title = "Success";
        color = "success";
        mess = "Log Out Success!";
        System.out.println(title + ";;" + color + ";;" + mess + ";;" + "");
        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + "");

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
