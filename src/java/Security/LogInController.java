/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Security;

import Models.AuditLogs;
import Models.SystemConfigurations;
import Models.Users;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IT-Programmer
 */
public class LogInController extends HttpServlet {

    Users user = new Users();
    SystemConfigurations SC = new SystemConfigurations();
    AuditLogs logs = new AuditLogs();
    Client CF = new Client();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String Username = request.getParameter("username");
        String userPass = request.getParameter("password");
        String UserType = request.getParameter("Type");
        String mess = "", color = "", title = "";
        String first_login = "NO";
        HttpSession session = request.getSession();
        String ClientIP = CF.getClientIp(request);

        if (user.CheckUserExist(Username)) {
            if (user.CheckUserLogin(Username, userPass)) {// check if user is Active/Inactive and valid credentials
                String MATCH = user.CheckUserLoginMatchUserType(Username, UserType);
                if (MATCH.equals("YES")) {
                  //  String UserID=user.GetUsersInfo(Username, "USERID");
                    session.setAttribute("UserType", UserType);
                    session.setAttribute("USERNAME", Username);
                    session.setAttribute("USERID", user.GetUsersInfo(Username, "USERID"));
                    session.setAttribute("USERGROUP",user.GetUsersInfo(Username, "USER_GROUP"));
                    title = "Success";
                    color = "success";
                    mess = "Login Success!";
                    String lastlogin = user.GetUsersInfo(Username, "last_login");

                    if (lastlogin == null) {
                        first_login = "YES";
                    }

                    user.UpdateAttemps(Username, 0);
                    user.UpdateUserLastLogin(Username);
                    logs.AddLog("AUTH", "SUCLOGIN", user.GetUsersInfo(Username, "USERID"), ClientIP, "");
                } else {
                    title = "Alert";
                    color = "danger";
                    mess = MATCH;
                    logs.AddLog("AUTH", "FAILOGIN", Username, ClientIP, "");
                }
            } else {
                logs.AddLog("AUTH", "FAILOGIN", Username, ClientIP, "");
                title = "Alert";
                color = "danger";
                mess = "Login Failed!";
                if (user.GetUsersInfo(Username, "ACTIVESTATUS").equals("0")) {
                    title = "Alert";
                    color = "danger";
                    mess = "Login Failed! User is disabled by Admin.";
                    

                } else {
                    user.UpdateAttemps(Username, 1);
                }
                String getMaxAttemp = SC.GetSysConfig("login_attemps_max");
                String UserAttemp = user.GetUsersInfo(Username, "attemps");
                System.out.println("Max : " + getMaxAttemp + " Attemps: " + UserAttemp);

                if (user.GetUsersInfo(Username, "attemps").equals(getMaxAttemp)) {
                    title = "Alert";
                    color = "danger";
                    mess = "Login Failed! User is disabled.";
                    logs.AddLog("SYS", "SYSDISABLEUSER", "SYSTEM", ClientIP, "");
                }

                
            }
        } else {
            title = "Alert";
            color = "danger";
            mess = "Login Failed! User is doesn't exist.";
            logs.AddLog("AUTH", "FAILOGIN", Username, ClientIP, "");
        }
        System.out.println("LogInController : "+title + ";;" + color + ";;" + mess + ";;" + Username + ";;" + first_login);
        //response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + Username + ";;" + first_login);
        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;");
    }

}
