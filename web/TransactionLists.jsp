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
        <title>AllBank MOS - Transactions List</title>

        <%@ include file="Includes/links.jsp" %>
        <!-- Custom styles for this page -->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>

    <body id="page-top" style="font-size: 12px;">

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
                    <c:set var="Users" value="${USERID}1"/>
                    <c:choose>
                        <c:when test="${Users == '1'}">
                            <script>
                                alert("Please Login!");
                            </script>
                        </c:when>
                        <c:otherwise>
                            <!-- Begin Page Content -->
                            <div class="container-fluid">
                                <jsp:useBean id="now" class="java.util.Date"/> 
                                <fmt:formatDate value="${now}" var="startFormat" type="date" pattern="yyyy-MM-dd"/>
                                <!-- Page Heading -->
                                <div class="card-header d-sm-flex align-items-center justify-content-between " id="headerdiv">
                                    <h2 class="h5 mb-2 text-gray-800">Transactions List   </h2> <a   onclick="ReloadTable()" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" ><i class="fas fa-refresh fa-sm text-white-50"></i> Refresh</a>


                                </div>


                                <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>

                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3 ">
                                        <sql:query dataSource = "${ALBMOSDB}" var = "resultUserInfo">
                                            EXEC GetUserInfo ${USERID}
                                        </sql:query>
                                        <c:forEach var = "rowMerchantUserInfo" items = "${resultUserInfo.rows}">
                                            <c:set var="MERCHID" value="${rowMerchantUserInfo.MERCHID}"/>
                                        </c:forEach>
                                        <div class="row" >
                                            <input type="hidden" id="Account_Number" value=""/>
                                            <input type="hidden"  id="Onboard_Type" value=""/>
                                            <input type="hidden"  id="TerminalNumber" value="0"/>
                                            <input type="hidden"  id="TerminalNumberBack" value="0"/>
                                            <div class=" col-sm-6 mb-3 mb-sm-0">
                                                <label>Unit Name</label>
                                                <select style="font-size: 12px;" class="form-control" id="UnitInfo">
                                                    <option value="">--Select Unit --</option>
                                                     <c:set var="AllTerminalsAPIBack" value="0"/>
                                                     <c:set var="AllTerminalsStaticBack" value="0"/>
                                                      <c:set var="AllTerminalsAPIFront" value="0"/>
                                                     <c:set var="AllTerminalsStaticFront" value="0"/>
                                                    <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantAccounts">
                                                        EXEC GetMerchantUnitsListNEW ${MERCHID},${USERID}
                                                    </sql:query>
                                                    <c:forEach var = "rowMerchantAccounts" items = "${resultMerchantAccounts.rows}">
                                                        <c:set var="ID" value="${rowMerchantAccounts.Unit_ID}"/>
                                                        <c:set var="UnitName" value="${rowMerchantAccounts.UnitName}"/>
                                                        <c:set var="UnitInfo" value="${rowMerchantAccounts.Acctno}"/>
                                                        <c:set var="TERMINAL_ID" value="${rowMerchantAccounts.TERMINAL_ID}"/>
                                                        <c:set var="BCH" value="${rowMerchantAccounts.BCH}"/>
                                                        <c:set var="accnt" value="${rowMerchantAccounts.accnt}"/>
                                                        <c:choose>
                                                            <c:when test="${rowMerchantAccounts.Type == '1'}">
                                                                <c:set var="AllTerminalsAPIFront" value="${AllTerminalsAPIFront}|${rowMerchantAccounts.Unit_ID}"/>
                                                                <c:set var="AllTerminalsAPIBack" value="${AllTerminalsAPIBack},${rowMerchantAccounts.Unit_ID}"/>
                                                            </c:when>
                                                            <c:when test="${rowMerchantAccounts.Type == '2'}">
                                                                <c:set var="AllTerminalsStaticFront" value="${AllTerminalsStaticFront}|${rowMerchantAccounts.Unit_ID}"/>
                                                                <c:set var="AllTerminalsStaticBack" value="${AllTerminalsStaticBack},${rowMerchantAccounts.Unit_ID}"/>
                                                            </c:when>
                                                        </c:choose>
                                                        
                                                        <option value="${UnitInfo},${TERMINAL_ID}">${UnitName} - ${TERMINAL_ID}</option>
                                                    </c:forEach>
                                                 </select>
                                            </div> 
                                            <!--
                                            <div class=" col-sm-3 mb-3 mb-sm-0">
                                                <label>Account Number</label>

                                                <select style="font-size: 12px;" class="form-control" id="Account_Number">
                                                    <option value="">--Select Account Number--</option>
                                            <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantAccounts">
                                                EXEC GetMerchantAccounts ${MERCHID}
                                            </sql:query>
                                            <c:forEach var = "rowMerchantAccounts" items = "${resultMerchantAccounts.rows}">
                                                <c:set var="ID" value="${rowMerchantAccounts.ID}"/>
                                                <c:set var="ACCTNO" value="${rowMerchantAccounts.ACCTNO}"/>
                                                <c:set var="BranchOfAccount" value="${rowMerchantAccounts.BranchOfAccount}"/>
                                                <c:set var="NO_UNITS" value="${rowMerchantAccounts.NO_UNITS}"/>
                                                <option value="${BranchOfAccount},${ACCTNO}">${BranchOfAccount}-${ACCTNO}</option>
                                            </c:forEach>


                                        </select>
                                    </div> 
                                    <div class=" col-sm-3 mb-3 mb-sm-0">
                                        <label>Type</label>
                                        <select style="font-size: 12px;" class="form-control" id="Onboard_Type">
                                            <option value="">-- Select Onboard Type--</option>
                                            <option value="0">Static</option>
                                            <option value="1">API Based</option>
                                        </select>
                                    </div>
                                            -->
                                            <div class=" col-sm-3 mb-3 mb-sm-0">
                                                <label>From</label>
                                                <input onkeydown="return false" style="font-size: 12px;" type="date" value="${startFormat}" id="min" class="form-control">
                                            </div> 
                                            <div  class=" col-sm-3 mb-3 mb-sm-0">
                                                <label>To</label>
                                                <input onkeydown="return false" style="font-size: 12px;" type="date"  value="${startFormat}" id="max" class="form-control">
                                            </div>

                                        </div>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <div id="transactionTable">
                                                <center>No Data to Display</center>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- /.container-fluid -->
                        </c:otherwise>
                    </c:choose>

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
        <!-- Page level custom scripts -->
        <script src="js/transactionlists.js"></script>
        <script>
                                                    function ReloadTable() {
                                                        $('#TransactionsDatatable').DataTable().ajax.reload();
                                                    }
        </script>
    </body>

</html>