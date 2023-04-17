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
        <title>AllBank MOS - User Maintenance</title>

        <%@ include file="Includes/links.jsp" %>
        <!-- Custom styles for this page -->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>

    <body id="page-top" height="100%">

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
                    <div class="container-fluid" id="div-userContainer">
                        <%@ include file="Includes/Loading.jsp" %>

                    </div>
                          
                    <div id="dynamicForm">
                        <form id="formredirect" action="PendingMerchant" method="POST">
                            <input hidden id="id" name="ID" >
                            <input hidden id="loc" name="LOC" >
                        </form>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
                <!-- Footer -->
                <%@ include file="Includes/footer.jsp" %>
                <!-- End of Footer -->
                <div class="modal fade" id="ConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <form id="Form-MerchantApprove">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Confirm Action </h5>
                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div  id="DisapproveDiv">
                                        <label>Remarks:</label>
                                        <textarea name="Remarks" class="form-control form-control-range" ></textarea>
                                    </div>
                                    <div  id="ApproveDiv">
                                        Please confirm action
                                    </div>
                                </div>
                                <div class="modal-footer">

                                    <input type="hidden" name="action" id="ApprovalAction" />
                                    <input type="hidden" name="MerchID" id="ApprovalMerch" value="12"/>

                                    <button class="btn btn-secondary" id="confirmbutton" type="submit" >Approve</button>

                                    <button class="btn btn-primary" data-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
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
        <!-- Bootstrap core JavaScript-->
        <%@ include file="Includes/scripts.jsp" %>

        <!-- Toaster-->  
        <script src="js/jquery.toaster.js"></script>
        <script>  $(document).ready(function () {
                if ('${requestScope.LOC}' === 'PendingMerchantInfo') {
                    LoadPendingMerchantInfo('${requestScope.ID}');
                } else if ('${requestScope.LOC}' === 'DisapprovedMerchantInfo') {
                    LoadDisapprovedMerchantInfo('${requestScope.ID}');
                } else if ('${requestScope.LOC}' === 'RejectedMerchantInfo') {
                    LoadRejectedMerchantInfo('${requestScope.ID}');
                } else {
                    LoadPendingMerchants();
                }

            });</script>
        <script src="js/pendingMerchantView.js"></script>
    </body>
</html>