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
public class Units {
    
       public String AddAccountUnits(String UnitName, String OnBoardType, String TerminalID,String AccountID,String MerchID,String CreatedBy,String MobileNumber) {
        
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateUnitsQuery = "";
            UpdateUnitsQuery = "insert into o_units (UnitName,TYPE,Terminal_ID,ACCOUNT_ID,merchid,createdBy,creationdate,mobilenumber) values(?,?,?,?,?,?,getdate(),?)";
            PreparedStatement UpdateUnits = con.prepareStatement(UpdateUnitsQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateUnits.setString(1, UnitName);
            UpdateUnits.setString(2, OnBoardType);
            UpdateUnits.setString(3, TerminalID);
            UpdateUnits.setString(4, AccountID);
            UpdateUnits.setString(5, MerchID);
            UpdateUnits.setString(6, CreatedBy);
            UpdateUnits.setString(7, MobileNumber);
            System.out.println("insert into o_units (UnitName,TYPE,Terminal_ID,ACCOUNT_ID,merchid,createdBy,creationdate) values(?,?,?,?,?,?,getdate())");
            UpdateUnits.executeUpdate();
            ResultSet rs = UpdateUnits.getGeneratedKeys();
            if (rs.next()) {
                returno = rs.getString(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;

    }
   public String UpdateAccountUnits(String UnitID,String UnitName, String TYPE, String Terminal_ID,String LastUpdateBy,String ActiveStatus,String MobileNumber) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateUnitsQuery = "";
            UpdateUnitsQuery = "EXEC UpdateUnitInfo ?,?,?,?,?,?,?";
            PreparedStatement UpdateUnits = con.prepareStatement(UpdateUnitsQuery);
            UpdateUnits.setString(1, UnitID);
            UpdateUnits.setString(2, UnitName);
            UpdateUnits.setString(3, TYPE);
            UpdateUnits.setString(4, Terminal_ID);
            UpdateUnits.setString(5, ActiveStatus);
            UpdateUnits.setString(6, LastUpdateBy);
            UpdateUnits.setString(7, MobileNumber);
            UpdateUnits.executeUpdate();
          

        } catch (SQLException ex) {
            Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Units.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;

    }
}
