<%-- 
    Document   : merchantinfo
    Created on : 01 25, 21, 11:26:06 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>

    <c:if test="${param.UserGroupID > 3 && param.UserGroupID !=8}">

        <div class="card shadow mb-4">

            <div class="card-header py-3 clear-fix">
                <h6 class="m-0 font-weight-bold text-primary">Merchant Info</h6>
            </div>
            <div class="card-body" >
                <div class="form-group row">
                    <div class="col-sm-12 mb-12 mb-sm-0">
                        <label>Merchant</label>
                        <%@ include file="/DD/MerchantsDD.jsp" %>

                    </div>
                    <hr>
                </div>
                <c:choose>
                    <c:when test="${param.UserGroupID eq 5}">
                        <div class="form-group row">
                            <div class="col-sm-12 mb-3 mb-sm-0" id='branches-div'>
                            </div>

                        </div>
                    </c:when>
                    <c:when test="${param.UserGroupID eq 6}">
                        <div class="form-group row">             
                            <div class="col-sm-6 mb-3 mb-sm-0" id='branch-div'>
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0" id='terminal-div'>
                            </div>

                        </div>           
                    </c:when>
                     <c:when test="${param.UserGroupID eq 7}">
                        <div class="form-group row">             
                            <div class="col-sm-6 mb-3 mb-sm-0" id='branch-div'>
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0" id='terminal-div'>
                            </div>

                        </div>           
                    </c:when>
                </c:choose>


            </div>

        </div>



    </c:if>
    
    <script>
        $('#MerchantDD').on('change', function () {
            if ('${param.UserGroupID}' === '5') {
                $.ajax({
                    url: 'DD/MerchantBranchDDM.jsp',
                    type: 'POST',
                    data: {MerchID: $(this).val()},
                    success: function (data) {
                        $('#branches-div').html(data);
                        $('#BranchDD').attr("required",true);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            } else if ('${param.UserGroupID}' === '6') {
                $.ajax({
                    url: 'DD/MerchantBranchDD.jsp',
                    type: 'POST',
                    data: {MerchID: $(this).val()},
                    success: function (data) {
                        $('#branch-div').html(data);
                        $('#BranchDD').attr("required",true);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
            else if ('${param.UserGroupID}' === '7') {
                $.ajax({
                    url: 'DD/MerchantBranchDD.jsp',
                    type: 'POST',
                    data: {MerchID: $(this).val(), IsMultiple:1},
                    success: function (data) {
                        $('#branch-div').html(data);
                        $('#BranchDD').attr("required",true);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }

        });
        
    </script>
</html>