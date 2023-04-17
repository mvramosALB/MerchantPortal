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
public class AuditLogsDatatables extends HttpServlet {
          private String GLOBAL_SEARCH_TERM;
    private String COLUMN_NAME;
    private String DIRECTION;
    private int INITIAL;
    private int RECORD_SIZE;
    private String cocode;
    DBConnection db = new DBConnection();
    Connection con;
    String FilterDateMin = "";
    String FilterDateMax = "";
String whereClause = "";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonResult = new JSONObject();
        String[] columnNames = {"LOGID", "LOG_TYPE_DESCRIPTION", "ACTION", "DESCRIPTION", "SOURCE_CONTROLLER", "LOG_DATE", "USERID", "CLIENTIP", "REMARKS"};
        int listDisplayAmount = 10;
        int start = 0;
        int column = 0;
        String dir = "asc";
        String pageNo = request.getParameter("iDisplayStart");
        String pageSize = request.getParameter("iDisplayLength");
        String colIndex = request.getParameter("iSortCol_0");
        String sortDirection = request.getParameter("sSortDir_0");
        FilterDateMax = request.getParameter("FilterDateMax");
        FilterDateMin = request.getParameter("FilterDateMin");

        if ((request.getParameter("FilterDateMax")).equals("undefined") || (request.getParameter("FilterDateMax")).equals("") ) {
            FilterDateMax = "";
        } else {
            FilterDateMax = " and logdateFormated<='" + FilterDateMax + "'";
        }
        if ((request.getParameter("FilterDateMin")).equals("undefined") || (request.getParameter("FilterDateMin")).equals("")) {
            FilterDateMin = "";
        } else {
            FilterDateMin = " and logdateFormated>='" + FilterDateMin + "'";
        }
        if (pageNo != null) {
            start = Integer.parseInt(pageNo);
            if (start < 0) {
                start = 0;
            }
        }
        whereClause =  FilterDateMin + FilterDateMax ;
        if (pageSize != null) {
            listDisplayAmount = Integer.parseInt(pageSize);
            if (listDisplayAmount < 10 || listDisplayAmount > 100000) {
                listDisplayAmount = 10000000;
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

    public int getTotalRecordCount() throws SQLException {

        int totalRecords = -1;
        String sql = "SELECT " + "COUNT(*) as count " + "FROM " + " vw_logbook where USERID!='' "+whereClause;
        System.out.println(sql);
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
                /* ignored */
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

        con = DBConnection.getConnection();
        String sql = "select * from vw_logbook" + " where USERID!='' "+whereClause;

        String globeSearch = " and (LOG_TYPE_DESCRIPTION like '%" + GLOBAL_SEARCH_TERM + "%'"
               + " or [DESCRIPTION]  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or SOURCE_CONTROLLER  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or USERID  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or CLIENTIP  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or REMARKS  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or EMPNAME  like '%" + GLOBAL_SEARCH_TERM + "%' "
                + " or ACTION like '%" + GLOBAL_SEARCH_TERM + "%')";

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
            ja.put(rs.getString("LOGID"));//0
            ja.put(rs.getString("LOG_TYPE_DESCRIPTION"));//1
            ja.put(rs.getString("DESCRIPTION"));//2
            ja.put(rs.getString("ACTION"));//3
            ja.put(rs.getString("SOURCE_CONTROLLER"));//4
            ja.put(rs.getString("LOG_DATE"));//5
            ja.put(rs.getString("USERNAME"));//6
            //ja.put(rs.getString("USERID"));//6
            ja.put(rs.getString("CLIENTIP"));//7
            ja.put(rs.getString("Remarks"));//8
            ja.put(rs.getString("empname"));//9
            array.put(ja);
        }
        stmt.close();
        rs.close();

        String query = "SELECT " + "COUNT(*) as count " + "FROM " + " VW_LOGBOOK where USERID!='' "+whereClause;

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

}
