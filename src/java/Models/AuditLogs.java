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
public class AuditLogs {

    public boolean AddLog(String LogType, String LOGACTION, String UserID, String ClientIP, String RelatedItem) {
        Connection con = null;
        boolean returno = false;
        try {
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "AddLOG ?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, UserID);
            UpdateLOGS.setString(2, LOGACTION);
            UpdateLOGS.setString(3, LogType);
            UpdateLOGS.setString(4, RelatedItem);
            UpdateLOGS.setString(5, ClientIP);
            UpdateLOGS.executeUpdate();
            returno = true;
        } catch (SQLException ex) {
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

    public static String AddEmailLog(String Recipient, String Subject, String Message, String File, String UserID) {
        Connection con = null;
        String returno = "";
        try {
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "Insert into sys_email_logs(recipient,Email_Subject,Email_Body,Email_File,CreatedBy,CreatedDatetime) values(?,?,?,?,?,GetDate())";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, Recipient);
            UpdateLOGS.setString(2, Subject);
            UpdateLOGS.setString(3, Message);
            UpdateLOGS.setString(4, File);
            UpdateLOGS.setString(5, UserID);
            UpdateLOGS.executeUpdate();
            ResultSet rs = UpdateLOGS.getGeneratedKeys();
            if (rs.next()) {
                returno = rs.getString(1);
            }

        } catch (SQLException ex) {
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

    public static boolean UpdateEmailLog(String EmailLogID, String Status, String Remarks) {
        Connection con = null;
        boolean returno = false;
        try {
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateEmailLOG ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, EmailLogID);
            UpdateLOGS.setString(2, Status);
            UpdateLOGS.setString(3, Remarks);
            UpdateLOGS.executeUpdate();
            returno = false;

        } catch (SQLException ex) {
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

    public String AddSMSLog(String Recipient, String Message, String UserID) {
        Connection con = null;
        String returno = "";
        try {
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "insert into Sys_sms_logs (Recipient,message,CreatedBy,CreatedDatetime) values(?,?,?,GETDATE())";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, Recipient);
            UpdateLOGS.setString(2, Message);
            UpdateLOGS.setString(3, UserID);
            UpdateLOGS.executeUpdate();
            ResultSet rs = UpdateLOGS.getGeneratedKeys();
            if (rs.next()) {
                returno = rs.getString(1);
            }
        } catch (SQLException ex) {
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

    public boolean UpdateSMSLog(String SMSLogID, String Status, String Remarks) {
        Connection con = null;
        boolean returno = false;
        try {
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateSMSLOG ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, SMSLogID);
            UpdateLOGS.setString(2, Status);
            UpdateLOGS.setString(3, Remarks);
            UpdateLOGS.executeUpdate();
            returno = true;
        } catch (SQLException ex) {
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
