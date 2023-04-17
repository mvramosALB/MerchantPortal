

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
        <title>AllBank MOS - Onboard</title>
        <link rel="stylesheet" href="css/plugins/dropzone.css">

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
                    <div id="dynamicForm">
                        <form id="formredirect" action="RejectedDisapprovedMerchant" method="POST">
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

                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Confirm Action </h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div  id="DisapproveDiv">
                                    <label>Remarks:</label>
                                    <textarea id="remarks" name="Remarks" class="form-control form-control-range" ></textarea>
                                </div>
                                <div  id="ApproveDiv">
                                    Please confirm action
                                </div>
                            </div>
                            <div class="modal-footer">

                                <input type="hidden" name="action" id="ApprovalAction" />
                                <input type="hidden" name="MerchID" id="ApprovalMerch" value="12"/>

                                <button class="btn btn-secondary" type="button" onclick="SubmitEditedMerchant()" >Submit</button>

                                <button class="btn btn-primary" data-dismiss="modal">Cancel</button>
                            </div>

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

        <!-- Bootstrap core JavaScript-->
        <%@ include file="Includes/scripts.jsp" %>

        <!-- Toaster-->  
        <script src="js/jquery.toaster.js"></script>
        <script src="js/plugins/dropzone.js"></script>
        <script>
                                    $(document).ready(function () {
                                        if ('${requestScope.LOC}' === 'PendingMerchantInfo') {
                                            LoadPendingMerchantInfo('${requestScope.ID}');

                                        } else if ('${requestScope.LOC}' === 'DisapprovedMerchantInfo') {
                                            LoadDisapprovedMerchantInfo('${requestScope.ID}');
                                            $('#extra1').show();
                                        } else if ('${requestScope.LOC}' === 'RejectedMerchantInfo') {
                                            LoadRejectedMerchantInfo('${requestScope.ID}');

                                        } else {
                                            LoadPendingMerchants();
                                        }

                                    });
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

                                                if (KBUploader.files.length < 1) {
                                                    //$.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});
                                                    KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                                    window.location.href = "dashboard.jsp";
                                                } else {
                                                    KBUploader.processQueue(); // Tell Dropzone to process all queued files.
                                                }
                                            });
                                            this.on("addedfile", function () {
                                                $('#newattachments').val(KBUploader.files.length);
                                                $('#newattachments2').text('Add New Attachmen (' + KBUploader.files.length + ' new )');
                                                $('#submit-allcontractfile').show();
                                            });
                                            this.on("success", function () {
                                                KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                                window.location.href = "dashboard.jsp";
                                                //   $.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});
                                            });
                                        }
                                    };
        </script>
        <script src="js/RejectedDisapprovedMerchant.js"></script>
    </body>
</html>