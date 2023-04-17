package Models;

import Security.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Merchants {

    public String AddMerchant(String ServiceType, String MerchantName, String AggreName, String MID, String MerchType, String MerchClass, String RateType, String RateValue, String QR_EXP, String HO_Address, String DepositoryBranch, String AccountNumber, String TypeOfBusiness, String CreatedBy) {
        String returno = "";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "insert into o_merchants (MerchName,AggreName,Mid,MerchType,MerchClass,ratetype,RateValue,QR_EXP,HOAddress,DepositoryBranch,AccountNumber,TypeofBusiness,ProcessStatus,ActiveStatus,CreatedBy,CreatedDate,ServiceType) values(?,?,?,?,?,?,?,?,?,?,?,?,0,1,?,GetDate(),?)";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            UpdateLOGS.setString(1, MerchantName);
            UpdateLOGS.setString(2, AggreName);
            UpdateLOGS.setString(3, MID);
            UpdateLOGS.setString(4, MerchType);
            UpdateLOGS.setString(5, MerchClass);
            UpdateLOGS.setString(6, RateType);
            UpdateLOGS.setString(7, RateValue);
            UpdateLOGS.setString(8, QR_EXP);
            UpdateLOGS.setString(9, HO_Address);
            UpdateLOGS.setString(10, DepositoryBranch);
            UpdateLOGS.setString(11, AccountNumber);
            UpdateLOGS.setString(12, TypeOfBusiness);
            UpdateLOGS.setString(13, CreatedBy);
            UpdateLOGS.setString(14, ServiceType);

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

    public boolean AddAuthorizedSignature(String PMID, String asName1, String asDesignation1, String asContactNumber1, String asEmail1, String asName2, String asDesignation2, String asContactNumber2, String asEmail2, String CreatedBy) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC AddNewAS ?,?,?,?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, asName1);
            UpdateLOGS.setString(3, asDesignation1);
            UpdateLOGS.setString(4, asContactNumber1);
            UpdateLOGS.setString(5, asEmail1);
            UpdateLOGS.setString(6, asName2);
            UpdateLOGS.setString(7, asDesignation2);
            UpdateLOGS.setString(8, asContactNumber2);
            UpdateLOGS.setString(9, asEmail2);
            UpdateLOGS.setString(10, CreatedBy);

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

    public boolean ApproveMerchant(String PMID, String Approver) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC ApproveMerchant ?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, Approver);
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

    public boolean DisapproveMerchant(String PMID, String Approver, String Remarks) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC DisapproveMerchant ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, Approver);
            UpdateLOGS.setString(3, Remarks);
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

    public boolean RejectMerchant(String PMID, String Approver, String Remarks) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC RejectMerchant ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, Approver);
            UpdateLOGS.setString(3, Remarks);
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

    public boolean ResubmitMerchant(String PMID, String Approver) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC ResubmitMerchant ?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            System.out.println("EXEC ResubmitMerchant " + PMID + " : " + Approver);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, Approver);
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

    public boolean MakersRemarks(String PMID, String Approver, String Remarks) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC MakersRemarks ?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            System.out.println("EXEC MakersRemarks " + PMID + " : " + Approver);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, Approver);
            UpdateLOGS.setString(3, Remarks);
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

    public boolean UpdateMerchantInfo(String PMID, String MerchType, String MerchClass, String RateType, String RateValue, String QR_EXP, String MerchName, String TypeOfBusiness, String HoAddress, String DepositoryBranch, String AccountNumber, String LastUpdateBy) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateMerchantInfo ?,?,?,?,?,?,?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, PMID);
            UpdateLOGS.setString(2, MerchType);
            UpdateLOGS.setString(3, MerchClass);
            UpdateLOGS.setString(4, RateType);
            UpdateLOGS.setString(5, RateValue);
            UpdateLOGS.setString(6, QR_EXP);
            UpdateLOGS.setString(7, MerchName);
            UpdateLOGS.setString(8, TypeOfBusiness);
            UpdateLOGS.setString(9, HoAddress);
            UpdateLOGS.setString(10, DepositoryBranch);
            UpdateLOGS.setString(11, AccountNumber);
            UpdateLOGS.setString(12, LastUpdateBy);
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

    public boolean UpdateAuthorizedSignature(String ASID, String asName1, String asDesignation1, String asContactNumber1, String asEmail1, String LastUpdateBy) {
        boolean returno = false;
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String UpdateLOGSQuery = "";
            UpdateLOGSQuery = "EXEC UpdateASInfo ?,?,?,?,?,?";
            PreparedStatement UpdateLOGS = con.prepareStatement(UpdateLOGSQuery);
            UpdateLOGS.setString(1, ASID);
            UpdateLOGS.setString(2, asName1);
            UpdateLOGS.setString(3, asDesignation1);
            UpdateLOGS.setString(4, asContactNumber1);
            UpdateLOGS.setString(5, asEmail1);
            UpdateLOGS.setString(6, LastUpdateBy);

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

    public String GetMerchantInfo(String ID, String InfoNeeded) {
        Connection con = null;
        String returno = "";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DBConnection.getConnection();
            String GetUserInfoQuery = "";
            GetUserInfoQuery = "Select " + InfoNeeded + " from o_merchants where MERCHID=?";
            PreparedStatement GetUserInfo = con.prepareStatement(GetUserInfoQuery);
            GetUserInfo.setString(1, ID);
            System.out.println("GetUserInfo : Select " + InfoNeeded + " from o_merchants where MERCHID=" + ID);
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

}
