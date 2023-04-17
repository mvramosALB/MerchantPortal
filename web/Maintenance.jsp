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
        <title>AllBank MOS - Maintenance</title>

        <%@ include file="Includes/links.jsp" %>
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
                    <div class="container-fluid" id="Content-Div">

                    </div>
                    <!--Add Modal-->
                    <div class="modal fade" id="AddMaintenanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" >Add Modal</h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="AddMaintenanceModal_Form"> 
                                        <div id="AddMaintenanceModal_content">

                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                    <button class="btn btn-primary" onclick="SubmitAddMaintenance();">Add</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Update Modal-->
                    <div class="modal fade" id="UpdateMaintenanceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" >Update Modal</h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="UpdateMaintenanceModal_Form"> 
                                        <div id="UpdateMaintenanceModal_content">

                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                    <button class="btn btn-primary" onclick="SubmitUpdateMaintenance();">Update</button>
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
        <script>
            function refreshTables() {
                $('.MFDatatable').DataTable().ajax.reload();
            }
            function AddMaintenance(Type) {

                $.ajax({
                    url: 'Maintenance/addMaintenance.jsp',
                    type: 'POST',
                    data: {type: Type},
                    success: function (data) {
                        $('#AddMaintenanceModal_content').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
            $.ajax({
                url: 'Maintenance/${requestScope.ID}.jsp',
                type: 'POST',
                data: {dummy: null},
                success: function (data) {
                    $('#Content-Div').html(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  CMS (View Documents)" + thrownError);
                }
            });
            function SubmitAddMaintenance() {
                $('#AddMaintenanceModal_Form').submit();
            }
            $('#AddMaintenanceModal_Form').submit(function (e) {
                var returnmess = "", title = "", color = "", mess = "", userid = "";
                var form = $(this);
                var dataArray = $(form).serializeArray();
                $.ajax({
                    url: 'UpdateMaintenance',
                    type: 'POST',
                    data: dataArray,
                    success: function (data) {
                        returnmess = data.split(";;");
                        title = returnmess[0];
                        color = returnmess[1];
                        mess = returnmess[2];
                        var MFtype = returnmess[2];

                        $.toaster({message: mess, title: title, priority: color});
                        if (title === "Alert") {
                            //$("#form-logIn")[0].reset();
                        } else if (title === "Success") {
                            $('#AddMaintenanceModal').modal('toggle');
                            refreshTables();

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error! Change Password (New Password)" + thrownError);
                    }
                });
                e.preventDefault();
            });

            function SubmitUpdateMaintenance() {
                $('#UpdateMaintenanceModal_Form').submit();
            }
            $('#UpdateMaintenanceModal_Form').submit(function (e) {
                var returnmess = "", title = "", color = "", mess = "", userid = "";
                var form = $(this);
                var dataArray = $(form).serializeArray();
                $.ajax({
                    url: 'UpdateMaintenance',
                    type: 'POST',
                    data: dataArray,
                    success: function (data) {
                        returnmess = data.split(";;");
                        title = returnmess[0];
                        color = returnmess[1];
                        mess = returnmess[2];
                        var MFtype = returnmess[2];
                        $.toaster({message: mess, title: title, priority: color});
                        if (title === "Alert") {
                            //$("#form-logIn")[0].reset();
                        } else if (title === "Success") {
                            $('#UpdateMaintenanceModal').modal('toggle');
                            refreshTables();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error! Change Password (New Password)" + thrownError);
                    }
                });
                e.preventDefault();
            });

            function EditMF(type, ID) {
                $.ajax({
                    url: 'Maintenance/updateMaintenance.jsp',
                    type: 'POST',
                    data: {type: type, id: ID},
                    success: function (data) {
                        $('#UpdateMaintenanceModal_content').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }

            function DisableDisableMF(type, ID) {
                $.ajax({
                    url: 'UpdateMaintenance',
                    type: 'POST',
                    data: {action: "4", maintenanceType: type, id: ID},
                    success: function (data) {
                        refreshTables();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
             function EnableMF(type, ID) {
                $.ajax({
                    url: 'UpdateMaintenance',
                    type: 'POST',
                    data: {action: "3", maintenanceType: type, id: ID},
                    success: function (data) {
                        refreshTables();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }



        </script>
    </body>

</html>