/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Graphs;

import Models.Charts;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IT-Programmer
 */
public class AreaChartTransactions extends HttpServlet {

    Charts C = new Charts();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String AreaChartType = request.getParameter("AreaChartType");
        String ChartValues = "";
        if (AreaChartType.equals("Internal")) {
            ChartValues = C.GetAreaChartOnboarded();
            ChartValues = ChartValues.replace("   ,", "");
        } else if (AreaChartType.equals("MerchantOverview")) {
            String AccountNumber = request.getParameter("AccountNumber");
            ChartValues = C.GetTransactionsOverview(AccountNumber);
        }
        System.out.println("Chart Value : " + ChartValues);
        PrintWriter out = response.getWriter();
        out.print(ChartValues);
    }

    private static String FormatDate(String MyDate) {
        LocalDate StartDate = LocalDate.parse(MyDate);
        String SDate = StartDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        return SDate;
    }

}
