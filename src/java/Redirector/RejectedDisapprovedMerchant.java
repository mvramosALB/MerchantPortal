/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Redirector;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IT-Programmer
 */
public class RejectedDisapprovedMerchant extends HttpServlet {    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id =request.getParameter("ID");
        String loc =request.getParameter("LOC");
        request.setAttribute("LOC", loc);
        request.setAttribute("ID", id);
        RequestDispatcher rd = request.getRequestDispatcher("RejectedDisapprovedMerchant.jsp");
        rd.forward(request, response);
    }
}
