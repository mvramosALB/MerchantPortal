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
                    <div class="container-fluid" id="div-userContainer">


                    </div>
                    <div id="dynamicForm">
                        <form id="formredirect" action="UserInfo" method="POST">
                            <input hidden id="id" name="ID" >
                        </form>
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
            $(document).ready(function () {
                if ('${requestScope.LOC}' === 'UsersInfo') {
                    LoadUser('${requestScope.ID}');
                } else {
                    LoadUserMaintenance();
                }
            });
        </script>
        <script src="js/users.js"></script>
    </body>

</html>