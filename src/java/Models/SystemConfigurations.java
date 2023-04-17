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
public class SystemConfigurations {

    public static String GetSysConfig(String InfoNeeded) {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String GetSysConfigQuery = "";
            GetSysConfigQuery = "Select " + InfoNeeded + " from sys_config";
            PreparedStatement GetSysConfig = con.prepareStatement(GetSysConfigQuery);
            System.out.println("GetSysConfig" + GetSysConfigQuery);
            ResultSet sysconfig = GetSysConfig.executeQuery();
            if (sysconfig.next()) {
                return sysconfig.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SystemConfigurations.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SystemConfigurations.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(SystemConfigurations.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return "";
    }
}
