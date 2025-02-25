/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

/**
 *
 * @author thestickypaws
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

//    public static String setURL = "jdbc:sqlserver://localhost;databaseName=MOS";
//    public static String setUSERNAME = "sa";
//    public static String setPASSWORD = "@rvin1120";
//    
//    public static String setURL = "jdbc:sqlserver://10.232.236.51;databaseName=MOSQAT";
    public static String setURL = "jdbc:sqlserver://10.232.236.51;databaseName=MOSQAT;encrypt=true;trustServerCertificate=true;sslProtocol=TLSv1.2";
    public static String setUSERNAME = "sa";
    public static String setPASSWORD = "@rvin1120";
    
//    public static String setURL = "jdbc:sqlserver://localhost;databaseName=MOSQAT";
//    public static String setUSERNAME = "sa";
//    public static String setPASSWORD = "sql";
    
//    public static String setURL = "jdbc:sqlserver://localhost;databaseName=MOSDEV";
//    public static String setUSERNAME = "sa";
//    public static String setPASSWORD = "sql";

//    public static String setURL2 = "jdbc:sqlserver://10.232.236.6;databaseName=sms_gateway";
    public static String setURL2 = "jdbc:sqlserver://10.232.236.6;databaseName=sms_gateway;encrypt=true;trustServerCertificate=true;sslProtocol=TLSv1.2";
    public static String setUSERNAME2 = "dev";
    public static String setPASSWORD2 = "2@DevOk0";

//    public static String setURL3 = "jdbc:sqlserver://10.232.236.14;databaseName=SMSGateway";
    public static String setURL3 = "jdbc:sqlserver://10.232.236.14;databaseName=SMSGateway;encrypt=true;trustServerCertificate=true;sslProtocol=TLSv1.2";
    public static String setUSERNAME3 = "sa";
    public static String setPASSWORD3 = "@Allbank2020";
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(setURL, setUSERNAME, setPASSWORD);
    }
    
    public static Connection getConnection2() throws SQLException {
        return DriverManager.getConnection(setURL2, setUSERNAME2, setPASSWORD2);
    }
    
    public static Connection getConnection3() throws SQLException {
        return DriverManager.getConnection(setURL3, setUSERNAME3, setPASSWORD3);
    }
    
}
