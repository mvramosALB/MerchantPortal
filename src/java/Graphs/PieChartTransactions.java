/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Graphs;

import API.CaptureData;
import static API.CaptureData.getResponseAttributesArray;
import static API.CaptureData.getResponseAttributesArrayName;
import Models.Charts;
import Models.Merchants;
import Models.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author IT-Programmer
 */
public class PieChartTransactions extends HttpServlet {

    private String GLOBAL_SEARCH_TERM;
    private String COLUMN_NAME;
    private String DIRECTION;
    private int INITIAL;
    private int RECORD_SIZE;

    String FilterProcessStatus = "";
    String whereClause = "";

    Merchants m = new Merchants();
    Users u = new Users();

    Charts C = new Charts();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String PieChartType = "Others";
        PieChartType = request.getParameter("PieChartType");
        if (PieChartType.equals("Internal")) {
            String ChartValues = C.GetPieChartOnboarded();
            ChartValues = ChartValues.replace("   ,", "");
            System.out.println("Chart Value : " + ChartValues);
            PrintWriter out = response.getWriter();
            out.print(ChartValues);

        } else {
            HttpSession session = request.getSession();
            String MerchType = "2";//
            String sdate = "2021-01-01";
            String edate = request.getParameter("EDate");
            String AccountNumber = request.getParameter("AccountNumber");
            String OnboardType = "1";
            String[] arrOfStr = AccountNumber.split(",", 3);
            String bch = arrOfStr[0];
            String acct_no = arrOfStr[1];

            String SDate = FormatDate(sdate);
            String EDate = FormatDate(edate);
            System.out.println("SDate : " + SDate);
            System.out.println("EDate : " + EDate);
            String responseFromAPI = CaptureData.RequestAPI("GetMerchantTransactions",
                    "merc_type=\"0\"\n"
                    + " sdate=\"" + SDate + "\"\n"
                    + " edate=\"" + EDate + "\"\n"
                    + " bch=\"" + bch + "\"\n"
                    + " acct_no=\"" + acct_no + "\""
                    + " tid='0'");
            System.out.println("responseFromAPI: " + responseFromAPI);
            String[][] AttrVal = getResponseAttributesArray(responseFromAPI, "i");
            String[][] AttrNames = getResponseAttributesArrayName(responseFromAPI, "i");
            System.out.println("TR Counts " + AttrVal.length);

            String responseFromAPI2 = CaptureData.RequestAPI("GetMerchantTransactions",
                    "merc_type=\"1\"\n"
                    + " sdate=\"" + SDate + "\"\n"
                    + " edate=\"" + EDate + "\"\n"
                    + " bch=\"" + bch + "\"\n"
                    + " acct_no=\"" + acct_no + "\"");
            System.out.println("responseFromAPI: " + responseFromAPI2);
            String[][] AttrVal2 = getResponseAttributesArray(responseFromAPI2, "i");
            String[][] AttrNames2 = getResponseAttributesArrayName(responseFromAPI2, "i");
            System.out.println("TR Counts " + AttrVal2.length);

            int totalRecords = 0;
            totalRecords = AttrVal.length;
            JSONArray jsonArray = new JSONArray();
            jsonArray.put(totalRecords);
            jsonArray.put(AttrVal2.length);
            response.setContentType("application/json");
            response.setHeader("Cache-Control", "no-store");
            PrintWriter out = response.getWriter();
            out.print(jsonArray);
        }
    }

    private static String FormatDate(String MyDate) {
        LocalDate StartDate = LocalDate.parse(MyDate);
        String SDate = StartDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        return SDate;
    }
}
