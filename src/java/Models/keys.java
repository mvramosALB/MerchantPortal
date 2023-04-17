/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Security.DBConnection;
import static Security.Hashing.getMd5;
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
public class keys {

    public boolean AddKey(String Email, String key) {
        Connection con = null;
        key = getMd5(key);
        try {
            con = DBConnection.getConnection();
            DeleteKey(Email);
            String InsertKeyQuery = "";
            InsertKeyQuery = "insert into o_keys(email,OTP) values(?,?)";
            PreparedStatement InsertKey = con.prepareStatement(InsertKeyQuery);
            InsertKey.setString(1, Email);
            InsertKey.setString(2, key);

            InsertKey.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean DeleteKey(String Email) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            String InsertKeyQuery = "";
            InsertKeyQuery = "delete o_keys where email=?";
            PreparedStatement InsertKey = con.prepareStatement(InsertKeyQuery);
            InsertKey.setString(1, Email);
            InsertKey.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean CheckKeyExists(String Key) {
        Key = getMd5(Key);
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            String KeyCheck = "";
            KeyCheck = "Select 1 from o_Keys where OTP=?";
            PreparedStatement findKey = con.prepareStatement(KeyCheck);
            findKey.setString(1, Key);
            System.out.println(findKey);
            ResultSet KeyLog = findKey.executeQuery();
            if (KeyLog.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public String VerifyKey(String Key, String email) {
        Key = getMd5(Key);
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            String KeyCheck = "";
            KeyCheck = "Select activestatus from o_Keys where OTP=? and email=?";
            PreparedStatement findKey = con.prepareStatement(KeyCheck);
            findKey.setString(1, Key);
            findKey.setString(2, email);
            System.out.println(findKey);
            ResultSet KeyLog = findKey.executeQuery();
            if (KeyLog.next()) {
                return KeyLog.getString(1);
            } else {
                return "Wrong Key";
            }
        } catch (SQLException ex) {
            Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(keys.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return "null";
    }
}
