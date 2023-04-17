/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Graphs;

import Models.Charts;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IT-Programmer
 */
@WebServlet(name = "SegregatedTransactions", urlPatterns = {"/SegregatedTransactions"})
public class SegregatedTransactions extends HttpServlet {

    Charts C = new Charts();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ChartValues = "0,0,0";
        String AccountNumber = request.getParameter("AccountNumber");
        ChartValues = C.GetSegregatedReportTransactions(AccountNumber);
        System.out.println("Chart Value Total Transaction: " + ChartValues);
        PrintWriter out = response.getWriter();
        out.print(ChartValues);
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
