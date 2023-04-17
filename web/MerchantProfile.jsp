<%-- 
    Document   : MerchantFiling
    Created on : 01 4, 21, 5:30:55 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>AllBank MOS - Merchant Profile</title>
        <%@ include file="Includes/links.jsp" %>
        <link rel="stylesheet" href="css/plugins/dropzone.css">
        <!-- Custom styles for this page -->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Sidebar -->
            <%@ include file="Includes/sidebar.jsp" %>
            <!-- End of Sidebar -->
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <%@ include file="Includes/topbar.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid" >
                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantInfo">
                            EXEC GetMerchantInfo ${requestScope.ID}
                        </sql:query>
                        <c:forEach var = "rowMerchantInfo" items = "${resultMerchantInfo.rows}">
                            <c:set var="ServiceType" value="${rowMerchantInfo.ServiceType}"/>
                            <c:set var="MERCHTYPE" value="${rowMerchantInfo.MT_DESCRIPTION}"/>
                            <c:set var="MERCHCLASS" value="${rowMerchantInfo.MC_DESCRIPTION}"/>
                            <c:set var="RATETYPE" value="${rowMerchantInfo.RATE_DESCRIPTION}"/>
                            <c:set var="RATEVALUE" value="${rowMerchantInfo.RATEVALUE}"/>
                            <c:set var="QREXP" value="${rowMerchantInfo.qr_exp}"/>
                            <c:set var="MERCHNAME" value="${rowMerchantInfo.MERCHNAME}"/>
                            <c:set var="TypeOfBusiness" value="${rowMerchantInfo.TB_TYPE}"/>
                            <c:set var="HOAddress" value="${rowMerchantInfo.HOAddress}"/>
                            <c:set var="DepositoryBranch" value="${rowMerchantInfo.DepositoryBranch}"/>
                            <c:set var="AccountNumber" value="${rowMerchantInfo.AccountNumber}"/>
                        </c:forEach>
                        <!-- Page Heading -->
                        <div class="card-header d-sm-flex align-items-center justify-content-between " id="headerdiv">
                            <h1 class="h3 mb-2 text-gray-800">${MERCHNAME}   <small>(Merchant's Profile)</small></h1>
                            <c:choose>
                                <c:when test="${USERGROUP != 8}">
                                    <a id="UpdateBtn" onclick="LoadMerchantInfo('${requestScope.ID}')" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" ><i
                                            class="fas fa-refresh fa-sm text-white-50"></i> Update</a>
                                    </c:when>
                                </c:choose>
                        </div>
                        <br>
                        <input type="hidden"  id="TerminalNumber" value="0"/>
                        <div class="row" id="div-userContainer">
                            <div class="col-lg-8">
                                <!--Merchant Information-->
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold text-danger">Merchant Informations</h6>
                                    </div>
                                    <div class="card-body row" >
                                        <div class="col-lg-6">
                                            <table>
                                                <tbody>
                                                    <tr><th>Business Address : </th><td>${HOAddress}</td></tr>
                                                    <tr><th>Type of Business : </th><td>${TypeOfBusiness}</td></tr>

                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="col-lg-6">

                                        </div>
                                    </div>
                                </div>
                                <!-- branches and Terminals-->   
                                <div class="card mb-4" style="display:none">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-danger">Branches and Terminals</h6>
                                    </div>
                                    <div class="card-body text-sm">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantBranches">
                                            EXEC GetMerchantBranches ${requestScope.ID}
                                        </sql:query>
                                        <c:forEach var = "rowMerchantBranches" items = "${resultMerchantBranches.rows}">
                                            <c:set var="BRANCHID" value="${rowMerchantBranches.BRANCHID}"/>
                                            <c:set var="BRANCHName" value="${rowMerchantBranches.BRANCHName}"/>
                                            <c:set var="REGISTERED_ADDRESS" value="${rowMerchantBranches.REGISTERED_ADDRESS}"/>
                                            <c:set var="NO_TERMINALS" value="${rowMerchantBranches.NO_TERMINALS}"/>
                                            <table width="100%">
                                                <tbody>
                                                    <tr><th class="text-lg">${BRANCHName}</th></tr>
                                                    <tr><td>${REGISTERED_ADDRESS}</td></tr>
                                                </tbody>
                                            </table>  
                                            <br>
                                            <div id="terminals-BRANCHID">
                                                <table class="table table-bordered " width="100%" >
                                                    <thead>
                                                        <tr>
                                                            <th>Terminal ID </th>
                                                            <th>Terminal Type</th>
                                                            <th>Telco :</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantTerminals">
                                                            EXEC GetMerchantTerminals ${requestScope.ID},${BRANCHID}
                                                        </sql:query>
                                                        <c:forEach var = "rowMerchantTerminals" items = "${resultMerchantTerminals.rows}">
                                                            <c:set var="TERMINAL_ID" value="${rowMerchantTerminals.TERMINAL_ID}"/>
                                                            <c:set var="POS_Terminal_type" value="${rowMerchantTerminals.POS_Terminal_type}"/>
                                                            <c:set var="Telco" value="${rowMerchantTerminals.Telco}"/>
                                                            <tr>
                                                                <td>${TERMINAL_ID}</td>
                                                                <td>${POS_Terminal_type}</td>
                                                                <td>${Telco}</td>
                                                            </tr>
                                                        </c:forEach>

                                                    </tbody>
                                                </table>  


                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- Accounts and Units-->   
                                <div class="card mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-danger">Accounts and Units</h6>
                                    </div>
                                    <div class="card-body text-sm">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantAccounts">
                                            EXEC GetMerchantAccounts ${requestScope.ID}
                                        </sql:query>
                                        <c:forEach var = "rowMerchantAccounts" items = "${resultMerchantAccounts.rows}">
                                            <c:set var="ID" value="${rowMerchantAccounts.ID}"/>
                                            <c:set var="ACCTNO" value="${rowMerchantAccounts.ACCTNO}"/>
                                            <c:set var="BranchOfAccount" value="${rowMerchantAccounts.BOA_DESCRIPTION}"/>
                                            <c:set var="NO_UNITS" value="${rowMerchantAccounts.NO_UNITS}"/>
                                            <table width="100%">
                                                <tbody>
                                                    <tr><th class="text-lg">Account Number : ${ACCTNO}</th></tr>
                                                    <tr><td>${BranchOfAccount}</td></tr>
                                                </tbody>
                                            </table>  
                                            <br>
                                            <div id="units-AccountID">
                                                <table class="table table-bordered " width="100%" >
                                                    <thead>
                                                        <tr>
                                                            <th>Unit Name</th>
                                                            <th>On-board Type</th>
                                                            <th>Terminal ID</th>
                                                            <th>Mobile Number</th>
                                                            <th>Transactions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantUnits">
                                                            EXEC GetMerchantUnits ${requestScope.ID},${ID}
                                                        </sql:query>
                                                        <c:forEach var = "rowMerchantUnits" items = "${resultMerchantUnits.rows}">
                                                            <c:set var="Unit_ID" value="${rowMerchantUnits.Unit_ID}"/>
                                                            <c:set var="UnitName" value="${rowMerchantUnits.UnitName}"/>
                                                            <c:set var="Type" value="${rowMerchantUnits.ob_description}"/>
                                                            <c:set var="TERMINAL_ID" value="${rowMerchantUnits.TERMINAL_ID}"/>
                                                            <c:set var="TERMINAL_Mobile" value="${rowMerchantUnits.mobilenumber}"/>
                                                            <tr>
                                                                <td>${UnitName}</td>
                                                                <td>${Type}</td>
                                                                <td>${TERMINAL_ID}</td>
                                                                <td>${TERMINAL_Mobile}</td>
                                                                <td><center><button class="btn btn-info btn-sm" onclick="ViewTransactions('${Unit_ID}', '${TERMINAL_ID}')">View</button></center></td>
                                                        </tr>
                                                    </c:forEach>

                                                    </tbody>
                                                </table>  


                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- Attachments-->   
                                <div class="card mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-danger">Attachments</h6>
                                    </div>
                                    <div class="card-body text-sm">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantContactInfo">
                                            EXEC GetMerchantAttachments ${requestScope.ID}
                                        </sql:query>
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
                                                    <a class="btn btn-info"  target="_blank" href="${ATTACHMENT_FILEPATH}"><i class="fa fa-eye"></i></a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <!--Onboarding Information-->
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold text-danger">Onboarding  Informations</h6>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-bordered table-sm text-xs">
                                            <tbody>
                                                <tr><th>Merchant Type : </th><td>${MERCHTYPE}</td></tr>
                                                <tr><th>Merchant Class :</th><td>${MERCHCLASS}</td></tr>
                                                <tr><th>Rate Type : </th><td>${RATETYPE}</td></tr>
                                                <tr><th>Rate Value : </th><td>${RATEVALUE}</td></tr>
                                                <tr><th>QR Expiration : </th><td>${QREXP}</td></tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!--Contact Information-->
                                <div class="card mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-danger">Contact Information</h6>
                                    </div>
                                    <div class="card-body">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantCP">
                                            EXEC GetMerchantContactPerson ${requestScope.ID}
                                        </sql:query>
                                        <c:forEach var = "rowMerchantCP" items = "${resultMerchantCP.rows}">
                                            <c:set var="CP_NAME" value="${rowMerchantCP.CP_NAME}"/>
                                            <c:set var="CP_DESIGNATION" value="${rowMerchantCP.CP_DESIGNATION}"/>
                                            <c:set var="CP_DEPARTMENT" value="${rowMerchantCP.CP_DEPARTMENT}"/>
                                            <c:set var="CP_CONTACT_NUMBER" value="${rowMerchantCP.CP_CONTACT_NUMBER}"/>
                                            <c:set var="CP_FAX_NO" value="${rowMerchantCP.CP_FAX_NO}"/>
                                            <c:set var="CP_EMAIL" value="${rowMerchantCP.CP_EMAIL}"/>
                                        </c:forEach>
                                        <table class="table table-bordered table-sm text-xs">
                                            <tbody>
                                                <tr><th>Name</th><td>${CP_NAME}</td></tr>
                                                <tr><th>Designation</th><td>${CP_DESIGNATION}</td></tr>
                                                <tr><th>Department</th><td>${CP_DEPARTMENT}</td></tr>
                                                <tr><th>Contact Number</th><td>${CP_CONTACT_NUMBER}</td></tr>
                                                <tr><th>Fax Number</th><td>${CP_FAX_NO}</td></tr>
                                                <tr><th>Email Address</th><td>${CP_EMAIL}</td></tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!--Authorized Signature-->
                                <div class="card mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-danger">Authorized Signature</h6>
                                    </div>
                                    <div class="card-body">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantAS">
                                            EXEC GetMerchantAuthorizedSignature ${requestScope.ID}
                                        </sql:query>
                                        <c:forEach var = "rowMerchantAS" items = "${resultMerchantAS.rows}" varStatus="varStat">
                                            <c:set var="AS_NAME" value="${rowMerchantAS.AS_NAME}"/>
                                            <c:set var="AS_DESIGNATION" value="${rowMerchantAS.AS_DESIGNATION}"/>
                                            <c:set var="AS_CONTACT_NUMBER" value="${rowMerchantAS.AS_CONTACT_NUMBER}"/>
                                            <c:set var="AS_EMAIL" value="${rowMerchantAS.AS_EMAIL}"/>
                                            <label class="text-dark">Authorized Signature ${varStat.count}</label>
                                            <table class="table table-bordered table-sm text-xs">
                                                <tbody>
                                                    <tr><th>Name</th><td>${AS_NAME}</td></tr>
                                                    <tr><th>Designation</th><td>${AS_DESIGNATION}</td></tr>
                                                    <tr><th>Contact Number</th><td>${AS_CONTACT_NUMBER}</td></tr>
                                                    <tr><th>Email Address</th><td>${AS_EMAIL}</td></tr>
                                                </tbody>
                                            </table>
                                            <br>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
                <!-- Footer -->
                <%@ include file="Includes/footer.jsp" %>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->
            <div class="modal fade" id="ConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Confirm Action </h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div  id="ApproveDiv">
                                Please confirm action
                            </div>
                        </div>
                        <div class="modal-footer">

                            <input type="hidden" name="action" id="ApprovalAction" />
                            <input type="hidden" name="MerchID" id="ApprovalMerch" value="12"/>

                            <button class="btn btn-secondary" type="button" onclick="SubmitEditedMerchant()" >Confirm</button>

                            <button class="btn btn-primary" data-dismiss="modal">Cancel</button>
                        </div>

                    </div>

                </div>
            </div>
                <div class="modal fade" id="OverrideModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">OverrideUpdate </h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div  id="ApproveDiv">
                                
                                Please confirm action
                            </div>
                            <input type="text" placeholder="username">
                            <input type="text" placeholder="password">
                        </div>
                        <div class="modal-footer">

                            <input type="hidden" name="action" id="ApprovalAction" />
                            <input type="hidden" name="MerchID" id="ApprovalMerch" value="12"/>

                            <button class="btn btn-secondary" type="button" onclick="SubmitEditedMerchant()" >Confirm</button>

                            <button class="btn btn-primary" data-dismiss="modal">Cancel</button>
                        </div>

                    </div>

                </div>
            </div>
            <div class="modal fade" id="KnowledgeBaseModal">
                <div class="modal-dialog md modal-default">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="KBModalTitle"></h4>
                        </div>  
                        <div class="modal-body">
                            <form id="KB-NewForm">
                                <div class="row" id="div-KB">

                                </div>
                            </form>
                            <form action="UploadAttachements" class="dropzone" id="KBUploader">
                                <input hidden name="MERCHID" ID="attachment_MERCHID">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <br>
                            <div class="col-lg-12">
                                <button hidden type="button" id="KBFileUploadBTN"></button>
                                <button type="button"  id="" hidden name="apply" class="btn btn-primary btn-sm" onclick="AddNewKB()">Save</button>
                                <button data-dismiss="modal"  type="button" class="btn btn-primary btn-sm "> DONE</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Logout Modal-->
        <%@ include file="Includes/LogoutModal.jsp" %>
        <%@ include file="Includes/ChangePasswordModal.jsp" %>
        <%@ include file="Includes/scripts.jsp" %>
        <script src="js/plugins/dropzone.js"></script>
        <!-- Page level custom scripts -->
        <script>
                                    Dropzone.options.KBUploader = {//INITIALIZE THE DROPZONE PLUGIN
                                        autoProcessQueue: false,
                                        addRemoveLinks: true,
                                        parallelUploads: 10,
                                        maxFilesize: 50,
                                        timeout: 0,
                                        init: function () {
                                            var submitButtonContractFile2 = document.querySelector("#KBFileUploadBTN");
                                            KBUploader = this; // closure
                                            submitButtonContractFile2.addEventListener("click", function () {
                                                KBUploader.processQueue(); // Tell Dropzone to process all queued files.
                                                if (KBUploader.files.length < 1) {
                                                    KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                                }
                                            });
                                            this.on("addedfile", function () {
                                                $('#newattachments').val(KBUploader.files.length);
                                                $('#newattachments2').text('Add New Attachment (' + KBUploader.files.length + ' new )');
                                                $('#submit-allcontractfile').show();
                                            });
                                            this.on("success", function () {
                                                KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                                $.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});

                                            });

                                        }
                                    };
                                    $(document).ready(function () {
                                        $('#Transactions-Datatables').DataTable();

                                    });
                                    function LoadMerchantInfo(MerchantID) {
                                        $.ajax({
                                            url: 'Merchants/MerchantInfo.jsp',
                                            type: 'POST',
                                            data: {MerchantID: MerchantID, Action: '3'}, //Action 3 is with save buttons
                                            success: function (data) {
                                                $('#UpdateBtn').remove();
                                                $('#div-userContainer').html(data);
                                            },
                                            error: function (xhr, ajaxOptions, thrownError) {
                                                console.log("Error!  Rejected/Disapproved Merchant (Load Disapproved erchant Information)" + thrownError);
                                            }
                                        });
                                    }
                                    function SubmitEditedMerchant() {
                                        $('#submitbutton').click();
                                    }

                                    //Acount Scripts
                                    function removeAccount(id) {
                                        $('.NewAccountDiv_' + id).remove();
                                        var Newaccountnumber = parseInt($('#NewAccountCountsss').val());
                                        var Newnewaccountcount = Newaccountnumber - 1;
                                        $('#NewAccountCountsss').val(Newnewaccountcount);
                                        //   alert('new Account count : ' + Newnewaccountcount);
                                    }
                                    function removeExistingAccount(id) {
                                        var oldToRemoveAccount = $('#toRemoveAccount').val();
                                        var oldToRemoveAccountArrayValues = oldToRemoveAccount.split(",");
                                        oldToRemoveAccountArrayValues.push(id);
                                        $('#toRemoveAccount').val(oldToRemoveAccountArrayValues);
                                        $('.ExistingAccountDiv_' + id).remove();
                                        //minus the Account Count
                                        var AccountCount = parseInt($('#AccountCount').val());
                                        var NewAccountCount = AccountCount - 1;
                                        $('#AccountCount').val(NewAccountCount);
//toRemoveAccounta add value
//    $('.NewAccountDiv_' + id).remove();
//    var Newaccountnumber = parseInt($('#NewAccountCountsss').val());
//    var Newnewaccountcount=Newaccountnumber-1;
//    $('#NewAccountCountsss').val(Newnewaccountcount);
//    alert('new Account count : '+Newnewaccountcount);
                                    }

                                    function AddNewAccount() {
                                        var accountnumber = parseInt($('#AccountCount').val());
                                        var Newaccountnumber = parseInt($('#NewAccountCountss').val());
                                        var NewNewaccountnumber = parseInt($('#NewAccountCountsss').val());
                                        $.ajax({
                                            url: 'Registration/AddNewAccount.jsp',
                                            type: 'POST',
                                            data: {AccountNo: Newaccountnumber + 1},
                                            success: function (data) {
                                                $('#Accounts-Div').append(data);

                                                $('#NewAccountCountss').val(Newaccountnumber + 1);
                                                $('#NewAccountCountsss').val(NewNewaccountnumber + 1);
                                                //  alert($('#NewAccountCountss').val());
                                            },
                                            error: function (xhr, ajaxOptions, thrownError) {
                                                console.log("Error!  CMS (View Documents)" + thrownError);
                                            }
                                        });
                                        accountnumber++;
                                    }
                                    function AddUnits(Branchid, start, end) {
                                        //  alert('#NewAccountUnitsCount'+Branchid);
                                        $('#NewAccountUnitsCount' + Branchid).val("2");
                                        $.ajax({
                                            url: 'DD/OnboardTypeDDOption.jsp',
                                            type: 'POST',
                                            data: {dummy: null},
                                            success: function (data) {
                                                var i;
                                                for (i = start; i < end; i++) {
                                                    //alert("#UnitTableBodyBranch" + Branchid + "Append")
                                                    $('#UnitTableBodyBranch' + Branchid).append('<tr id="Account' + Branchid + 'Unit' + i + '">' +
                                                            '<td> <input type="text" class="form-control " name="Account' + Branchid + 'UnitNameNew" id="Account' + Branchid + 'TerminalID' + i + '" placeholder=""></td>' +
                                                            '<td> <select  class="form-control"  name="Account' + Branchid + 'UnitTypeNew" id="Account' + Branchid + 'UnitType' + i + '">' + data + ' </select></td>' +
                                                            '<td> <input type="text" class="form-control " name="Account' + Branchid + 'TerminalIDNew" id="Account' + Branchid + 'TerminalTelco' + i + '" placeholder=""></td>' +
                                                            '<td> <input type="text" class="form-control " name="Account' + Branchid + 'MobileNew" id="Account' + Branchid + 'TerminalMobile' + i + '" placeholder=""></td>' +
                                                            '</tr>');
                                                }
                                            },
                                            error: function (xhr, ajaxOptions, thrownError) {
                                                console.log("Error!  CMS (View Documents)" + thrownError);
                                            }
                                        });


                                    }
                                    function RemoveUnits(Branchid, start, end) {
                                        var i;
                                        for (i = start; i < end; i++) {
                                            $('#Account' + Branchid + 'Unit' + i + '').remove();
                                        }
                                    }
                                    function AddUnit(BranchIDNo) {
                                        $('.unitsTable' + BranchIDNo).show();

                                        var NoTerminals = $('#ANoUnits' + BranchIDNo + "").val();
                                        if (NoTerminals === '') {
                                            NoTerminals = 0;
                                            $('#ANoUnits' + BranchIDNo).val("0");
                                        }
                                        // alert('#ANoUnits' + BranchIDNo + ":" + NoTerminals);
                                        var NoTerminalCurrent = $('#ANoUnits' + BranchIDNo + 'Current').val();
                                        var NoTerminalNew = NoTerminals;
                                        if (NoTerminalCurrent < NoTerminalNew) {
                                            //  alert("add from:" + NoTerminalCurrent + " to :" + NoTerminalNew);
                                            AddUnits(BranchIDNo, NoTerminalCurrent, NoTerminalNew);
                                        } else if (NoTerminalCurrent > NoTerminalNew) {
                                            //  alert("remove from:" + NoTerminalNew + " to :" + NoTerminalCurrent);
                                            RemoveUnits(BranchIDNo, NoTerminalNew, NoTerminalCurrent);
                                        } else {
                                            //  alert("ANoUnitsCurrent" + BranchIDNo + " : " + NoTerminalCurrent + " NoTerminalNew" + BranchIDNo + " : " + NoTerminalNew)

                                        }

                                        $('#ANoUnits' + BranchIDNo + 'Current').val(NoTerminalNew);

                                    }

                                    function ViewTransactions(UnitID, terminalNumber) {
                                        $.ajax({
                                            url: 'Merchants/Transactions.jsp',
                                            type: 'POST',
                                            data: {UnitID: UnitID,TerminalID:terminalNumber}, //Action 3 is with save buttons
                                            success: function (data) {
                                                $('#TerminalNumber').val(terminalNumber);
                                                $('#TerminalNumberBack').val(terminalNumber);
                                                $('#UpdateBtn').remove();
                                                $('#div-userContainer').html(data);
                                                $('#headerdiv').append('<a  onclick="ReloadPage()" class="d-none d-sm-inline-block btn btn-sm btn-info shadow-sm" ><i class="fas fa-refresh fa-sm text-white-50"></i> Back</a>')
                                            },
                                            error: function (xhr, ajaxOptions, thrownError) {
                                                console.log("Error!  Rejected/Disapproved Merchant (Load Disapproved erchant Information)" + thrownError);
                                            }
                                        });
                                    }
                                    function ReloadPage() {
                                        location.reload();
                                    }
        </script>

    </body>

</html>