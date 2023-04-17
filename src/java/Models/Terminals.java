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
public class Terminals {
       public String AddTerminals(String TerminalID, String Type_Termianl, String telco,String BranchID,String MerchID,String CreatedBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "insert into o_terminals (Terminal_ID,Pos_terminal_type,telco,branchid,merch_id,createdBy,creationdate) values(?,?,?,?,?,?,getdate())";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, TerminalID);
            UpdateLOGS.setString(2, Type_Termianl);
            UpdateLOGS.setString(3, telco);
            UpdateLOGS.setString(4, BranchID);
            UpdateLOGS.setString(5, MerchID);
            UpdateLOGS.setString(6, CreatedBy);
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
   public String UpdateTerminals(String ID,String TerminalID, String Type_Termianl, String telco,String LastUpdateBy,String ActiveStatus) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateTerminalInfo ?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, ID);
            UpdateLOGS.setString(2, TerminalID);
            UpdateLOGS.setString(3, Type_Termianl);
            UpdateLOGS.setString(4, telco);
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
