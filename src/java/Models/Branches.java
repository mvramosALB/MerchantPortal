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
public class Branches {
      public String AddBranches(String BranchName, String Address, String NoTerminals, String MerchID,String CreatedBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "insert into o_branch (BranchName,REGISTERED_ADDRESS,MERCHID,no_terminals,CreatedBy,CreationDate) values(?,?,?,?,?,getdate())";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, BranchName);
            UpdateLOGS.setString(2, Address);
            UpdateLOGS.setString(3, MerchID);
            UpdateLOGS.setString(4, NoTerminals);
            UpdateLOGS.setString(5, CreatedBy);
            UpdateLOGS.executeUpdate();
            ResultSet rs = UpdateLOGS.getGeneratedKeys();
            if (rs.next()) {
                returno = rs.getString(1);
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
        return returno;

    }
      
       public String UpdateBranches(String BranchID,String BranchName, String Address, String NoTerminals, String ActiveStatus,String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "Exec UpdateBranchInfo ?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, BranchID);
            UpdateLOGS.setString(2, BranchName);
            UpdateLOGS.setString(3, Address);
            UpdateLOGS.setString(4, NoTerminals);
            UpdateLOGS.setString(5, ActiveStatus);
            UpdateLOGS.setString(6, LastUpdateBy);
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

}
