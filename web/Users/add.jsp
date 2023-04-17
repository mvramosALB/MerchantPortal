<%-- 
    Document   : main
    Created on : 01 25, 21, 10:40:11 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Add New User</h1>
    <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>

    <!-- DataTales Example -->
    <form class="user" id="Form-UserAdd">
        <input type="hidden" value="1" name="action"/>
        <div class="card shadow mb-4">

            <div class="card-header py-3 clear-fix">
                <h6 class="m-0 font-weight-bold text-primary">User Info</h6>
            </div>
            <div class="card-body">

                <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>User Group</label>
                        <%@ include file="/DD/UserGroupDD.jsp" %>

                    </div>
                    <hr>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>User Full Name</label>
                        <input type="text" class="form-control form-control-range" name='UserFname' id="UserFname-input"  placeholder="ex. Juan Dela Cruz" maxlength="50">
                    </div>
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Username</label>
                        <input type="text" class="form-control form-control-range" name="Username" id="Username-input"  placeholder="ex. JDelaCruz" maxlength="50">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Mobile Number</label>
                        <input type="text" class="form-control form-control-range" name="UserMobileNumber" id="UserMobileNumber-input"  placeholder="ex. 099123456789" maxlength="15">
                    </div>
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Email</label>
                        <input type="email" class="form-control form-control-range" name="UserEmail" id="UserEmail-input"  placeholder="ex. JDelaCruz@allbank.ph" maxlength="50">
                    </div>


                </div>
                        
<div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                        <label>Password Notification</label>
                        <br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="PassNotif" id="PassNotif1" value="SMS" checked>
                            <label class="form-check-label" for="PassNotif1">
                                via SMS
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="PassNotif" id="PassNotif2" value="EMAIL">
                            <label class="form-check-label" for="PassNotif2">
                                via Email
                            </label>
                        </div>
                    </div>
                </div>

            </div> 
            <div id="add-MerchantInfo-div"></div>
            <div class="col-lg-12">

                <button type="submit" class="btn btn-primary btn-user btn-block">
                    Register Account
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
                        //  window.location.href = "Users.jsp?LOC=UsersInfo&ID="+userid;
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
                    console.log("Error!  CMS (View Documents)" + thrownError);
                }
            });
        });

    </script>

</html>
