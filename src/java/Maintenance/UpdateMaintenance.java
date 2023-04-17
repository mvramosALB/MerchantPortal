/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Maintenance;

import Models.AuditLogs;
import Models.Maintenance;
import Models.Users;
import Security.Client;
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
public class UpdateMaintenance extends HttpServlet {

    Users U = new Users();
    Client CF = new Client();
    AuditLogs logs = new AuditLogs();
    Maintenance M = new Maintenance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ClientIP = CF.getClientIp(request);
        HttpSession session = request.getSession();
        String UserID = session.getAttribute("USERID").toString();
        int action = Integer.parseInt(request.getParameter("action"));
        String maintenanceType = request.getParameter("maintenanceType");
        String mess = "", color = "", title = "";

        String id = "";

        if (action == 1) {
            String description = request.getParameter("description");

            String CreatedBy = UserID;
            if (!M.AddMaintenance(maintenanceType, description, CreatedBy).equals("0")) {
//                switch (maintenanceType) {
//                    case "CLASS":
//                       
//                        break;
//                    case "TYPE":
//                        // code block
//                        break;
//                    default:
//                    // code block
//                }

                title = "Success";
                color = "success";
                mess = "Add Success!";
                logs.AddLog("MASTERUPDATE", "SUCADDMAINT", UserID, ClientIP, "maintenanceType : " + maintenanceType + " ID : " + id + " Description : " + description);
            } else {
                title = "Alert";
                color = "danger";
                mess = "Add Failed!";
                logs.AddLog("MASTERUPDATE", "FAIADDMAINT", UserID, ClientIP, "maintenanceType : " + maintenanceType + " Description : " + description);
            }

        } else if (action == 3) {//enable
            String ToEditID = request.getParameter("id");
            if (!M.EnableMaintenance(maintenanceType, ToEditID, UserID).equals("0")) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("MASTERUPDATE", "SUCUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID +" Action : Enable");
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("MASTERUPDATE", "FAIUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID+" Action : Enable");
            }
        } else if (action == 4) {//disable
            String ToEditID = request.getParameter("id");
            if (!M.DisableMaintenance(maintenanceType, ToEditID, UserID).equals("0")) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("MASTERUPDATE", "SUCUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID+" Action : Disable");
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("MASTERUPDATE", "FAIUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID+" Action : Enable");
            }
        } else {
            String ToEditID = request.getParameter("mfid");
            String description = request.getParameter("description");
            id = ToEditID;
            String LastUpdateBy = UserID;

            if (!M.UpdateMaintenance(maintenanceType, ToEditID, description, LastUpdateBy).equals("0")) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("MASTERUPDATE", "SUCUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID);
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("MASTERUPDATE", "FAIUPDATEMAINT", UserID, ClientIP, "ID : " + ToEditID);
            }

        }

        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + maintenanceType);
        System.out.println(title + ";;" + color + ";;" + mess + ";;" + maintenanceType);
    }
}
