/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Transactions;

import Models.Attachments;
import Tools.DateTimeGenerator;
import Security.Client;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author IT-Programmer
 */
public class UploadAttachements extends HttpServlet {

    String mess = "", color = "", title = "";
    DateTimeGenerator DG = new DateTimeGenerator();
    Client CF = new Client();
    Attachments A=new Attachments();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
// ConfigData cf = new ConfigData();
// String port = cf.GetConfigData("PORT");
// String ip = cf.GetConfigData("SERVERIP");// 
        String port = "80";//cf.GetConfigData("PORT");
        String ip = "10.232.236.51";//cf.GetConfigData("SERVERIP");
        int KBID = 0;
        String FileName = "", UploadedBy = "", doctype = "",MERCHID="";
        String ClientIP = CF.getClientIp(request);
        HttpSession session = request.getSession();
        UploadedBy = session.getAttribute("USERID").toString();
        try {
            ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
            List<FileItem> items = sf.parseRequest(request);
            File uploadDir = new File(getServletContext().getRealPath("\\"));
            String filePath = uploadDir.toString().replace("\\", "/");
            String PaPPath = "";
            for (FileItem item : items) {
                System.out.println(item.getFieldName());
                if (item.getFieldName().equals("MERCHID")) {
                    MERCHID = item.getString();
                    System.out.println("MERCHID:" + MERCHID);
                } else if (item.getFieldName().equals("file")) {
                    FileName = item.getName();
                    String FileType = item.getContentType();
                    String[] FileTypeC = FileType.split("/");
                    if (FileTypeC[0].equals("image")) {
                        doctype = "1";
                    } else if (FileTypeC[0].equals("video")) {
                        doctype = "2";
                    } else {
                        doctype = "4";
                    }
                    String MyDateTime = DG.GetMyDateTime();
                    System.out.println("Filename : " + FileName + " FileType: " + doctype);
                    item.write(new File("C:/ALB/MOS/Attachments/" + "" + MyDateTime + item.getName()));
                    PaPPath = ("https://portal.allbank.ph/ALB/MOS/Attachments/" + "" + MyDateTime + item.getName());
                    System.out.println("Uploaded?: " + A.AddAttachment(MERCHID, FileName, PaPPath, UploadedBy,doctype));//KB.AddKnowledgeBaseFile(KBID, PaPPath, doctype, FileName));
                }
            }
            title = "Success";
            color = "success";
            mess = "Attachments Uploaded!";
        } catch (FileUploadException ex) {
            Logger.getLogger(UploadAttachements.class.getName()).log(Level.SEVERE, null, ex);
            title = "Error";
            color = "danger";
            mess = "Upload Failed";
        } catch (Exception ex) {
            Logger.getLogger(UploadAttachements.class.getName()).log(Level.SEVERE, null, ex);
            title = "Error";
            color = "danger";
            mess = "Something went wrong";
        }
        response.getWriter().print(title + ";;" + color + ";;" + mess);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
