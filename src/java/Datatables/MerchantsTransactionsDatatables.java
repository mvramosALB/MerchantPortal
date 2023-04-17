/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datatables;

import API.CaptureData;
import static API.CaptureData.getResponseAttributesArray;
import static API.CaptureData.getResponseAttributesArrayName;
import Models.Merchants;
import Models.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author IT-Programmer
 */
public class MerchantsTransactionsDatatables extends HttpServlet {

    private String GLOBAL_SEARCH_TERM;
    private String COLUMN_NAME;
    private String DIRECTION;
    private int INITIAL;
    private int RECORD_SIZE;

    String FilterProcessStatus = "";
    String whereClause = "";

    Merchants m = new Merchants();
    Users u = new Users();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String MerchType = "2";//
        String sdate = request.getParameter("SDate");
        String edate = request.getParameter("EDate");
        String AccountNumber = request.getParameter("AccountNumber");
        String OnboardType = request.getParameter("OnboardType");
        String TerminalID = "0";
        //check if there is terminal ID
        try {
            TerminalID = request.getParameter("TerminalID");
        } catch (Exception e) {
            TerminalID = "0";
        }
        // System.out.println("Terminal Numbers : " + TerminalID + " Terminal Lenght : " + Terminals.length);
        //TerminalID = TerminalID.replaceAll("|", ",");
        System.out.println("TerminalID  :" + TerminalID);
        String[] Terminals = TerminalID.split(",");
        System.out.println("Terminal Numbers : " + TerminalID + " Terminal Lenght : " + Terminals.length);
        int TerminalCount = Terminals.length;
        if (TerminalCount > 1) {
            TerminalID = Terminals[1];
        } else {
            TerminalID = TerminalID;
        }

        String[] arrOfStr = AccountNumber.split(",", 2);
        String bch = arrOfStr[0];
        String acct_no = arrOfStr[1];

        String SDate = FormatDate(sdate);
        String EDate = FormatDate(edate);
        System.out.println("SDate : " + SDate);
        System.out.println("EDate : " + EDate);

