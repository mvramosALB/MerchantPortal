<%-- 
    Document   : Transactions
    Created on : 03 9, 21, 1:57:42 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <head>

    </head>
    <body>
        <div class="col-12">
            <jsp:useBean id="now" class="java.util.Date"/> 
            <fmt:formatDate value="${now}" var="startFormat" type="date" pattern="yyyy-MM-dd"/>
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h4><small>Transactions List</small></h4><a   onclick="ReloadTable()" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" ><i class="fas fa-refresh fa-sm text-white-50"></i> Refresh</a>
                       
            </div>
            <div class="card shadow ">
                <div class="card-header py-3 ">
                    <sql:query dataSource = "${ALBMOSDB}" var = "resultUserInfo">
                        EXEC GetMerchantUnitInfo ${param.UnitID}
                    </sql:query>
                    <c:forEach var = "rowMerchantUserInfo" items = "${resultUserInfo.rows}">
                        <c:set var="UnitName" value="${rowMerchantUserInfo.UnitName}"/>
                        <c:set var="Acctno" value="${rowMerchantUserInfo.Acctno}"/>
                        <c:set var="Type" value="${rowMerchantUserInfo.Type}"/>

                    </c:forEach>

                    <div class="row" >
                        <input type="hidden" id="Account_Number" value=""/>
                        <input type="hidden"  id="Onboard_Type" value=""/>
                            <input type="hidden"  id="TerminalNumber" value="${param.TerminalID}"/>
                            <input type="hidden"  id="TerminalNumberBack" value="${param.TerminalID}"/>
                                        
                        <div class=" col-sm-6 mb-3 mb-sm-0">
                            <label>Unit Name</label>

                            <select style="font-size: 12px;" class="form-control" id="UnitInfo">
                                <option value="${Acctno}">${UnitName}</option>
                            </select>
                        </div> 

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
    </body>
    <script>
        function ReloadTable() {
            $('#TransactionsDatatable').DataTable().ajax.reload();
        }
        $(document).ready(function () {
          
            $('#min').change(function () {
                $('#TransactionsDatatable').DataTable().ajax.reload();
            });
            $('#max').change(function () {
                $('#TransactionsDatatable').DataTable().ajax.reload();
            });
            getParams();
            CheckParamsValidity();

            function getParams() {
               // alert("2");
                var UnitInfo = $('#UnitInfo').val();
                var UnitInfoDatas = UnitInfo.split(",");
                var obtype = '';
                $('#Account_Number').val(UnitInfoDatas[0] + ',' + UnitInfoDatas[1]);
                if (UnitInfoDatas[2] === '2') {
                    obtype = '0';
                }else{
                    obtype=UnitInfoDatas[2];
                }
                $('#Onboard_Type').val(obtype);
            }

            function CheckParamsValidity() {
                var obt = $('#Onboard_Type').val();
                var acn = $('#Account_Number').val();

                if (obt === '' || acn === '') {
                    if (obt === '') {
                        //   alert('Please Select On-board Type');
                    } else {
                        //  alert('Please Select Account Number');
                    }
                } else {
                    GetTransaction(obt);
                }

            }

            function GetTransaction(tr_type) {
               // alert(tr_type)
                $.ajax({
                    url: 'Transactions/MerchantTransactions.jsp',
                    type: 'Post',
                    data: {TransactionType: tr_type},
                    success: function (data) {
                        $('#transactionTable').html(data);
                        $('#TransactionsDatatable').DataTable().ajax.reload();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }




        });
    </script>
</html>
