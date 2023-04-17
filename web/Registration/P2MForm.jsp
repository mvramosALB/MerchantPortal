<%-- 
    Document   : POSForm
    Created on : 01 7, 21, 10:25:00 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

    </head>
    <form id="Form-MerchantAdd" >
        <input type="hidden" name="action" value="1" />
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
                                <input required type="text" class="form-control form-control-range" name="CorporateName"
                                       placeholder="ex. AllHome">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Type of Business</label>
                                <%@ include file="/DD/TypeOfBusinessDD.jsp" %>
                            </div>
                            <div class="col-sm-12 mb-6 mb-sm-0">
                                <label>Head Office Address</label>
                                <input required type="text" class="form-control form-control-range" name="HOAddress"
                                       placeholder="ex. Mandaluyong City">
                            </div>
                            <div class="col-sm-6 mb-6 mb-sm-0"  hidden>
                                <label>Depository Branch</label>
                                <input  type="text" class=" form-control-range" name="DepositoryBranch"
                                        placeholder="ex. Main Branch">
                            </div>
                            <div class="col-sm-6 mb-6 mb-sm-0" hidden>
                                <label>Account Number</label>
                                <input  type="text" class=" form-control-range" name="AccountNumber"
                                        placeholder="ex. 9273-348-1233">
                            </div>
                        </div>


                    </div>
                </div>
            </div>

        </div>
        <!--Onboard Details-->
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
                                <input required type="number" value="0" class="form-control form-control-range" name="RateValue"
                                       placeholder="ex. 100.00 or 1%">
                            </div>
                            <div class="col-sm-3 mb-3 mb-sm-0">
                                <label>QR Expiration (in mins)</label>
                                <input required type="number" class="form-control form-control-range" name="QREXP" value="0"
                                       placeholder="ex. 30">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                            <div class="form-group row NewAccountDiv_1" >


                                <div class="col-sm-4 mb-3 mb-sm-0">
                                    <label>Depository Branch</label>
                                    <input style="display:none" name="AccountsNewIds" value="1">
                                    <select class="form-control" id="ADepositoryBranch1New" name="ADepositoryBranchNew">
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
                                    <input required type="text"  class="form-control  accountnumber" name="AAccountNumberNew" id="AAccountNumber1" placeholder="ex. 20-00001-2">

                                </div>

                                <div class="col-sm-2 mb-2 mb-sm-0">
                                    <label>No. of Units</label>
                                    <input required type="number" min="0" class="form-control ANoUnitsNew" name="ANoUnitsNew" id="ANoUnits1" placeholder="ex. 1"  onchange="AddUnit('1')"  value="0">
                                    <input type="hidden" id="ANoUnits1Current" value="0"/>
                                    <input type="hidden" id="ANoUnits1New" value="0"/>
                                </div>

                                <div class="col-sm-12 mb-12 mb-sm-0 unitsTable1" style="display:none" >
                                    <br>
                                    <label>Units</label>
                                    <table width="100%">
                                        <thead class="text-center">
                                            <tr>
                                                <th>Unit Name</th>
                                                <th>Type</th>
                                                <th>Terminal ID (if applicable)</th>
                                                <th>Mobile Number</th>
                                            </tr>
                                        </thead>
                                        <tbody id="UnitTableBodyBranch1">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <a onclick="AddNewAccount()" class="btn btn-primary btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fas fa-plus-square"></i>
                            </span>
                            <span class="text">Add New Account</span>
                        </a>
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
                        <label><b>Authorized Signature 1</b></label>
                        <div class="form-group row col-12">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input required type="text" class="form-control form-control-range" name="asName1"
                                       placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input required type="text" class="form-control form-control-range" name="asDesignation1"
                                       placeholder="ex. Accounting">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input required type="text" class="form-control form-control-range mobilenumber" name="asContactnumber1"
                                       placeholder="ex. 0912-345-6789">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input required type="email" class="form-control form-control-range" name="asEmailAddress1"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                        </div>
                        <label><b>Authorized Signature 2</b></label>
                        <div class="form-group row  col-12">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input  type="text" class="form-control form-control-range" name="asName2"
                                        placeholder="ex. Juan Dela Cruz. If not applicable please type N/A">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input  type="text" class="form-control form-control-range" name="asDesignation2"
                                        placeholder="ex. Accounting . If not applicable please type N/A">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input  type="text" class="form-control form-control-range " name="asContactnumber2"
                                        placeholder="ex. 0912-345-6789 . If not applicable please type N/A">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input  type="text" class="form-control form-control-range" name="asEmailAddress2"
                                        placeholder="ex. juandelacruz@phil.ph . If not applicable please type N/A">
                            </div>
                        </div>

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

                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input required type="text" class="form-control form-control-range" name="CPName" placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input required type="text" class="form-control form-control-range" name="CPDesignation" placeholder="ex. Store Manager">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Department</label>
                                <input required type="text" class="form-control form-control-range" name="CPDepartment" placeholder="ex. Sales">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input required type="text" class="form-control form-control-range mobilenumber" name="CPContactNumber" placeholder="ex. 0912-345-6789">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Fax Number</label>
                                <input type="text" class="form-control form-control-range" name="CPFaxNumber" placeholder="ex. 23432qw324">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input required type="email" class="form-control form-control-range" name="CPEmailAddress" placeholder="ex. juandelacruz@phil.ph">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <form id="attachement_Form">

    </form>
    <script>
        function removeAccount(id) {
            $('.NewAccountDiv_' + id).remove();
            var Newaccountnumber = parseInt($('#NewAccountCountsss').val());
            var Newnewaccountcount = Newaccountnumber - 1;
            $('#NewAccountCountsss').val(Newnewaccountcount);
            //alert('new Account count : ' + Newnewaccountcount);
        }
        function SubmitRegisterMerchant() {
            var emptyFieldCount = 0;
            $('#Form-MerchantAdd .form-control').each(function () {
                if ($(this).val() == "") {
                    emptyFieldCount++;
                    //  console.log($(this).attr("name"));
                    $(this).css("background-color", "#Ffb5b5");
                    $(this).focus();
                } else {
                    $(this).css("background-color", "#f8f9fc");
                }

            });

            if (emptyFieldCount > 0) {
                alert("Please complete the required fields");
                //$('#Form-MerchantAdd').submit();
            } else {
                $('#Form-MerchantAdd').submit();
            }
            emptyFieldCount = 0;
            //
        }
        $('#Form-MerchantAdd').submit(function (e) {

            var returnmess = "", title = "", color = "", mess = "", MERCHID = "", newUserLogin = "";
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
                    MERCHID = returnmess[3];
                    $('#attachment_MERCHID').val(MERCHID);
                    $.toaster({message: mess, title: title, priority: color});
                    if (title === "Alert") {

                    } else if (title === "Success") {
                        //   window.location.href = "dashboard.jsp";
                        setTimeout(function () {
                            //  alert('asd');
                            $('#KBFileUploadBTN').click();
                        }, 1000);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Index (Form-Submit)" + thrownError);
                }
            });

            e.preventDefault();
        });
        $('#Form-attachement_Form').submit(function (e) {

            var returnmess = "", title = "", color = "", mess = "", MERCHID = "", newUserLogin = "";
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
                    MERCHID = returnmess[3];
                    $('#attachment_MERCHID').val(MERCHID);
                    $.toaster({message: mess, title: title, priority: color});
                    if (title === "Alert") {

                    } else if (title === "Success") {
                        window.location.href = "dashboard.jsp";
                        $('#attachement_Form').submit();
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Index (Form-Submit)" + thrownError);
                }
            });

            e.preventDefault();
        });
        $('.accountnumber').mask('00-00000-0');
        $('.mobilenumber').mask('0000-000-0000');

        $('.ANoUnitsNew').on('keyup', function () {
            if ($(this).val() < 0) {
                $(this).val(0);
            }
        });
    </script>
</html>
