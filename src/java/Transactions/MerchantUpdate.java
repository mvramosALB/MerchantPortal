/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Transactions;

import Models.Accounts;
import Models.Attachments;
import Models.AuditLogs;
import Models.Branches;
import Models.ContactPerson;
import Models.Merchants;
import Models.Terminals;
import Models.Units;
import Security.Client;
import Sending.SendSMS;
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
public class MerchantUpdate extends HttpServlet {

    Merchants M = new Merchants();
    Branches B = new Branches();
    Terminals T = new Terminals();
    ContactPerson CP = new ContactPerson();
    AuditLogs logs = new AuditLogs();
    Client CF = new Client();
    SendSMS sms = new SendSMS();
    Accounts A = new Accounts();
    Attachments AT = new Attachments();
    Units U = new Units();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("UpdateMerchant");
        HttpSession session = request.getSession();
        String ClientIP = CF.getClientIp(request);
        String UserID = session.getAttribute("USERID").toString();
        String mess = "", color = "", title = "";
        int action = Integer.parseInt(request.getParameter("action"));
        String PMID = "";

        if (action == 3) {//Approve
            PMID = request.getParameter("MerchID");
            System.out.println("ApproveMerchant:" + PMID);
            if (M.ApproveMerchant(PMID, UserID)) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("TRANSACTIONUPDATE", "SUCAPPRVMERCH", UserID, ClientIP, PMID);
                String CPMobile = CP.GetContactPersonInfo(PMID, "CP_CONTACT_NUMBER");
                String CPName = CP.GetContactPersonInfo(PMID, "CP_NAME");
                sms.SendSMS(CPMobile, "Hi " + CPName + "! \n\nYour Application in Allbank is Approved", UserID,"RisingTide");
//create user for merchant admin

//send password to email
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("TRANSACTIONUPDATE", "FAIAPPRVMERCH", UserID, ClientIP, PMID);
            }
        } else if (action == 4) {//Disapprove
            PMID = request.getParameter("MerchID");
            String Remarks = request.getParameter("Remarks");
            if (M.DisapproveMerchant(PMID, UserID, Remarks)) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("TRANSACTIONUPDATE", "SUCDAPPRVMERCH", UserID, ClientIP, PMID);
                String CPMobile = CP.GetContactPersonInfo(PMID, "CP_CONTACT_NUMBER");
                String CPName = CP.GetContactPersonInfo(PMID, "CP_NAME");
                sms.SendSMS(CPMobile, "Hi " + CPName + "! \n\nYour Application in Allbank is Disapproved", UserID,"RisingTide");
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("TRANSACTIONUPDATE", "FAIDAPPRVMERCH", UserID, ClientIP, PMID);
            }
        } else if (action == 5) {//Reject
            PMID = request.getParameter("MerchID");
            String Remarks = request.getParameter("Remarks");
            if (M.RejectMerchant(PMID, UserID, Remarks)) {
                title = "Success";
                color = "success";
                mess = "Update Success!";
                logs.AddLog("TRANSACTIONUPDATE", "SUCDAPPRVMERCH", UserID, ClientIP, PMID);
                String CPMobile = CP.GetContactPersonInfo(PMID, "CP_CONTACT_NUMBER");
                String CPName = CP.GetContactPersonInfo(PMID, "CP_NAME");
                sms.SendSMS(CPMobile, "Hi " + CPName + "! \n\nYour Application in Allbank is Rejected", UserID,"RisingTide");
            } else {
                title = "Alert";
                color = "danger";
                mess = "Update Failed!";
                logs.AddLog("TRANSACTIONUPDATE", "FAIDAPPRVMERCH", UserID, ClientIP, PMID);
            }
        } else if (action == 1) {// Create New Merchant
            //insert to o_merchants table
            String ServiceType = request.getParameter("ServiceType");
            String MerchType = request.getParameter("MerchType");
            String MerchClass = request.getParameter("MerchClass");
            String RateType = request.getParameter("RateType");
            String RateValue = request.getParameter("RateValue");
            String QR_EXP = request.getParameter("QREXP");
            String CorporateName = request.getParameter("CorporateName");
            String TypeOfBusiness = request.getParameter("TypeOfBusiness");
            String HOAddress = request.getParameter("HOAddress");
            String DepositoryBranch = ""; //request.getParameter("DepositoryBranch");
            String AccountNumber = "";//request.getParameter("AccountNumber");
            PMID = M.AddMerchant(ServiceType, CorporateName, "", "", MerchType, MerchClass, RateType, RateValue, QR_EXP, HOAddress, DepositoryBranch, AccountNumber, TypeOfBusiness, UserID);

            //insert to o_authorized signatures
            String asName1 = request.getParameter("asName1");
            String asDesignation1 = request.getParameter("asDesignation1");
            String asContactNumber1 = request.getParameter("asContactnumber1");
            String asEmail1 = request.getParameter("asEmailAddress1");

            String asName2 = request.getParameter("asName2");
            String asDesignation2 = request.getParameter("asDesignation2");
            String asContactNumber2 = request.getParameter("asContactnumber2");
            String asEmail2 = request.getParameter("asEmailAddress2");
            M.AddAuthorizedSignature(PMID, asName1, asDesignation1, asContactNumber1, asEmail1, asName2, asDesignation2, asContactNumber2, asEmail2, UserID);

//            //insert new branch
//            String[] BranchesName = request.getParameterValues("BbranchNameNew");
//            String[] BranchesAddress = request.getParameterValues("BRegisteredAddressNew");
//            String[] NoTerminals = request.getParameterValues("BNoTerminalsNew");
//
//            int NoBranches = BranchesName.length;
//            for (int i = 0; i < NoBranches; i++) {
//                String BranchID = B.AddBranches(BranchesName[i], BranchesAddress[i], NoTerminals[i], PMID, UserID);
//                //insert new terminal
//                int terminalno = i + 1;
//                String[] TerminalID = request.getParameterValues("Branch" + terminalno + "TerminalIDNew");
//                String[] TerminalType = request.getParameterValues("Branch" + terminalno + "TerminalTypeNew");
//                String[] TerminalTelco = request.getParameterValues("Branch" + terminalno + "TerminalTelcoNew");
//
//                int NoTerminalIds = TerminalID.length;
//
//                for (int j = 0; j < NoTerminalIds; j++) {
//                    T.AddTerminals(TerminalID[j], TerminalType[j], TerminalTelco[j], BranchID, PMID, UserID);
//                }
//            }
            //insert new Account
            String[] AccountNum = request.getParameterValues("AAccountNumberNew");
            String[] BranchOfAccount = request.getParameterValues("ADepositoryBranchNew");
            String[] NoUnits = request.getParameterValues("ANoUnitsNew");

            int NoAccounts = AccountNum.length;
            for (int i = 0; i < NoAccounts; i++) {
                String AccountID = A.AddAccounts(AccountNum[i], BranchOfAccount[i], NoUnits[i], PMID, UserID);
                //insert new unit
                int terminalno = i + 1;
                String[] UnitNames = request.getParameterValues("Account" + terminalno + "UnitNameNew");
                String[] UnitType = request.getParameterValues("Account" + terminalno + "UnitTypeNew");
                String[] TerminalID = request.getParameterValues("Account" + terminalno + "TerminalIDNew");
                String[] TerminalMobile = request.getParameterValues("Account" + terminalno + "MobileNew");

                int NoTerminalIds = UnitNames.length;
                System.out.println(NoTerminalIds);
                System.out.println(UnitType.length);
                System.out.println(TerminalID.length);
                for (int j = 0; j < NoTerminalIds; j++) {
                    System.out.println("UnitNames[j] : " + UnitNames[j] + "UnitType[j] :" + UnitType[j] + "  TerminalID[j] : " + TerminalID[j] + " AccountID : " + AccountID + " PMID : " + PMID + " UserID :" + UserID+" Mobile Number : "+TerminalMobile[j]);
                    U.AddAccountUnits(UnitNames[j], UnitType[j], TerminalID[j], AccountID, PMID, UserID,TerminalMobile[j]);
                }
            }

            //insert new contact person
            String CPName = request.getParameter("CPName");
            String CPDesination = request.getParameter("CPDesignation");
            String CPDepartment = request.getParameter("CPDepartment");
            String CPContactNumber = request.getParameter("CPContactNumber");
            String CPFaxNumber = request.getParameter("CPFaxNumber");
            String CPEmailAddress = request.getParameter("CPEmailAddress");
            CP.AddContactPerson(CPName, CPDesination, CPDepartment, CPContactNumber, CPFaxNumber, CPEmailAddress, PMID, UserID);

            //insert new attachement
            title = "Success";
            color = "success";
            mess = "Add Success!";
            logs.AddLog("TRANSACTIONUPDATE", "SUCADDMERCH", UserID, ClientIP, PMID);

        } else if (action == 2) {// Update Merchant
            //insert to o_merchants table
            int ArgumentCount = request.getContentLength();
            System.out.println("ArgumentCount : " + ArgumentCount);
            String ProcessStatus = request.getParameter("ProcessStatus");
            String MerchID = request.getParameter("MerchID");
            String MerchType = request.getParameter("MerchType");
            String MerchClass = request.getParameter("MerchClass");
            String RateType = request.getParameter("RateType");
            String RateValue = request.getParameter("RateValue");
            String QR_EXP = request.getParameter("QREXP");
            String CorporateName = request.getParameter("CorporateName");
            String TypeOfBusiness = request.getParameter("TypeOfBusiness");
            String HOAddress = request.getParameter("HOAddress");
            String DepositoryBranch = request.getParameter("DepositoryBranch");
            String AccountNumber = request.getParameter("AccountNumber");
            M.UpdateMerchantInfo(MerchID, MerchType, MerchClass, RateType, RateValue, QR_EXP, CorporateName, TypeOfBusiness, HOAddress, DepositoryBranch, AccountNumber, UserID);

            //Update o_authorized signatures
            String[] ASIDs = request.getParameterValues("ASIDs");
            int NoAS = ASIDs.length;
            for (int i = 0; i < NoAS; i++) {
                String asName1 = request.getParameter("asName" + ASIDs[i]);
                String asDesignation1 = request.getParameter("asDesignation" + ASIDs[i]);
                String asContactNumber1 = request.getParameter("asContactnumber" + ASIDs[i]);
                String asEmail1 = request.getParameter("asEmailAddress" + ASIDs[i]);
                M.UpdateAuthorizedSignature(PMID, asName1, asDesignation1, asContactNumber1, asEmail1, UserID);

            }

            //Remove Accounts
            String ToRemoveAccounts = request.getParameter("toRemoveAccount");
            String[] ToRemoveAccount = ToRemoveAccounts.split(",");
            if (ToRemoveAccount.length > 0) {
                for (int a = 0; a < ToRemoveAccount.length; a++) {
                    A.RemoveAccounts(ToRemoveAccount[a], UserID);
                }
            }

            //Update Accounts
            String ExistingAccoungCount = request.getParameter("AccountCount");
            if (!ExistingAccoungCount.equals("0")) {
                String[] AccountIDs = request.getParameterValues("AccountIDs");
                int oldAccountIdsCount = AccountIDs.length;
                for (int j = 0; j < oldAccountIdsCount; j++) {
                    String OldAccountNumber = request.getParameter("AAccountNumber" + AccountIDs[j]);
                    String OldBranchOfAccount = request.getParameter("ADepositoryBranch" + AccountIDs[j]);
                    String OldAccountNoUnits = request.getParameter("ANoUnits" + AccountIDs[j]);
                    String OldAccountActiveStatus = request.getParameter("AccountActiveStatus" + AccountIDs[j]);
                    A.UpdateAccount(AccountIDs[j], OldAccountNumber, OldBranchOfAccount, OldAccountNoUnits, OldAccountActiveStatus, UserID);

                    //insert new unit
                    String terminalno = AccountIDs[j];
                    String[] UnitNames = request.getParameterValues("Account" + terminalno + "UnitNameNew");
                    String[] UnitType = request.getParameterValues("Account" + terminalno + "UnitTypeNew");
                    String[] TerminalID = request.getParameterValues("Account" + terminalno + "TerminalIDNew");
                    String[] TerminalMobile = request.getParameterValues("Account" + terminalno + "MobileNew");
                    String newUnits = request.getParameter("NewAccountUnitsCount" + terminalno);
                    if (!newUnits.equals("0")) {//check new units
                        int NoTerminalIds = UnitNames.length;
                        System.out.println(NoTerminalIds);
                        System.out.println(UnitType.length);
                        System.out.println(TerminalID.length);
                        for (int k = 0; k < NoTerminalIds; k++) {
                            //  System.out.println("UnitNames[j] : " + UnitNames[k] + "UnitType[j] :" + UnitType[j] + "  TerminalID[j] : " + TerminalID[j] + " AccountID : " + AccountID + " PMID : " + PMID + " UserID :" + UserID);
                            U.AddAccountUnits(UnitNames[k], UnitType[k], TerminalID[k], AccountIDs[j], MerchID, UserID,TerminalMobile[k]);
                        }

                    }

                    //B.UpdateBranches(BranchIDs[j], OldBranchName, OldBranchAddress, OldBranchNoTerminals, OldBranchActiveStatus, UserID);
                }
            }

            //Update Units
            if (!ExistingAccoungCount.equals("0")) {
                String[] UnitIDs = request.getParameterValues("UnitIDs");
                int oldUnitIDsCount = UnitIDs.length;
                for (int k = 0; k < oldUnitIDsCount; k++) {
                    String OldUnitName = request.getParameter("Account" + UnitIDs[k] + "UnitName");
                    String OldUnitType = request.getParameter("Account" + UnitIDs[k] + "UnitType");
                    String OldUnitTerminanl = request.getParameter("Account" + UnitIDs[k] + "TerminalID");
                    String OldUnitMobilel = request.getParameter("Account" + UnitIDs[k] + "Mobile");
                    String OldUnitStatus = request.getParameter("UnitActiveStatus$" + UnitIDs[k]);
                    System.out.println("Updating Unit "+UnitIDs[k]);
                    U.UpdateAccountUnits(UnitIDs[k], OldUnitName, OldUnitType, OldUnitTerminanl, UserID, OldUnitStatus,OldUnitMobilel);
                    //T.UpdateTerminals(TerminalsIDs[k], OldTerminalIDs, OldTerminalType, OldTerminalTelco, OldTerminalStatus, UserID);
                }
            }

            //insert new Account
            String[] AccountNewIds = request.getParameterValues("AccountsNewIds");
            String[] AccountNum = request.getParameterValues("AAccountNumberNew");
            String[] BranchOfAccount = request.getParameterValues("ADepositoryBranchNew");
            String[] NoUnits = request.getParameterValues("ANoUnitsNew");
            String NewAccountCount = request.getParameter("NewAccountCount");

            if (!NewAccountCount.equals("0")) {
                int NoAccounts = AccountNum.length;
                for (int i = 0; i < NoAccounts; i++) {
                    String AccountID = A.AddAccounts(AccountNum[i], BranchOfAccount[i], NoUnits[i], MerchID, UserID);
                    //insert new unit
                    String terminalno = AccountNewIds[i];
                    String[] UnitNames = request.getParameterValues("Account" + terminalno + "UnitNameNew");
                    String[] UnitType = request.getParameterValues("Account" + terminalno + "UnitTypeNew");
                    String[] TerminalID = request.getParameterValues("Account" + terminalno + "TerminalIDNew");
                    String[] TerminalMobile = request.getParameterValues("Account" + terminalno + "MobileNew");

                    int NoTerminalIds = UnitNames.length;
                    System.out.println(NoTerminalIds);
                    System.out.println(UnitType.length);
                    System.out.println(TerminalID.length);
                    for (int j = 0; j < NoTerminalIds; j++) {
                        System.out.println("UnitNames[j] : " + UnitNames[j] + "UnitType[j] :" + UnitType[j] + "  TerminalID[j] : " + TerminalID[j] + " AccountID : " + AccountID + " PMID : " + PMID + " UserID :" + UserID);
                        U.AddAccountUnits(UnitNames[j], UnitType[j], TerminalID[j], AccountID, MerchID, UserID,TerminalMobile[j]);
                    }
                }
            }

            //Update contact person
            String CPID = request.getParameter("CPID");
            String CPName = request.getParameter("CPName");
            String CPDesination = request.getParameter("CPDesignation");
            String CPDepartment = request.getParameter("CPDepartment");
            String CPContactNumber = request.getParameter("CPContactNumber");
            String CPFaxNumber = request.getParameter("CPFaxNumber");
            String CPEmailAddress = request.getParameter("CPEmailAddress");
            CP.UpdateContactPerson(CPID, CPName, CPDesination, CPDepartment, CPContactNumber, CPFaxNumber, CPEmailAddress, UserID);

//
//            //Update Branches
//            String[] BranchIDs = request.getParameterValues("BranchIDs");
//            int oldBranchIdsCount = BranchIDs.length;
//            for (int j = 0; j < oldBranchIdsCount; j++) {
//                String OldBranchName = request.getParameter("BbranchName" + BranchIDs[j]);
//                String OldBranchAddress = request.getParameter("BRegisteredAddress" + BranchIDs[j]);
//                String OldBranchNoTerminals = request.getParameter("BNoTerminals" + BranchIDs[j]);
//                String OldBranchActiveStatus = request.getParameter("BranchActiveStatus" + BranchIDs[j]);
//                B.UpdateBranches(BranchIDs[j], OldBranchName, OldBranchAddress, OldBranchNoTerminals, OldBranchActiveStatus, UserID);
//            }
//            //UpdateTerminals
//            String[] TerminalsIDs = request.getParameterValues("TerminalIDs");
//            int oldTerminalIDsCount = TerminalsIDs.length;
//            for (int k = 0; k < oldTerminalIDsCount; k++) {
//                String OldTerminalIDs = request.getParameter("terminalID" + TerminalsIDs[k] + "TerminalID");
//                String OldTerminalType = request.getParameter("terminal" + TerminalsIDs[k] + "Type");
//                String OldTerminalTelco = request.getParameter("terminal" + TerminalsIDs[k] + "Telco");
//                String OldTerminalStatus = request.getParameter("TerminalActiveStatus$" + TerminalsIDs[k]);
//
//                T.UpdateTerminals(TerminalsIDs[k], OldTerminalIDs, OldTerminalType, OldTerminalTelco, OldTerminalStatus, UserID);
//            }
//            //insert new branch
//            String[] BranchesName = request.getParameterValues("BbranchNameNew");
//            String[] BranchesAddress = request.getParameterValues("BRegisteredAddressNew");
//            String[] NoTerminals = request.getParameterValues("BNoTerminalsNew");
//            String NewBranchCount = request.getParameter("NewBranchCount");
//            if (!NewBranchCount.equals("0")) {
//                int NoBranches = BranchesName.length;
//                System.out.println("No Branches New :");
//                for (int i = 0; i < NoBranches; i++) {
//                    String BranchID = B.AddBranches(BranchesName[i], BranchesAddress[i], NoTerminals[i], PMID, UserID);
//                    //insert new terminal
//                    int terminalno = i + 1;
//                    String[] TerminalID = request.getParameterValues("Branch" + terminalno + "TerminalID");
//                    String[] TerminalType = request.getParameterValues("Branch" + terminalno + "TerminalType");
//                    String[] TerminalTelco = request.getParameterValues("Branch" + terminalno + "TerminalTelco");
//
//                    int NoTerminalIds = TerminalID.length;
//
//                    for (int j = 0; j < NoTerminalIds; j++) {
//                        T.AddTerminals(TerminalID[j], TerminalType[j], TerminalTelco[j], BranchID, PMID, UserID);
//                    }
//                }
//            }
//remove attachment
            String toRemoveAttachmentIDs = request.getParameter("toRemoveAttachmentIDs");
            String[] toRemoveAttachmentID = toRemoveAttachmentIDs.split(",");

            if (!toRemoveAttachmentIDs.equals("")) {
                for (int a = 0; a < toRemoveAttachmentID.length; a++) {
                    AT.RemoveAttachments(toRemoveAttachmentID[a], UserID);
                }
            }

            if (ProcessStatus.equals("4")) {
                String Remarks=request.getParameter("MRemarks");
                M.ResubmitMerchant(MerchID, UserID);
                M.MakersRemarks(MerchID, UserID,Remarks);
                System.out.println("ProcessStatus : " + ProcessStatus);

            }
            title = "Success";
            color = "success";
            mess = "Add Success!";
            logs.AddLog("TRANSACTIONUPDATE", "SUCADDMERCH", UserID, ClientIP, PMID);
        }
        response.getWriter().print(title + ";;" + color + ";;" + mess + ";;" + PMID);
    }
}
