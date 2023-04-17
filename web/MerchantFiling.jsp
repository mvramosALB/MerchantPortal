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
        <link rel="stylesheet" href="css/plugins/dropzone.css">
        <title>AllBank MOS - Registration</title>
        <%@ include file="Includes/links.jsp" %>
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
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Add Merchant Account for ${requestScope.Type}</h1>
                        </div>
                        <!-- Content Row -->
                        <div  id="Content-Div">
                            <div>  <%@ include file="Includes/Loading.jsp" %>
                            </div>
                        </div>
                        <div class="col-lg-12" id="extra1" style="display: none">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Accordion -->
                                <a href="#collapseCardAttachements" class="d-block card-header py-3" data-toggle="collapse"
                                   role="button" aria-expanded="true" aria-controls="collapseCardExample">
                                    <h6 class="m-0 font-weight-bold text-primary">Attachments</h6>
                                </a>
                                <!-- Card Content - Collapse -->
                                <div class="collapse show" id="collapseCardAttachements">
                                    <div class="card-body">
                                        <form action="UploadAttachements" class="dropzone" id="KBUploader">
                                            <input hidden name="MERCHID" ID="attachment_MERCHID">
                                        </form>
                                        <button hidden type="button" id="KBFileUploadBTN"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 extra" id="extra2" style="display: none">

                            <button onclick="SubmitRegisterMerchant()" class="btn btn-primary btn-user btn-block">
                                Register Account
                            </button>

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
        <script src="js/plugins/dropzone.js"></script>
        <script>

                                $.ajax({
                                    url: 'Registration/${requestScope.Type}Form.jsp',
                                    type: 'POST',
                                    data: {ServiceType: '${requestScope.Type}'},
                                    success: function (data) {
                                        $('#Content-Div').html(data);
                                        $('#extra1').show();
                                        $('#extra2').show();


                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        console.log("Error!  CMS (View Documents)" + thrownError);
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
                                                //  $.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});
                                                KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                                window.location.href = "dashboard.jsp";
                                            } else {
                                                KBUploader.processQueue(); // Tell Dropzone to process all queued files.
                                            }
                                        });
                                        this.on("addedfile", function () {
                                            $('#submit-allcontractfile').show();
                                        });
                                        this.on("success", function () {
                                            KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                            $.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});
                                            window.location.href = "dashboard.jsp";
                                        });

                                    }
                                };
        </script>
        <script src="js/MerchantFiling.js"></script>

    </body>

</html>