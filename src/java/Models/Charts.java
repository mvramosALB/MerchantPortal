/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import API.CaptureData;
import static API.CaptureData.getResponseAttributesArray;
import static API.CaptureData.getResponseAttributesArrayName;
import static API.CaptureData.getResponseAttributesString;
import Security.DBConnection;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author IT-Programmer
 */
public class Charts {

    public String GetAreaChartOnboarded() {
        boolean returno = false;
        Connection con = null;
        String Month = "";
        String DataValues = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC GetAreaChartOnboarded";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            ResultSet rs = UpdateLOGS.executeQuery();
            while (rs.next()) {
                Month = rs.getString("months");
                DataValues = rs.getString("DataValues");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return Month + ";;" + DataValues;

    }

    public String GetPieChartOnboarded() {
        boolean returno = false;
        Connection con = null;
        String P2M = "";
        String POS = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC GetPieChartOnboarded";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            ResultSet rs = UpdateLOGS.executeQuery();
            while (rs.next()) {
                P2M = rs.getString("p2mCount");
                POS = rs.getString("posCount");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(AuditLogs.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return P2M + ";;" + POS;

    }

    public String GetSegregatedReportTransactions(String Account) {
        String success1 = "0", pending1 = "0", expired1 = "0";
        String success2 = "0", pending2 = "0", expired2 = "0";
        String returno = "0";
        String AccountNumber = Account;
        String[] arrOfStr = AccountNumber.split(",", 3);
        String bch = arrOfStr[0];
        String acct_no = arrOfStr[1];

        //Static
        String responseFromAPI1 = CaptureData.RequestAPI("GetDashboardTotalCounts",
                "merc_type=\"0\" "
                + " bch=\"" + bch + "\"\n"
                + " acct_no=\"" + acct_no + "\"");
        System.out.println("responseFromAPI Segregated Report: " + responseFromAPI1);
        String ReturnCode = getResponseAttributesString(responseFromAPI1, "ALB.Info", "ReturnCode");
        if (ReturnCode.equals("0")) {
            success1 = getResponseAttributesString(responseFromAPI1, "i", "success");
            pending1 = getResponseAttributesString(responseFromAPI1, "i", "pending");
            expired1 = getResponseAttributesString(responseFromAPI1, "i", "expired");
            System.out.println("Success1 : " + success1);
            System.out.println("pending1 : " + pending1);
            System.out.println("expired1 : " + expired1);
            //API
            String responseFromAPI2 = CaptureData.RequestAPI("GetDashboardTotalCounts",
                    "merc_type=\"1\" "
                    + " bch=\"" + bch + "\"\n"
                    + " acct_no=\"" + acct_no + "\"");
            System.out.println("responseFromAPI Segregated Report: " + responseFromAPI2);
            success2 = getResponseAttributesString(responseFromAPI2, "i", "success");
            pending2 = getResponseAttributesString(responseFromAPI2, "i", "pending");
            expired2 = getResponseAttributesString(responseFromAPI2, "i", "expired");
            System.out.println("Success2 : " + success2);
            System.out.println("pending2 : " + pending2);
            System.out.println("expired2 : " + expired2);
            if (success1.equals("") && success1.equals("") && pending1.equals("") && pending2.equals("") && expired1.equals("") && expired2.equals("")) {
                success1 = "0";
                pending1 = "0";
                expired1 = "0";
                success2 = "0";
                pending2 = "0";
                expired2 = "0";
            }

            returno = (Integer.parseInt(success1) + Integer.parseInt(success2)) + "," + (Integer.parseInt(pending1) + Integer.parseInt(pending2)) + "," + (Integer.parseInt(expired1) + Integer.parseInt(expired2)) + ";;" + (Integer.parseInt(success1)) + "," + (Integer.parseInt(pending1)) + "," + (Integer.parseInt(expired1)) + ";;" + (Integer.parseInt(success2)) + "," + (Integer.parseInt(pending2)) + "," + (Integer.parseInt(expired2));

        } else {

            returno = (Integer.parseInt(success1) + Integer.parseInt(success2)) + "," + (Integer.parseInt(pending1) + Integer.parseInt(pending2)) + "," + (Integer.parseInt(expired1) + Integer.parseInt(expired2)) + ";;" + (Integer.parseInt(success1)) + "," + (Integer.parseInt(pending1)) + "," + (Integer.parseInt(expired1)) + ";;" + (Integer.parseInt(success2)) + "," + (Integer.parseInt(pending2)) + "," + (Integer.parseInt(expired2));
        }
        return returno;
    }

    public String GetTransactionsOverview(String Account) {

        String returno = "";
        String AccountNumber = Account;
        String[] arrOfStr = AccountNumber.split(",", 3);
        String bch = arrOfStr[0];
        String acct_no = arrOfStr[1];
        //Static
        String responseFromAPI1 = CaptureData.RequestAPI("GetDashboardOverview",
                "merc_type=\"0\" "
                + " sdate=\"" + GetMytdt() + "\""
                + " bch=\"" + bch + "\"\n"
                + " acct_no=\"" + acct_no + "\"");
        System.out.println("responseFromAPI Overview Report: " + responseFromAPI1);
        String[][] AttrVal1 = getResponseAttributesArray(responseFromAPI1, "i");
        String[][] AttrNames1 = getResponseAttributesArrayName(responseFromAPI1, "i");
        //API
        String responseFromAPI2 = CaptureData.RequestAPI("GetDashboardOverview",
                "merc_type=\"1\" "
                + " sdate=\"" + GetMytdt() + "\""
                + " bch=\"" + bch + "\"\n"
                + " acct_no=\"" + acct_no + "\"");
        System.out.println("responseFromAPI Overview Report: " + responseFromAPI2);
      
          String ReturnCode = getResponseAttributesString(responseFromAPI1, "ALB.Info", "ReturnCode");
        if (ReturnCode.equals("0")) {
        
        String[][] AttrVal2 = getResponseAttributesArray(responseFromAPI2, "i");
        String[][] AttrNames2 = getResponseAttributesArrayName(responseFromAPI2, "i");

        System.out.println("AttrNames1 :" + AttrNames2[0][0]);
        System.out.println("AttrNames2 :" + AttrNames2[2][0]);
        System.out.println("ArrayVal1 :" + AttrVal2[0][0]);
        System.out.println("ArrayVal2 :" + AttrVal2[1][0]);

        int rowLength = AttrVal2.length;
        String[] MonthYear = new String[rowLength];
        String[] Data = new String[rowLength];

        for (int i = 0; i < rowLength; i++) {
            MonthYear[i] = AttrVal2[i][1];
            Data[i] = (Integer.parseInt(AttrVal1[i][0]) + Integer.parseInt(AttrVal2[i][0])) + "";
        }

        System.out.println(Arrays.toString(MonthYear));
        System.out.println(Arrays.toString(Data));
        returno = Arrays.toString(MonthYear) + ";;" + Arrays.toString(Data);
        }else{
        
        returno =  "no data;;0";
        }
        return returno.replace("[", "").replace("]", "");
    }
//   public String GetSegregatedReportTransactions(String Account,String EndDate) {
//        String returno="";
//        String sdate = "2021-01-01";
//        String edate = EndDate;
//        String AccountNumber = Account;
//        String OnboardType = "1";
//        String[] arrOfStr = AccountNumber.split(",", 3);
//        String bch = arrOfStr[0];
//        String acct_no = arrOfStr[1];
//
//        String SDate = FormatDate(sdate);
//        String EDate = FormatDate(edate);
//        System.out.println("SDate : " + SDate);
//        System.out.println("EDate : " + EDate);
//        
//        //Static
//        String responseFromAPI = CaptureData.RequestAPI("GetMerchantTransactions",
//                "merc_type=\"0\"\n"
//                + " sdate=\"" + SDate + "\"\n"
//                + " edate=\"" + EDate + "\"\n"
//                + " bch=\"" + bch + "\"\n"
//                + " acct_no=\"" + acct_no + "\""
//                + " tid='0'");
//        System.out.println("responseFromAPI: " + responseFromAPI);
//        String[][] AttrVal = getResponseAttributesArray(responseFromAPI, "i");
//        String[][] AttrNames = getResponseAttributesArrayName(responseFromAPI, "i");
//        System.out.println("TR Counts " + AttrVal.length);
//
//        //Dynamic
//        String responseFromAPI2 = CaptureData.RequestAPI("GetMerchantTransactions",
//                "merc_type=\"1\"\n"
//                + " sdate=\"" + SDate + "\"\n"
//                + " edate=\"" + EDate + "\"\n"
//                + " bch=\"" + bch + "\"\n"
//                + " acct_no=\"" + acct_no + "\"");
//        System.out.println("responseFromAPI: " + responseFromAPI2);
//        String[][] AttrVal2 = getResponseAttributesArray(responseFromAPI2, "i");
//        String[][] AttrNames2 = getResponseAttributesArrayName(responseFromAPI2, "i");
//        System.out.println("TR Counts " + AttrVal2.length);
////        JSONArray jsonArray = new JSONArray();
////        for (String[] ca : AttrVal) {
////            JSONArray arr = new JSONArray();
////            for (String c : ca) {
////                arr.put(c); // or some other conversion
////            }
////            jsonArray.put(arr);
////        }
//        int totalRecords = 0;
//        totalRecords = AttrVal.length;
//        JSONArray jsonArray = new JSONArray();
//        jsonArray.put(totalRecords);
//        jsonArray.put(AttrVal2.length);
//     
//        returno=jsonArray.toString();
//        return returno;
//    }

    private static String FormatDate(String MyDate) {
        LocalDate StartDate = LocalDate.parse(MyDate);
        String SDate = StartDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        return SDate;
    }

    public static String GetMytdt() {
        //TimeZone tz = TimeZone.getTimeZone("UTC");
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy"); // Quoted "Z" to indicate UTC, no timezone offset
        //df.setTimeZone(tz);
        String nowAsISO = df.format(new Date());
        System.out.println("tdt now: " + nowAsISO);
        return nowAsISO;
    }
}
