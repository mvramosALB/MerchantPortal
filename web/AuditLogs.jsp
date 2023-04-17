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
        <title>AllBank MOS - Audit Logs</title>
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
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">Audit Logs</h1>
                        <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>

                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">History</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class=" col-sm-3 mb-3 mb-sm-0">
                                        <label>From</label>
                                        <input type="date" id="min" class="form-control">
                                    </div> 
                                    <div class=" col-sm-3 mb-3 mb-sm-0">
                                        <label>To</label>
                                        <input type="date" id="max" class="form-control">
                                    </div>

                                </div>
                                <div class="table-responsive">

                                    <br>
                                    <table class="table table-bordered" id="AuditLogsDatatable" width="100%" cellspacing="0" style="font-size: 12px;">
                                        <thead>
                                            <tr>
                                                <th>Log ID</th>
                                                <th>Log Type</th>
                                                <th>Action</th>
                                                <th>Description</th>
                                                <th>Source</th>
                                                <th>Log Date</th>
                                                <th>User</th>
                                                <th>Employee Name</th>
                                                <th>IP</th>
                                                <th>Remarks</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
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
        <<%@ include file="Includes/scripts.jsp" %>
        <!-- Page level custom scripts -->
        <script src="js/auditLogs.js"></script>
        <script>

        </script>

    </body>

</html>