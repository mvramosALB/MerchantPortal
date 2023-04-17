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
public class Accounts {

    public String AddAccounts(String AccountNumber, String BranchOfAccount, String NoUnits, String MerchID, String CreatedBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateAccountsQuery = "";
            UpdateAccountsQuery = "insert into o_accounts (Acctno,BranchOfAccount,MERCHID,no_units,CreatedBy,CreationDate) values(?,?,?,?,?,getdate())";
            PreparedStatement UpdateAccounts = con.prepareStatement(UpdateAccountsQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateAccounts.setString(1, AccountNumber);
            UpdateAccounts.setString(2, BranchOfAccount);
            UpdateAccounts.setString(3, MerchID);
            UpdateAccounts.setString(4, NoUnits);
            UpdateAccounts.setString(5, CreatedBy);
            UpdateAccounts.executeUpdate();
            ResultSet rs = UpdateAccounts.getGeneratedKeys();
            if (rs.next()) {
                returno = rs.getString(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;

    }

    public String UpdateAccount(String AccountNumberID, String AccountNumber, String BranchOfAccount, String NoUnits, String ActiveStatus, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateAccountsQuery = "";
            UpdateAccountsQuery = "Exec UpdateAccountInfo ?,?,?,?,?,?";
            PreparedStatement UpdateAccounts = con.prepareStatement(UpdateAccountsQuery);
            UpdateAccounts.setString(1, AccountNumberID);
            UpdateAccounts.setString(2, AccountNumber);
            UpdateAccounts.setString(3, BranchOfAccount);
            UpdateAccounts.setString(4, NoUnits);
            UpdateAccounts.setString(5, ActiveStatus);
            UpdateAccounts.setString(6, LastUpdateBy);
            UpdateAccounts.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;

    }

    public String RemoveAccounts(String AccountNumberID, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateAccountsQuery = "";
            UpdateAccountsQuery = "Exec RemoveAccount ?,?";
            PreparedStatement UpdateAccounts = con.prepareStatement(UpdateAccountsQuery);
            UpdateAccounts.setString(1, AccountNumberID);
            UpdateAccounts.setString(2, LastUpdateBy);
            UpdateAccounts.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Accounts.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }
}
