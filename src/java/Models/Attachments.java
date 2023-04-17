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
public class Attachments {

    public int AddAttachment(String MerchID, String FileName, String FilePath, String UploadedBy,String AttachmentType) {
        int TRID = 0;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateCategoryQuery = "";
            UpdateCategoryQuery = "insert into o_attachments (merchid,filename,filepath,uploadedDate,uploadedby,AttachmentType) values(?,?,?,GetDate(),?,?)";
            PreparedStatement UpdateCategory = con.prepareStatement(UpdateCategoryQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateCategory.setString(1, MerchID);
            UpdateCategory.setString(2, FileName);
            UpdateCategory.setString(3, FilePath);
            UpdateCategory.setString(4, UploadedBy);
            UpdateCategory.setString(5, AttachmentType);
            UpdateCategory.executeUpdate();
            ResultSet rs = UpdateCategory.getGeneratedKeys();
            if (rs.next()) {
                TRID = rs.getInt(1);
            }
            return TRID;
        } catch (SQLException ex) {
            Logger.getLogger(Attachments.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Attachments.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Attachments.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return TRID;

    }
    
    
    public String RemoveAttachments(String ID, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateAccountsQuery = "";
            UpdateAccountsQuery = "Exec RemoveAttachment ?,?";
            PreparedStatement UpdateAccounts = con.prepareStatement(UpdateAccountsQuery);
            UpdateAccounts.setString(1, ID);
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