        JSONObject jsonResult = new JSONObject();
        //Added if API
        //API
        if (OnboardType.equals("1")) {
            System.out.println("---------------------API---------------------");
            JSONArray jsonArray = new JSONArray();
            int AttrVallength = 0;
            // System.out.println("Terminal Numbers : " + Terminals.toString() + " Terminal Lenght : " + Terminals.length);
            for (String tid : Terminals) {
                //System.out.println("Terminal Number : " + tid);
                // String bch = m.GetMerchantInfo(u.GetUsersInfo2(session.getAttribute("USERID").toString(), "MERCHID"), "DepositoryBranch");
                //String acct_no = m.GetMerchantInfo(u.GetUsersInfo2(session.getAttribute("USERID").toString(), "MERCHID"), "AccountNumber");
                String responseFromAPI = CaptureData.RequestAPI("GetMerchantTransactions",
                        "merc_type=\"" + OnboardType + "\"\n"
                        + " sdate=\"" + SDate + "\"\n"
                        + " edate=\"" + EDate + "\"\n"
                        + " bch=\"" + bch + "\"\n"
                        + " tid=\"" + tid + "\"\n"
                        + " acct_no=\"" + acct_no + "\"");
                //System.out.println("responseFromAPI: " + responseFromAPI);
                String[][] AttrVal = getResponseAttributesArray(responseFromAPI, "i");
                String[][] AttrNames = getResponseAttributesArrayName(responseFromAPI, "i");
                int rowCount = 0;
                int attrcount = 0;
                rowCount = AttrVal.length;
                System.out.println("attrcount :" + attrcount);
                String[][] AttrValArranged = new String[0][0]; //= new String[rowCount][attrcount];
                if (rowCount > 0) {
                    attrcount = AttrVal[0].length;
                    AttrValArranged = new String[rowCount][attrcount];
                    for (int i = 0; i < AttrVal.length; i++) {//for each row
                        for (int j = 0; j < AttrVal[i].length; j++) {//for each col
                            switch (AttrNames[i][j]) {
                                case "acct_no":
                                    AttrValArranged[i][0] = AttrVal[i][j];
                                    break;
                                case "amt":
                                    AttrValArranged[i][1] = AttrVal[i][j];
                                    break;
                                case "is_expired":
                                    AttrValArranged[i][2] = AttrVal[i][j];
                                    break;
                                case "payment_date":
                                    AttrValArranged[i][3] = AttrVal[i][j];
                                    break;
                                case "reference":
                                    AttrValArranged[i][4] = AttrVal[i][j];
                                    break;
                                case "tid":
                                    AttrValArranged[i][5] = AttrVal[i][j];
                                    break;
                                case "token":
                                    AttrValArranged[i][6] = AttrVal[i][j];
                                    break;
                                case "txn_created":
                                    AttrValArranged[i][7] = AttrVal[i][j];
                                    break;
                                case "s_acct":
                                    AttrValArranged[i][8] = AttrVal[i][j];
                                    if (!AttrVal[i][j].equals("")) {
                                        try {
                                            String maskedacctno = maskString(AttrVal[i][j], 0, AttrVal[i][j].length() - 4, '*');
                                             AttrValArranged[i][8] = maskedacctno;
                                        } catch (Exception ex) {
                                            AttrValArranged[i][8] = "";
                                        }

                                      
                                    }
                                    break;
                                case "s_bank":
                                    AttrValArranged[i][9] = AttrVal[i][j];
                                    if (AttrVal[i][j].equals("Bank info not on file")) {
                                        AttrValArranged[i][9] = "AllBank(if Paid)/None(if not yet Paid)";
                                    }
                                    break;
                                case "s_name":
                                    AttrValArranged[i][10] = AttrVal[i][j];
                                    break;
                                case "ftr_type":
                                    AttrValArranged[i][11] = AttrVal[i][j];
                                    break;
                            }
                        }
                    }
                    System.out.println("AttrValArranged Counts " + AttrValArranged.length);
                    System.out.println("AttrValArranged Counts Names " + AttrValArranged[0].length);
                }

                //get row
                for (String[] ca : AttrValArranged) {
                    JSONArray arr = new JSONArray();
                    //value per row
                    for (String c : ca) {
                        arr.put(c); // or some other conversion
                    }
                    jsonArray.put(arr);
                }

//                for (String[] ca : AttrVal) {
//                    JSONArray arr = new JSONArray();
//                    for (String c : ca) {
//                        arr.put(c); // or some other conversion
//                    }
//                    jsonArray.put(arr);
//                }
                AttrVallength = AttrVallength + AttrVal.length;
            }
            int totalRecords = -1;
            totalRecords = AttrVallength;

            try {
                jsonResult = getPersonDetails(totalRecords, jsonArray);
                System.out.print("jsonResult " + jsonResult);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("---------------------Static---------------------");
            //static
// String bch = m.GetMerchantInfo(u.GetUsersInfo2(session.getAttribute("USERID").toString(), "MERCHID"), "DepositoryBranch");
            //String acct_no = m.GetMerchantInfo(u.GetUsersInfo2(session.getAttribute("USERID").toString(), "MERCHID"), "AccountNumber");
            String responseFromAPI = CaptureData.RequestAPI("GetMerchantTransactions",
                    "merc_type=\"" + OnboardType + "\"\n"
                    + " sdate=\"" + SDate + "\"\n"
                    + " edate=\"" + EDate + "\"\n"
                    + " bch=\"" + bch + "\"\n"
                    + " tid=\"" + TerminalID + "\"\n"
                    + " acct_no=\"" + acct_no + "\"");
            System.out.println("responseFromAPI: " + responseFromAPI);
            String[][] AttrVal = getResponseAttributesArray(responseFromAPI, "i");
            String[][] AttrNames = getResponseAttributesArrayName(responseFromAPI, "i");
            System.out.println("TR Counts " + AttrVal.length);
            System.out.println("TR Counts Names " + AttrNames.length);
            int rowCount = 0;
            int attrcount = 0;
            rowCount = AttrVal.length;
            System.out.println("attrcount :" + attrcount);
            String[][] AttrValArranged = new String[0][0]; //= new String[rowCount][attrcount];
            if (rowCount > 0) {
                attrcount = AttrVal[0].length;
                AttrValArranged = new String[rowCount][attrcount];
                for (int i = 0; i < AttrVal.length; i++) {//for each row
                    for (int j = 0; j < AttrVal[i].length; j++) {//for each col
                        switch (AttrNames[i][j]) {
                            case "amount":
                                AttrValArranged[i][0] = AttrVal[i][j];
                                break;
                            case "tdate":
                                AttrValArranged[i][2] = AttrVal[i][j];
                                break;
                            case "reference":
                                AttrValArranged[i][1] = AttrVal[i][j];
                                break;
                            case "terminal_id":
                                AttrValArranged[i][3] = AttrVal[i][j];
                                break;
                            case "s_acct":
                                  AttrValArranged[i][4] = "";
                                if (!AttrVal[i][j].equals("")) {
                                    try {
                                        String maskedacctno = maskString(AttrVal[i][j], 0, AttrVal[i][j].length() - 4, '*');
                                        AttrValArranged[i][4] = maskedacctno;
                                    } catch (Exception ex) {
                                        AttrValArranged[i][4] = "";
                                    }

                                  
                                }
                                break;
                            case "s_bank":
                                AttrValArranged[i][5] = AttrVal[i][j];
                                if (AttrVal[i][j].equals("Bank info not on file")) {
                                    AttrValArranged[i][5] = "AllBank";
                                }
                                break;
                            case "s_name":
                                AttrValArranged[i][6] = AttrVal[i][j];

                                break;
                            case "ftr_type":
                                AttrValArranged[i][7] = AttrVal[i][j];
                                break;
                        }
                    }
                }
                System.out.println("AttrValArranged Counts " + AttrValArranged.length);
                System.out.println("AttrValArranged Counts Names " + AttrValArranged[0].length);
            }

            JSONArray jsonArray = new JSONArray();
            //get row
            for (String[] ca : AttrValArranged) {
                JSONArray arr = new JSONArray();
                //value per row
                for (String c : ca) {
                    arr.put(c); // or some other conversion
                }
                jsonArray.put(arr);
            }

            int totalRecords = -1;
            totalRecords = AttrVal.length;

            try {
                jsonResult = getPersonDetails(totalRecords, jsonArray);
                System.out.print("jsonResult " + jsonResult);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("application/json");
        response.setHeader("Cache-Control", "no-store");
        PrintWriter out = response.getWriter();
        out.print(jsonResult);
    }

    private static String FormatDate(String MyDate) {
        LocalDate StartDate = LocalDate.parse(MyDate);
        String SDate = StartDate.format(DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        return SDate;
    }

    public int getTotalRecordCount() throws SQLException, ClassNotFoundException {

        int totalRecords = -1;

        return totalRecords;
    }

    public JSONObject getPersonDetails(int totalRecords, JSONArray data)
            throws SQLException, ClassNotFoundException {

        int totalAfterSearch = totalRecords;
        JSONObject result = new JSONObject();

        try {
            result.put("iTotalRecords", totalRecords);
            result.put("iTotalDisplayRecords", totalAfterSearch);
            result.put("aaData", data);
        } catch (Exception e) {

        }

        return result;
    }

    private static String maskString(String strText, int start, int end, char maskChar)
            throws Exception {

        if (strText == null || strText.equals("")) {
            return "";
        }

        if (start < 0) {
            start = 0;
        }

        if (end > strText.length()) {
            end = strText.length();
        }

        if (start > end) {
            throw new Exception("End index cannot be greater than start index");
        }

        int maskLength = end - start;

        if (maskLength == 0) {
            return strText;
        }

        StringBuilder sbMaskString = new StringBuilder(maskLength);

        for (int i = 0; i < maskLength; i++) {
            sbMaskString.append(maskChar);
        }

        return strText.substring(0, start)
                + sbMaskString.toString()
                + strText.substring(start + maskLength);
    }

}
