/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Security.DBConnection;
import static Security.Hashing.getShai256;
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
public class Users {

    SystemConfigurations SC = new SystemConfigurations();

    public boolean CheckUserExist(String UserID) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "Select 1 from rm_users where username=?";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                returno = true;
            } else {
                returno = false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public boolean CheckUserMobileExist(String UserID) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "Select 1 from rm_user_info where mobile_number=?";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                returno = true;
            } else {
                returno = false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public boolean CheckUserEmailExist(String UserID) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "Select 1 from rm_user_info where email=?";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                returno = true;
            } else {
                returno = false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public String CheckUserLoginMatchUserType(String UserID, String Type) {
        String returno = "NO";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "EXEC CheckUserLoginMatchUserType ?,?";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            findUser.setString(2, Type);
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                returno = userLog.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public boolean CheckUserLogin(String UserID, String Password) {
        boolean returno = false;
        Password = getShai256(Password);
        int LastAttempTimeout = Integer.parseInt(SC.GetSysConfig("last_attemp_session"));
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "Select 1 from rm_users where (username=?) and PASSWORD=? and (ACTIVESTATUS=1 or (ACTIVESTATUS=0 and DATEADD(minute," + LastAttempTimeout + ",last_attemp_session)<=GETDATE() and attemps=3)) ";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            findUser.setString(2, Password);
            System.out.println("Select 1 from rm_users where ( username='" + UserID + "') and PASSWORD='" + Password + "' and (ACTIVESTATUS=1 or (ACTIVESTATUS=0 and DATEADD(minute," + LastAttempTimeout + ",last_attemp_session)<=GETDATE() and attemps=3)) ");
            //findUser.setString(1, getMd5(Password));
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                returno = true;
            } else {
                returno = false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public boolean UpdateAttemps(String id, int action) {
        int maxAttemp = Integer.parseInt(SC.GetSysConfig("login_attemps_max"));
        String attemps = "0";
        if (action == 0) {//reset
            attemps = "0";
            UpdateUserStatus(id, 1
            );
        } else {//add
            attemps = "attemps+1";
            String existingAttemps = GetUsersInfo(id, "attemps");
            if (existingAttemps.equals("" + maxAttemp)) {
                attemps = "" + maxAttemp;
            }

        }
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateUserQuery = "";
            UpdateUserQuery = "update rm_users set attemps=" + attemps + " , last_attemp_session=getdate() where  username=?";
            PreparedStatement UpdateUser = con.prepareStatement(UpdateUserQuery);
            UpdateUser.setString(1, id);
            UpdateUser.executeUpdate();

            if (GetUsersInfo(id, "attemps").equals("" + maxAttemp)) {
                UpdateUserStatus(id, 0);
            }
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean UpdateUserStatus(String id, int Status) {
        String ResetAttemps = ",last_attemp_session=getdate()";
        if (Status == 1) {
            ResetAttemps = " , attemps=0";
        }
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateUserQuery = "";
            UpdateUserQuery = "update rm_users set ACTIVESTATUS=? " + ResetAttemps + "  where username=? OR concat('',userid)=?";
            System.out.println("update rm_users set ACTIVESTATUS=? " + ResetAttemps + "  where username=? OR userid=?");
            PreparedStatement UpdateUser = con.prepareStatement(UpdateUserQuery);
            UpdateUser.setInt(1, Status);
            UpdateUser.setString(2, id);
            UpdateUser.setString(3, id);
            UpdateUser.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean UpdateUserLastLogin(String id) {

        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateUserQuery = "";
            UpdateUserQuery = "update rm_users set last_login=GETDATE()  where username=?";
            PreparedStatement UpdateUser = con.prepareStatement(UpdateUserQuery);
            UpdateUser.setString(1, id);
            UpdateUser.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean UpdatePassword(String id, String Password) throws ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = null;
        Password = getShai256(Password);
        System.out.println("Current Password: " + Password);
        String CPassword = GetUsersInfo(id, "isnull(Password,'0')");
        String Oldpassword1 = GetUsersInfo(id, "isnull(Oldpassword1,'0')");

        try {
            con = DBConnection.getConnection();
            if (CheckUserPasswordValidity(id, Password)) {

                String UpdateUserQuery = "";
                UpdateUserQuery = "update rm_users set password=?, oldpassword1=?,oldpassword2=? where username=?";
                //      "update rm_users set oldPassword2=oldPassword1,oldPassword1=password, password=? where  username=?";
                PreparedStatement UpdateUser = con.prepareStatement(UpdateUserQuery);
                UpdateUser.setString(1, Password);
                UpdateUser.setString(2, CPassword);
                UpdateUser.setString(3, Oldpassword1);
                UpdateUser.setString(4, id);
                System.out.println("update irm_users set password='" + Password + "', oldpassword1='" + CPassword + "',oldpassword2='" + Oldpassword1 + "' where username=?");
                UpdateUser.executeUpdate();
                return true;
            } else {
                return false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean ResetPassword(String id, String Password) throws ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection con = null;
        Password = getShai256(Password);
        String Empid = "";
        //Empid = GetUsersInfo(id, "Empid");
        try {
            con = DBConnection.getConnection();
            if (CheckUserPasswordValidity(id, Password)) {
                String UpdateUserQuery = "";
                UpdateUserQuery = "update rm_users set oldPassword2=oldPassword1,oldPassword1=password, password=? where  username=?";
                PreparedStatement UpdateUser = con.prepareStatement(UpdateUserQuery);
                UpdateUser.setString(1, Password);
                UpdateUser.setString(2, id);

                System.out.println("update rm_users set oldPassword2=oldPassword1,oldPassword1=password, password='" + Password + "' where userid='" + id + "' or username='" + id + "'");
                UpdateUser.executeUpdate();
                return true;
            } else {
                return false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;

    }

    public boolean CheckUserPasswordValidity(String UserID, String Password) {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String userCheck = "";
            userCheck = "Select 1 from rm_users where ( username=?) and (PASSWORD!=? and (ISNULL(Oldpassword1, '')!=? ) and (ISNULL(Oldpassword2, '')!=? )) ";
            PreparedStatement findUser = con.prepareStatement(userCheck);
            findUser.setString(1, UserID);
            findUser.setString(2, Password);
            findUser.setString(3, Password);
            findUser.setString(4, Password);
            ResultSet userLog = findUser.executeQuery();
            if (userLog.next()) {
                System.out.println("HAHA");
                return true;

            } else {
                System.out.println("HEHE");
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public String GetUsersInfo(String EmailID, String InfoNeeded) {
        Connection con = null;
        String returno = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String GetUserInfoQuery = "";
            GetUserInfoQuery = "Select " + InfoNeeded + " from rm_users where username=?";
            PreparedStatement GetUserInfo = con.prepareStatement(GetUserInfoQuery);
            GetUserInfo.setString(1, EmailID);
            System.out.println("GetUserInfo : Select " + InfoNeeded + " from rm_users where username=" + EmailID);
            ResultSet userLog = GetUserInfo.executeQuery();
            if (userLog.next()) {
                returno = userLog.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public String GetUsersInfo2(String Userid, String InfoNeeded) {
        Connection con = null;
        String returno = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String GetUserInfoQuery = "";
            GetUserInfoQuery = "Select " + InfoNeeded + " from rm_user_info where Userid=?";
            PreparedStatement GetUserInfo = con.prepareStatement(GetUserInfoQuery);
            GetUserInfo.setString(1, Userid);
            System.out.println("GetUserInfo : Select " + InfoNeeded + " from rm_user_info where Userid=" + Userid);
            ResultSet userLog = GetUserInfo.executeQuery();
            if (userLog.next()) {
                returno = userLog.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (!con.isClosed()) {
                    con.close();
                } else {
                    System.out.println("not closed Log In COntroller");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return returno;
    }

    public String AddUser(String USER_FULLNAME, String USERNAME, String PASSWORD, String CREATED_BY, String CREATED_DATE, String USER_GROUP) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "insert into rm_users (USER_FULLNAME,USERNAME,PASSWORD,CREATED_BY,CREATED_DATE,LASTUPDATE_BY,LASTUPDATE_DATE,USER_GROUP) \n"
                    + "values(?,?,?,?,GETDATE(),?,GETDATE(),?) ";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, USER_FULLNAME);
            UpdateLOGS.setString(2, USERNAME);
            UpdateLOGS.setString(3, PASSWORD);
            UpdateLOGS.setString(4, CREATED_BY);
            UpdateLOGS.setString(5, CREATED_BY);
            UpdateLOGS.setString(6, USER_GROUP);
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

    public boolean AddUserInfo(String UserID, String MobileNumber, String Email, String UpdatedBy, String MerchID, String BranchID, String TerminalID) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "Exec AddNewUserInfo ?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, UserID);
            UpdateLOGS.setString(2, MobileNumber);
            UpdateLOGS.setString(3, Email);
            UpdateLOGS.setString(4, UpdatedBy);
            UpdateLOGS.setString(5, MerchID);
            UpdateLOGS.setString(6, BranchID);
            UpdateLOGS.setString(7, TerminalID);

            UpdateLOGS.executeUpdate();

            returno = true;
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

    public boolean UpdateUser(String UserID, String USER_FULLNAME, String USERNAME, String USER_GROUP, String Mobile, String Email, String MerchID, String BranchID, String TerminalID, String UpdatedBy) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateUserInfo ?,?,?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, UserID);
            UpdateLOGS.setString(2, USER_FULLNAME);
            UpdateLOGS.setString(3, USERNAME);
            UpdateLOGS.setString(4, USER_GROUP);
            UpdateLOGS.setString(5, Mobile);
            UpdateLOGS.setString(6, Email);
            UpdateLOGS.setString(7, MerchID);
            UpdateLOGS.setString(8, BranchID);
            UpdateLOGS.setString(9, TerminalID);
            UpdateLOGS.executeUpdate();
            returno = true;
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
