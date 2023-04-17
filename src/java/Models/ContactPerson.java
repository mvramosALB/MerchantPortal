/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Security.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author IT-Programmer
 */
public class ContactPerson {

    public String AddContactPerson(String CPName, String CPDesignation, String CPDepartment, String CPContactNumber, String CPFaxNo, String CPEmail, String PMID,String CreatedBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC AddNewContactPerson ?,?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, CPName);
            UpdateLOGS.setString(2, CPDesignation);
            UpdateLOGS.setString(3, CPDepartment);
            UpdateLOGS.setString(4, CPContactNumber);
            UpdateLOGS.setString(5, CPFaxNo);
            UpdateLOGS.setString(6, CPEmail);
            UpdateLOGS.setString(7, PMID);
            UpdateLOGS.setString(8, CreatedBy);
            UpdateLOGS.executeUpdate();
         

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
        return returno;

    }
    
    public String UpdateContactPerson(String ID,String CPName, String CPDesignation, String CPDepartment, String CPContactNumber, String CPFaxNo, String CPEmail,String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateContactPerson ?,?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, ID);
            UpdateLOGS.setString(2, CPName);
            UpdateLOGS.setString(3, CPDesignation);
            UpdateLOGS.setString(4, CPDepartment);
            UpdateLOGS.setString(5, CPContactNumber);
            UpdateLOGS.setString(6, CPFaxNo);
            UpdateLOGS.setString(7, CPEmail);
            UpdateLOGS.setString(8, LastUpdateBy);
            UpdateLOGS.executeUpdate();
         

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
        return returno;

    }

     public String GetContactPersonInfo(String ID, String InfoNeeded) {
        Connection con = null;
        String returno = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String GetUserInfoQuery = "";
            GetUserInfoQuery = "Select " + InfoNeeded + " from o_contact_person where PMID=?";
            PreparedStatement GetUserInfo = con.prepareStatement(GetUserInfoQuery);
            GetUserInfo.setString(1, ID);
            System.out.println("GetUserInfo : Select " + InfoNeeded + " from o_contact_person where MERCHID=" + ID);
            ResultSet userLog = GetUserInfo.executeQuery();
            if (userLog.next()) {
                returno = userLog.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

}
