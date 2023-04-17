/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Sending;

import Models.AuditLogs;
import Security.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author IT-Programmer
 */
public class SendSMS {

    AuditLogs logs = new AuditLogs();

    public boolean SendSMS(String MobileNumber, String Message, String Source, String Gateway) {
        Connection con = null;
        boolean returno = false;
        String SMSLogID = logs.AddSMSLog(MobileNumber, Message, Source);
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection2();
            String InsertOTPSMSQuery = "";
            InsertOTPSMSQuery = "EXEC send_sms '" + MobileNumber + "','ALLBANK Merchant Portal - " + Message + " \n\n For Inquiries, call:  02 8255 2265 loc 102' ";
            PreparedStatement InsertOTPSMS = con.prepareStatement(InsertOTPSMSQuery);
            System.out.println(InsertOTPSMSQuery);
            InsertOTPSMS.executeUpdate();
//            if (Gateway.equals("RisingTide")) {
//                con = DBConnection.getConnection3();
//                String InsertOTPSMSQuery = "";
//                InsertOTPSMSQuery = "EXEC SendSMS ?,?,?,? ";
//                PreparedStatement InsertOTPSMS = con.prepareStatement(InsertOTPSMSQuery);
//                InsertOTPSMS.setString(1, MobileNumber);
//                InsertOTPSMS.setString(2, "ALLBANK Merchant Portal - " + Message + " \\n\\n For Inquiries, call:  02 8255 2265 loc 102");
//                InsertOTPSMS.setString(3, "Merchant Portal");
//                InsertOTPSMS.setString(4, "1");
//                InsertOTPSMS.executeUpdate();
//
//            } else if (Gateway.equals("Local")) {
//                con = DBConnection.getConnection2();
//                String InsertOTPSMSQuery = "";
//                InsertOTPSMSQuery = "EXEC send_sms '" + MobileNumber + "','ALLBANK Merchant Portal - " + Message + " \n\n For Inquiries, call:  02 8255 2265 loc 102' ";
//                PreparedStatement InsertOTPSMS = con.prepareStatement(InsertOTPSMSQuery);
//                System.out.println(InsertOTPSMSQuery);
//                InsertOTPSMS.executeUpdate();
//            }
            returno = true;
            logs.UpdateSMSLog(SMSLogID, "1", "");

        } catch (SQLException ex) {
            Logger.getLogger(SendSMS.class.getName()).log(Level.SEVERE, null, ex);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SendSMS.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(SendSMS.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;

    }
}
