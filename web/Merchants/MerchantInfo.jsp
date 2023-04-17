<%-- 
    Document   : MerchantInfo
    Created on : 01 28, 21, 1:25:53 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="Form-MerchantEdit" >
            <c:choose>
                <c:when test="${param.Action ==2}"><!--Resubmit-->
                    <c:set var="readonly" value=""/>
                    <input type="hidden" name="action" value="2"/>
                    <input type="hidden" name="ProcessStatus" value="4"/>
                    <input type="hidden" id="MRemarks" name="MRemarks" value=""/>
                </c:when>
                <c:when test="${param.Action ==3}"><!--Edit-->
                    <c:set var="readonly" value=""/>
                    <c:set var="buttonHidden" value=""/>
                    <input type="hidden" name="action" value="2"/>
                    <input type="hidden" name="ProcessStatus" value="5"/>
                </c:when>
                <c:otherwise>
                    <c:set var="buttonHidden" value="style='display:none'"/>
                    <c:set var="readonly" value="readonly"/>
                </c:otherwise>
            </c:choose>                            
            <!--Onboarding Option-->
            <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantInfo">
                EXEC GetMerchantInfo '${param.MerchantID}'
            </sql:query>
            <c:forEach var = "rowMerchantInfo" items = "${resultMerchantInfo.rows}">
                <c:set var="ServiceType" value="${rowMerchantInfo.ServiceType}"/>
                <c:set var="MERCHTYPE" value="${rowMerchantInfo.MERCHTYPE}"/>
                <c:set var="MERCHCLASS" value="${rowMerchantInfo.MERCHCLASS}"/>
                <c:set var="RATETYPE" value="${rowMerchantInfo.RATETYPE}"/>
                <c:set var="RATEVALUE" value="${rowMerchantInfo.RATEVALUE}"/>
                <c:set var="QREXP" value="${rowMerchantInfo.qr_exp}"/>
                <c:set var="MERCHNAME" value="${rowMerchantInfo.MERCHNAME}"/>
                <c:set var="TypeOfBusiness" value="${rowMerchantInfo.TypeOfBusiness}"/>
                <c:set var="HOAddress" value="${rowMerchantInfo.HOAddress}"/>
                <c:set var="DepositoryBranch" value="${rowMerchantInfo.DepositoryBranch}"/>
                <c:set var="AccountNumber" value="${rowMerchantInfo.AccountNumber}"/>
            </c:forEach>
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardMerchantOptions" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Onboarding Options</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardMerchantOptions">
                        <div class="card-body">
                            <input type="hidden" name="ServiceType" value="${param.ServiceType}">
                            <input type="hidden" name="MerchID" value="${param.MerchantID}">
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Merchant Type</label>
                                    <%@ include file="/DD/MerchantTypeDD.jsp" %>
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Merchant Class</label>
                                    <%@ include file="/DD/MerchantClassDD.jsp" %>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Rate Type</label>
                                    <%@ include file="/DD/RateTypeDD.jsp" %>
                                </div>
                                <div class="col-sm-3 mb-3 mb-sm-0">
                                    <label>Rate Value</label>
                                    <input required type="number" class="form-control form-control-range" name="RateValue" value="${RATEVALUE}" ${readonly}  placeholder="ex. 100.00 or 1%">
                                </div>
                                <div class="col-sm-3 mb-3 mb-sm-0">
                                    <label>QR Expiration (in mins)</label>
                                    <input required type="number" class="form-control form-control-range" name="QREXP" value="${QREXP}" ${readonly}  >
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!--Business Details-->
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardBusinessDetails" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Partner Institution Details</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardBusinessDetails">
                        <div class="card-body">
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Corporate/ Business Name</label>
                                    <input required type="text" class="form-control form-control-range" value="${MERCHNAME}" ${readonly} name="CorporateName"
                                           placeholder="ex. AllHome">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Type of Business</label>
                                    <%@ include file="/DD/TypeOfBusinessDD.jsp" %>
                                </div>
                                <div class="col-sm-12 mb-6 mb-sm-0">
                                    <label>Head Office Address</label>
                                    <input required type="text" class="form-control form-control-range" value="${HOAddress}" ${readonly} name="HOAddress"
                                           placeholder="ex. Mandaluyong City">
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                $('#MerchantTypeDD').val("${MERCHTYPE}");
                $('#MerchantClassDD').val("${MERCHCLASS}");
                $('#RateTypeDD').val("${RATETYPE}");

                $('#TypeOfBusinessDD').val("${TypeOfBusiness}");
                if ('${readonly}' === 'readonly') {
                    $('#MerchantTypeDD').attr("readonly", true);
                    $('#MerchantClassDD').attr("readonly", true);
                    $('#RateTypeDD').attr("readonly", true);

                    $('#TypeOfBusinessDD').attr("readonly", true);
                }
            </script>
            <!--Accounts-->
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardAccounts" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Accounts</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardAccounts">
                        <div class="card-body">
                            <div id="Accounts-Div">
                                <input type="hidden" name="AccountCount" value="0" id="AccountCount">
                                <input type="hidden" name="" value="0" id="NewAccountCountss">
                                <input type="hidden" name="NewAccountCount" value="0" id="NewAccountCountsss">
                                <input type="hidden" name="toRemoveAccount" id="toRemoveAccount"/>
                                <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantAccountsInfo">
                                    EXEC GetMerchantAccounts '${param.MerchantID}'
                                </sql:query>
                                <c:forEach var = "rowMerchantAccountsInfo" items = "${resultMerchantAccountsInfo.rows}" varStatus="AccountsRow">
                                    <c:set var="AccountsID" value="${rowMerchantAccountsInfo.ID}"/>
                                    <c:set var="ACCTNO" value="${rowMerchantAccountsInfo.ACCTNO}"/>
                                    <c:set var="BranchOfAccount" value="${rowMerchantAccountsInfo.BranchOfAccount}"/>
                                    <c:set var="NO_UNITS" value="${rowMerchantAccountsInfo.NO_UNITS}"/>
                                    <hr>
                                    <script>
                                        $('#AccountCount').val("${AccountsRow.count}")
                                    </script>
                                    <input style="display:none"  name="NewAccountUnitsCount${AccountsID}" value="0" id="NewAccountUnitsCount${AccountsID}">
                                    <div class="form-group row ExistingAccountDiv_${AccountsID}"> 
                                        <input type="hidden" name="AccountIDs" value="${AccountsID}">
                                        <input type="hidden" name="AccountActiveStatus${AccountsID}" value="${AccountsID}">
                                        <div class="col-sm-4 mb-3 mb-sm-0">
                                            <label>Branch Of Account</label>
                                            <select class="form-control form-control-range" id="ADepositoryBranch${AccountsID}" ${readonly} name="ADepositoryBranch${AccountsID}"  value="${BranchOfAccount}">
                                                <option>--Select Branch--</option>     
                                                <sql:query dataSource = "${ALBMOSDB}" var = "resultBOA">
                                                    EXEC DDBranchOfAccount
                                                </sql:query>
                                                <c:forEach var = "rowBOA" items = "${resultBOA.rows}">
                                                    <c:set var="DDID" value="${rowBOA.DDID}"/>
                                                    <c:set var="DDDescription" value="${rowBOA.DDDescription}"/>
                                                    <option value='${DDID}'>${DDDescription}</option>
                                                </c:forEach>      
                                            </select>

                                        </div>
                                        <div class="col-sm-4 mb-3 mb-sm-0">
                                            <label>Account Number</label>
                                            <input required type="text" class="form-control form-control-range" name="AAccountNumber${AccountsID}" id="AAccountNumber${AccountsID}" value="${ACCTNO}" ${readonly} placeholder="ex. Main Branch">
                                        </div>

                                        <div class="col-sm-2 mb-2 mb-sm-0">
                                            <label>No. of Units</label>
                                            <input required type="number" class="form-control form-control-range" name="ANoUnits${AccountsID}" value="${NO_UNITS}" ${readonly} id="ANoUnits${AccountsID}" placeholder="ex. 1" onchange="AddUnit('${AccountsID}')"  value="0">
                                            <input type="hidden" id="ANoUnits${AccountsID}Current" value="${NO_UNITS}"/>
                                            <input type="hidden" id="ANoUnits${AccountsID}New" value="${NO_UNITS}"/>
                                        </div>
                                        <div class="col-sm-2 mb-2 mb-sm-0" ${buttonHidden}>
                                            <label>Action</label>
                                            <button class="btn btn-block btn-danger" type="button" onclick="removeExistingAccount('${AccountsID}')">Remove</button>    
                                        </div>
                                        <div class="col-sm-12 mb-12 mb-sm-0">
                                            <br>
                                            <label>Units</label>
                                            <table width="100%">
                                                <thead class="text-center">
                                                    <tr>
                                                        <th>Unit Name</th>
                                                        <th>Type</th>
                                                        <th>Terminal No (if Applicable)</th>
                                                        <th>Mobile</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="UnitTableBodyBranch${AccountsID}">
                                                    <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantUnitInfo">
                                                        EXEC GetMerchantUnits '${param.MerchantID}', ${AccountsID} 
                                                    </sql:query>
                                                    <c:forEach var = "rowMerchantUnitInfo" items = "${resultMerchantUnitInfo.rows}" varStatus="UnitRow">
                                                        <c:set var="UnitID" value="${rowMerchantUnitInfo.Unit_ID}"/>
                                                        <c:set var="UnitName" value="${rowMerchantUnitInfo.UnitName}"/>
                                                        <c:set var="Type" value="${rowMerchantUnitInfo.Type}"/>
                                                        <c:set var="TERMINAL_ID" value="${rowMerchantUnitInfo.TERMINAL_ID}"/>
                                                        <c:set var="TERMINAL_Mobile" value="${rowMerchantUnitInfo.mobilenumber}"/>
                                                        <tr id="Account${AccountsID}Unit${UnitRow.index}">
                                                            <td>
                                                                <input type="hidden" id="UnitActiveStatus${UnitID}" value="0"/> <input type="hidden" name="UnitIDs" value="${UnitID}"> 
                                                                <input type="text" class="form-control form-control-range" value="${UnitName}" ${readonly}  placeholder="" name="Account${UnitID}UnitName">
                                                            </td>
                                                            <td> 
                                                                <select  class="form-control"  name="Account${UnitID}UnitType" id="Account${UnitID}UnitType" value="${Type}" ${readonly}>
                                                                    <option value="">--Select Onboarding Type--</option>

                                                                    <sql:query dataSource = "${ALBMOSDB}" var = "resultOnboardType">
                                                                        EXEC DDOnboardType
                                                                    </sql:query>
                                                                    <c:forEach var = "rowOnboardType" items = "${resultOnboardType.rows}">
                                                                        <c:set var="DDID" value="${rowOnboardType.DDID}"/>
                                                                        <c:set var="DDDescription" value="${rowOnboardType.DDDescription}"/>
                                                                        <option value='${DDID}'>${DDDescription}</option>

                                                                    </c:forEach>
                                                                </select>
                                                            </td>
                                                            <td> <input type="text" class="form-control form-control-range"  value="${TERMINAL_ID}" ${readonly} placeholder="" name="Account${UnitID}TerminalID"></td>
                                                            <td> <input type="text" class="form-control form-control-range"  value="${TERMINAL_Mobile}" ${readonly} placeholder="" name="Account${UnitID}Mobile"></td>
                                                        </tr>
                                                    <script>$('#Account${UnitID}UnitType').val("${Type}")</script>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <script>
                                            //  alert("#ADepositoryBranch${AccountsID} : ${BranchOfAccount}");
                                            $('#ADepositoryBranch${AccountsID}').val("${BranchOfAccount}");
                                        </script>
                                    </div>
                                </c:forEach>

                            </div>



                            <c:choose>
                                <c:when test="${param.Action ==2 || param.Action ==3}">
                                    <c:set var="readonly" value=""/>
                                    <a onclick="AddNewAccount()" class="btn btn-primary btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-plus-square"></i>
                                        </span>
                                        <span class="text">Add New Accounts</span>
                                    </a>
                                </c:when>
                                <c:otherwise>

                                </c:otherwise>
                            </c:choose>         
                        </div>
                    </div>
                </div>

            </div>

            <!--Authorized Signature-->
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardAuthorizedSignature" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Authorized Signature</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardAuthorizedSignature">
                        <div class="card-body">
                            <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantInfo">
                                EXEC GetMerchantAuthorizedSignature '${param.MerchantID}'
                            </sql:query>
                            <c:forEach var = "rowMerchantInfo" items = "${resultMerchantInfo.rows}" varStatus="ASRow">
                                <c:set var="AS_ID" value="${rowMerchantInfo.ID}"/>
                                <c:set var="AS_NAME" value="${rowMerchantInfo.AS_NAME}"/>
                                <c:set var="AS_DESIGNATION" value="${rowMerchantInfo.AS_DESIGNATION}"/>
                                <c:set var="AS_CONTACT_NUMBER" value="${rowMerchantInfo.AS_CONTACT_NUMBER}"/>
                                <c:set var="AS_EMAIL" value="${rowMerchantInfo.AS_EMAIL}"/>
                                <label><b>Authorized Signature ${ASRow.count}</b></label>
                                <div class="form-group row col-12">
                                    <input hidden name="ASIDs" value="${AS_ID}"/>
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <label>Name</label>
                                        <input required type="text" class="form-control form-control-range" value="${AS_NAME}"  ${readonly} name="asName${AS_ID}"
                                               placeholder="ex. Juan Dela Cruz">
                                    </div>
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <label>Designation</label>
                                        <input required type="text" class="form-control form-control-range" value="${AS_DESIGNATION}" ${readonly} name="asDesignation${AS_ID}"
                                               placeholder="ex. Accounting">
                                    </div>
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <label>Contact Number</label>
                                        <input required type="text" class="form-control form-control-range" value="${AS_CONTACT_NUMBER}" ${readonly} name="asContactnumber${AS_ID}"
                                               placeholder="ex. 0912-345-6789">
                                    </div>
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <label>Email Address</label>
                                        <input required type="text" class="form-control form-control-range" value="${AS_EMAIL}" ${readonly} name="asEmailAddress${AS_ID}"
                                               placeholder="ex. juandelacruz@phil.ph">
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>

            </div>

            <!--Contact Person-->
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardContactPerson" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Contact Person</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardContactPerson">
                        <div class="card-body">
                            <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantContactInfo">
                                EXEC GetMerchantContactPerson '${param.MerchantID}'
                            </sql:query>
                            <c:forEach var = "rowMerchantContactInfo" items = "${resultMerchantContactInfo.rows}">
                                <c:set var="CP_ID" value="${rowMerchantContactInfo.ID}"/>
                                <c:set var="CP_NAME" value="${rowMerchantContactInfo.CP_NAME}"/>
                                <c:set var="CP_DESIGNATION" value="${rowMerchantContactInfo.CP_DESIGNATION}"/>
                                <c:set var="CP_DEPARTMENT" value="${rowMerchantContactInfo.CP_DEPARTMENT}"/>
                                <c:set var="CP_CONTACT_NUMBER" value="${rowMerchantContactInfo.CP_CONTACT_NUMBER}"/>
                                <c:set var="CP_FAX_NO" value="${rowMerchantContactInfo.CP_FAX_NO}"/>
                                <c:set var="CP_EMAIL" value="${rowMerchantContactInfo.CP_EMAIL}"/>
                            </c:forEach>
                            <div class="form-group row">
                                <input type="hidden" name="CPID" value="${CP_ID}"/>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Name</label>
                                    <input required type="text" class="form-control form-control-range" value="${CP_NAME}" ${readonly} name="CPName" placeholder="ex. Juan Dela Cruz">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Designation</label>
                                    <input required type="text" class="form-control form-control-range" value="${CP_DESIGNATION}" ${readonly} name="CPDesignation" placeholder="ex. Accounting">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Department</label>
                                    <input required type="text" class="form-control form-control-range" value="${CP_DEPARTMENT}" ${readonly} name="CPDepartment" placeholder="ex. 0912-345-6789">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Contact Number</label>
                                    <input required type="text" class="form-control form-control-range" value="${CP_CONTACT_NUMBER}" ${readonly} name="CPContactNumber" placeholder="ex. juandelacruz@phil.ph">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Fax Number</label>
                                    <input type="text" class="form-control form-control-range" value="${CP_FAX_NO}" ${readonly} name="CPFaxNumber" placeholder="ex. 23432qw324">
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <label>Email Address</label>
                                    <input required type="email" class="form-control form-control-range" value="${CP_EMAIL}" ${readonly} name="CPEmailAddress" placeholder="ex. juandelacruz@phil.ph">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!--Attachments-->
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardAttachments" class="d-block card-header py-3" data-toggle="collapse"
                       role="button" aria-expanded="true" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Attachments</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse show" id="collapseCardAttachments">
                        <div class="card-body">


                            <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantContactInfo">
                                EXEC GetMerchantAttachments '${param.MerchantID}'
                            </sql:query>
                            <input HIDDEN name="toRemoveAttachmentIDs" id="toRemoveAttachmentIDs">
                            <div class="form-group row">

                                <c:forEach var = "rowMerchantContactInfo" items = "${resultMerchantContactInfo.rows}">
                                    <c:set var="ATTACHMENT_ID" value="${rowMerchantContactInfo.ID}"/>
                                    <c:set var="ATTACHMENT_FILENAME" value="${rowMerchantContactInfo.FILENAME}"/>
                                    <c:set var="ATTACHMENT_FILEPATH" value="${rowMerchantContactInfo.FILEPATH}"/>
                                    <c:set var="ATTACHMENT_TYPE" value="${rowMerchantContactInfo.ATTACHMENTTYPE}"/>
                                    <div class="col-sm-10 mb-10 mb-sm-0 attachment_${ATTACHMENT_ID}">
                                        <input required type="text" class="form-control form-control-range" value="${ATTACHMENT_FILENAME}" readonly >
                                    </div>
                                    <div class="col-sm-2 attachment_${ATTACHMENT_ID}" >
                                        <c:choose>
                                            <c:when test="${param.Action ==2 || param.Action ==3}">

                                                <a class="btn btn-info"  target="_blank" href="${ATTACHMENT_FILEPATH}"><i class="fa fa-eye"></i></a>
                                                <button class="btn btn-danger" type="button" onclick="removeAttachment('${ATTACHMENT_ID}')" ><i class="fa fa-trash"></i></button>

                                            </c:when>
                                            <c:otherwise>

                                                <a class="btn btn-info"  target="_blank" href="${ATTACHMENT_FILEPATH}"><i class="fa fa-eye"></i></a>
                                                </c:otherwise>
                                            </c:choose>  
                                    </div>
                                </c:forEach>
                            </div>
                            <c:choose>
                                <c:when test="${param.Action ==2 || param.Action ==3}">


                                    <input HIDDEN id="newattachments">
                                    <a data-toggle="modal" data-target="#KnowledgeBaseModal" class="btn btn-primary btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-plus-square"></i>
                                        </span>
                                        <span class="text" id="newattachments2">Add New Attachment</span>
                                    </a>
                                </c:when>
                                <c:otherwise>

                                </c:otherwise>
                            </c:choose>  
                        </div>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${param.Action == 0}">

                    <div class="col-lg-12">
                        <center>
                            <button type="button" class="btn btn-primary btn-user" onclick="GotoRejectedMerchantList()">
                                Back
                            </button>

                        </center>
                        <br>
                    </div>

                </c:when>
                <c:when test="${param.Action == 2}">
                    <div class="col-lg-12">
                        <center>
                            <button type="button" class="btn btn-success btn-user" data-toggle="modal" data-target="#ConfirmModal" onclick="SaveEditedMerchant('${param.MerchantID}')">
                                Re-Submit
                            </button>
                            <button type="submit" hidden id="submitbutton"></button>
                        </center>
                        <br>
                    </div>

                </c:when>
                <c:when test="${param.Action == 3}">
                    <div class="col-lg-12">
                        <center>
                            <button style="display:none" type="button" class="btn btn-success btn-user" data-toggle="modal" data-target="#OverrideModal" >
                                Save
                            </button>
                            <button type="button" class="btn btn-success btn-user" data-toggle="modal" data-target="#ConfirmModal" onclick="SaveEditedMerchant('${param.MerchantID}')">
                                Save
                            </button>
                            <button type="submit" hidden id="submitbutton"></button>
                        </center>
                        <br>
                    </div>

                </c:when>
            </c:choose>                            
        </form>
        <c:choose>
            <c:when test="${param.Action == 1}">
                <form id="Form-MerchantAdd" >

                    <div class="col-lg-12">
                        <center>
                            <button type="button" class="btn btn-success btn-user" data-toggle="modal" data-target="#ConfirmModal" onclick="ApproveMerchant('${param.MerchantID}')">
                                Approve
                            </button>
                            <button type="button" class="btn btn-warning btn-user " data-toggle="modal" data-target="#ConfirmModal"  onclick="DisApproveMerchant('${param.MerchantID}')">
                                Disapprove
                            </button>
                            <button type="button" class="btn btn-danger btn-user " data-toggle="modal" data-target="#ConfirmModal"  onclick="RejectMerchant('${param.MerchantID}')">
                                Reject
                            </button>
                        </center>
                        <br>
                    </div>
                </form>
            </c:when>
        </c:choose>

        <script>
            
            $('#attachment_MERCHID').val('${param.MerchantID}');
            var toRemoveAttachment = [];
            function removeAttachment(id) {
                $('.attachment_' + id).hide();
                toRemoveAttachment.push(id);
                $('#toRemoveAttachmentIDs').val(toRemoveAttachment.toString());
            }
            $('.accountnumber').mask('00-00000-0');
            $('.mobilenumber').mask('0000-000-0000');
            function GotoRejectedMerchantList() {
                window.location.href = "RejectedDisapprovedMerchant.jsp";
            }
            $('#Form-MerchantEdit').submit(function (e) {
                $('#MRemarks').val($('#remarks').val());
                var returnmess = "", title = "", color = "", mess = "", userid = "", newUserLogin = "";
                var form = $(this);
                var dataArray = $(form).serializeArray();
                $.ajax({
                    url: 'MerchantUpdate',
                    type: 'POST',
                    data: dataArray,
                    success: function (data) {
                        returnmess = data.split(";;");
                        title = returnmess[0];
                        color = returnmess[1];
                        mess = returnmess[2];
                        //  userid = returnmess[3];
                        //  alert(data);
                        $.toaster({message: mess, title: title, priority: color});
                        if (title === "Alert") {

                        } else if (title === "Success") {
                            $('#KBFileUploadBTN').click();
                            if ('${param.Action}' === '3') {
                                location.reload();
                           } else {
                                window.location.href = "dashboard.jsp";
                            }

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error! Index (Form-Submit)" + thrownError);
                    }
                });

                e.preventDefault();
            });



        </script>
    </body>
</html>
