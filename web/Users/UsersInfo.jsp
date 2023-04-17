<%-- 
    Document   : main
    Created on : 01 25, 21, 10:40:11 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">User Information</h1>
    <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>
        <sql:query dataSource = "${ALBMOSDB}" var = "resultUserInfo">
        EXEC GetUserInfo ${param.UserID}
    </sql:query>
    <c:forEach var = "rowUserInfo" items = "${resultUserInfo.rows}">
        <c:set var="USER_GROUP" value="${rowUserInfo.USER_GROUP}"/>
        <c:set var="UserID" value="${rowUserInfo.UserID}"/>
        <c:set var="USER_FULLNAME" value="${rowUserInfo.USER_FULLNAME}"/>
        <c:set var="USERNAME" value="${rowUserInfo.USERNAME}"/>
        <c:set var="MOBILE_NUMBER" value="${rowUserInfo.MOBILE_NUMBER}"/>
        <c:set var="Email" value="${rowUserInfo.Email}"/>
        <c:set var="MERCHID" value="${rowUserInfo.MERCHID}"/>
        <c:set var="BRANCHID" value="${rowUserInfo.BRANCHID}"/>
        <c:set var="TERMINALID" value="${rowUserInfo.TERMINALID}"/>
    </c:forEach>
    <!-- DataTales Example -->
    <form class="user" id="Form-UserAdd">
        <input type="hidden" value="2" name="action"/>
        <input type="hidden" value="${param.UserID}" name="UserID"/>
        <div class="card shadow mb-4">

            <div class="card-header py-3 clear-fix">
                <h6 class="m-0 font-weight-bold text-primary">User Info</h6>
            </div>
            <div class="card-body">

                <div class="form-group row">
                    <div class="col-sm-12 mb-12 mb-sm-0">
                        <label>User Group</label>
                        <%@ include file="/DD/UserGroupDD.jsp" %>
                    </div>
                    <hr>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>User Full Name</label>
                        <input value="${USER_FULLNAME}" type="text" class="form-control form-control-range" name='UserFname' id="UserFname-input"  placeholder="ex. Juan Dela Cruz" maxlength="50">
                    </div>
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Username</label>
                        <input value="${USERNAME}" required type="text" class="form-control form-control-range" name="Username" id="Username-input"  placeholder="ex. JDelaCruz" maxlength="50">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Mobile Number</label>
                        <input value="${MOBILE_NUMBER}" required type="text" class="form-control form-control-range" name="UserMobileNumber" id="UserMobileNumber-input"  placeholder="ex. 099123456789" maxlength="15">
                    </div>
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Email</label>
                        <input value="${Email}" type="email" required class="form-control form-control-range" name="UserEmail" id="UserEmail-input"  placeholder="ex. JDelaCruz@allbank.ph" maxlength="50">
                    </div>
                </div>
            </div>
        </div> 
        <div id="add-MerchantInfo-div"></div>
        <div class="col-lg-12">

            <button type="submit" class="btn btn-primary btn-user btn-block">
                Save
            </button>

        </div>
    </form>
    <script>
        $('#Form-UserAdd').submit(function (e) {

            var returnmess = "", title = "", color = "", mess = "", userid = "", newUserLogin = "";
            var form = $(this);
            var dataArray = $(form).serializeArray();
            $.ajax({
                url: 'UserMaintenanceUpdates',
                type: 'POST',
                data: dataArray,
                success: function (data) {
                    returnmess = data.split(";;");
                    title = returnmess[0];
                    color = returnmess[1];
                    mess = returnmess[2];
                    userid = returnmess[3];

                    $.toaster({message: mess, title: title, priority: color});
                    if (title === "Alert") {

                    } else if (title === "Success") {
                        window.location.href = "Users.jsp";

                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Index (Form-Submit)" + thrownError);
                }
            });
            e.preventDefault();
        });
    </script>
    <script>
        $('#UserGroupDD').on('change', function () {
            $.ajax({
                url: 'Users/merchantinfo.jsp',
                type: 'POST',
                data: {UserGroupID: $(this).val()},
                success: function (data) {
                    $('#add-MerchantInfo-div').html(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  UserInfo " + thrownError);
                }
            });
        });
        $('#UserGroupDD').val("${USER_GROUP}");
        $.ajax({
            url: 'Users/merchantinfo.jsp',
            type: 'POST',
            data: {UserGroupID: '${USER_GROUP}'},
            success: function (data) {
                $('#add-MerchantInfo-div').html(data);
                $('#MerchantDD').val("${MERCHID}");


                //display branch DD

                if ('${USER_GROUP}' === '5') {
                    $.ajax({
                        url: 'DD/MerchantBranchDDM.jsp',
                        type: 'POST',
                        data: {MerchID: '${MERCHID}'},
                        success: function (data) {
                            $('#branches-div').html(data);
                            //$('#BranchDD').val("${BRANCHID}");

                            var values = "${BRANCHID}";
                            $.each(values.split(","), function (i, e) {
                                $("#BranchDD option[value='" + e + "']").prop("selected", true);
                            });

                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log("Error! UserInfo - Display Branch" + thrownError);
                        }
                    });
                } else if ('${USER_GROUP}' === '6') {
                    $.ajax({
                        url: 'DD/MerchantBranchDD.jsp',
                        type: 'POST',
                        data: {MerchID: '${MERCHID}'},
                        success: function (data) {
                            $('#branch-div').html(data);
                            $('#BranchDD').val("${BRANCHID}");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log("Error!  CMS (View Documents)" + thrownError);
                        }
                    });
                }else if ('${USER_GROUP}' === '7') {
                    $.ajax({
                        url: 'DD/MerchantBranchDD.jsp',
                        type: 'POST',
                        data: {MerchID: '${MERCHID}'},
                        success: function (data) {
                            $('#branch-div').html(data);
                            $('#BranchDD').val("${BRANCHID}");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log("Error!  CMS (View Documents)" + thrownError);
                        }
                    });
                }

                if ('${USER_GROUP}' === '7') {

                    //display Terminal 

                    $.ajax({
                        url: 'DD/MerchantTerminalDDM.jsp',
                        type: 'POST',
                        data: {MerchID: '${MERCHID}', BranchID: '${BRANCHID}'},
                        success: function (data) {
                            $('#terminal-div').html(data);
                            
                            var values = "${TERMINALID}";
                            $.each(values.split(","), function (i, e) {
                                $("#TerminalDD option[value='" + e + "']").prop("selected", true);
                            });
                            //$('#TerminalDD').val("${TERMINALID}");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log("Error!  UserInfo - Display Terminal" + thrownError);
                        }
                    });

                } else {
                    //display Terminal 

                    $.ajax({
                        url: 'DD/MerchantTerminalDD.jsp',
                        type: 'POST',
                        data: {MerchID: '${MERCHID}', BranchID: '${BRANCHID}'},
                        success: function (data) {
                            $('#terminal-div').html(data);
                            $('#TerminalDD').val("${TERMINALID}");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log("Error!  UserInfo - Display Terminal" + thrownError);
                        }
                    });

                }


            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log("Error!  UserInfo " + thrownError);
            }
        });

    </script>

</html>
