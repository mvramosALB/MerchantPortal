/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datatables;

import Security.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author IT-Programmer
 */
public class OnBoardTypeDatatables extends HttpServlet {
    
    
    private String GLOBAL_SEARCH_TERM;
    private String COLUMN_NAME;
    private String DIRECTION;
    private int INITIAL;
    private int RECORD_SIZE;
    private String cocode;
    DBConnection db = new DBConnection();
    Connection con;

    String sortSpecialization = "";
    String sortHospital = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonResult = new JSONObject();
        String[] columnNames = {"ID","OB_DESCRIPTION", "ACTIVESTATUS"};
        int listDisplayAmount = 10;
        int start = 0;
        int column = 0;
        String dir = "asc";
        String pageNo = request.getParameter("iDisplayStart");
        String pageSize = request.getParameter("iDisplayLength");
        String colIndex = request.getParameter("iSortCol_0");
        String sortDirection = request.getParameter("sSortDir_0");

        if (pageNo != null) {
            start = Integer.parseInt(pageNo);
            if (start < 0) {
                start = 0;
            }
        }
        if (pageSize != null) {
            listDisplayAmount = Integer.parseInt(pageSize);
            if (listDisplayAmount < 10 || listDisplayAmount > 100000) {
                listDisplayAmount = 10;
            }
        }
        if (colIndex != null) {
            column = Integer.parseInt(colIndex);
            if (column < 0 || column > 5) {
                column = 0;
            }
        }
        if (sortDirection != null) {
            if (!sortDirection.equals("asc")) {
                dir = "desc";
            }
        }

        String colName = columnNames[column];
        int totalRecords = -1;
        try {
            totalRecords = getTotalRecordCount();
        } catch (SQLException e1) {
            e1.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MerchantsTransactionsDatatables.class.getName()).log(Level.SEVERE, null, ex);
        }

        RECORD_SIZE = listDisplayAmount;
        GLOBAL_SEARCH_TERM = request.getParameter("sSearch");
        COLUMN_NAME = colName;
        DIRECTION = dir;
        INITIAL = start;

        try {
            jsonResult = getPersonDetails(totalRecords, request);
            System.out.print("jsonResult " + jsonResult);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setHeader("Cache-Control", "no-store");
        PrintWriter out = response.getWriter();
        out.print(jsonResult);
    }

    public int getTotalRecordCount() throws SQLException, ClassNotFoundException {

        int totalRecords = -1;
        String sql = "SELECT " + "COUNT(*) as count " + "FROM " + " VW_ONBOARDTYPE" + "";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        con = DBConnection.getConnection();
        PreparedStatement statement = con.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            totalRecords = resultSet.getInt("count");
        }
        resultSet.close();
        statement.close();
        if (!con.isClosed()) {
            try {
                con.close();
                if (con.isClosed()) {
                    System.out.print("Dept Closed");
                } else {
                    System.out.print("Dept Not closed");
                }
            } catch (SQLException e) {
            }
        }
        return totalRecords;
    }

    public JSONObject getPersonDetails(int totalRecords, HttpServletRequest request)
            throws SQLException, ClassNotFoundException {

        int totalAfterSearch = totalRecords;
        JSONObject result = new JSONObject();
        JSONArray array = new JSONArray();
        String searchSQL = "";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        con = DBConnection.getConnection();
        String sql = "select * from VW_ONBOARDTYPE";

        String globeSearch = " where (OB_DESCRIPTION like '%" + GLOBAL_SEARCH_TERM + "%')";

        System.out.println("Globe Search: " + globeSearch);
        if (GLOBAL_SEARCH_TERM != "") {
            searchSQL = globeSearch;
        }
        sql += searchSQL;
        //     System.out.println("Sql: " + sql);
        sql += " order by " + COLUMN_NAME + " " + DIRECTION;
        //sql += " limit " + INITIAL + ", " + RECORD_SIZE;
        sql += " OFFSET " + INITIAL + " ROWS FETCH NEXT " + RECORD_SIZE + " ROWS ONLY";
        System.out.println(sql);
        //for searching
        PreparedStatement stmt = con.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            JSONArray ja = new JSONArray();
            ja.put(rs.getString("ID"));
            ja.put(rs.getString("OB_DESCRIPTION"));
            ja.put(rs.getString("ACTIVESTATUS"));
            array.put(ja);
        }
        stmt.close();
        rs.close();

        String query = "SELECT " + "COUNT(*) as count " + "FROM " + " VW_ONBOARDTYPE";

        //for pagination
        if (GLOBAL_SEARCH_TERM != "") {
            query += searchSQL;
            PreparedStatement st = con.prepareStatement(query);
            ResultSet results = st.executeQuery();
            if (results.next()) {
                totalAfterSearch = results.getInt("count");
            }
            st.close();
            results.close();
        }
        try {
            result.put("iTotalRecords", totalRecords);
            result.put("iTotalDisplayRecords", totalAfterSearch);
            result.put("aaData", array);
        } catch (Exception e) {

        }
        if (!con.isClosed()) {
            try {
                con.close();
                if (con.isClosed()) {
                    System.out.print("Dept Closed");
                } else {
                    System.out.print("Dept Not closed");
                }
            } catch (SQLException e) {
                /* ignored */
            }
        }
        return result;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
