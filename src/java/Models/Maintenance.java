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
public class Maintenance {

    public String AddMaintenance(String MFType, String MFDescription, String CreatedBy) {
        String returno = "0";
        Connection con = null;
        try {
            System.out.println("AddMF: "+MFType+" , "+MFDescription);
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC AddMF ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, MFType);
            UpdateLOGS.setString(2, MFDescription);
            UpdateLOGS.setString(3, CreatedBy);

            UpdateLOGS.executeUpdate();
            returno = MFDescription;
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

    public String UpdateMaintenance(String MFType, String MFID, String MFDescription, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateMF ?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, MFType);
            UpdateLOGS.setString(2, MFID);
            UpdateLOGS.setString(3, MFDescription);
            UpdateLOGS.setString(4, LastUpdateBy);

            UpdateLOGS.executeUpdate();
            returno = "success";
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
    public String DisableMaintenance(String MFType, String MFID, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC DisableMF ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, MFType);
            UpdateLOGS.setString(2, MFID);
            UpdateLOGS.setString(3, LastUpdateBy);

            UpdateLOGS.executeUpdate();
            returno = "success";
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
     public String EnableMaintenance(String MFType, String MFID, String LastUpdateBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC EnableMF ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, MFType);
            UpdateLOGS.setString(2, MFID);
            UpdateLOGS.setString(3, LastUpdateBy);

            UpdateLOGS.executeUpdate();
            returno = "success";
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
    
//
//    public String GetContactPersonInfo(String ID, String InfoNeeded) {
//        Connection con = null;
//        String returno = "";
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            con = DBConnection.getConnection();
//            String GetUserInfoQuery = "";
//            GetUserInfoQuery = "Select " + InfoNeeded + " from o_contact_person where PMID=?";
//            PreparedStatement GetUserInfo = con.prepareStatement(GetUserInfoQuery);
//            GetUserInfo.setString(1, ID);
//            System.out.println("GetUserInfo : Select " + InfoNeeded + " from o_contact_person where MERCHID=" + ID);
//            ResultSet userLog = GetUserInfo.executeQuery();
//            if (userLog.next()) {
//                returno = userLog.getString(1);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            try {
//                if (!con.isClosed()) {
//                    con.close();
//                } else {
//                    System.out.println("not closed Log In COntroller");
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//        return returno;
//    }
}
