<%-- 
    Document   : BranchDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <label>Account</label>
    <select required class="form-control BranchDD" name="Branch" id='BranchDD' value="${BranchID}" >
        <option value="">--Select Account--</option>
        <sql:query dataSource = "${ALBMOSDB}" var = "resultBranch">
            EXEC DDMerchantsBranch ${param.MerchID}
        </sql:query>
        <c:forEach var = "rowBranch" items = "${resultBranch.rows}">
            <c:set var="DDID" value="${rowBranch.DDID}"/>
            <c:set var="DDDescription" value="${rowBranch.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
        </c:forEach>
    </select>
    <c:choose>
        <c:when test="${param.IsMultiple == 1}">
            <script>
        $('#BranchDD').on('change', function () {
            $.ajax({
                url: 'DD/MerchantTerminalDDM.jsp',
                type: 'Get',
                data: {MerchID: '${param.MerchID}', BranchID: $(this).val()},
                success: function (data) {
                    $('#terminal-div').html(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  CMS (View Documents)" + thrownError);
                }
            });
        });
    </script>
        </c:when>
        <c:otherwise>
            <script>
        $('#BranchDD').on('change', function () {
            $.ajax({
                url: 'DD/MerchantTerminalDD.jsp',
                type: 'Get',
                data: {MerchID: '${param.MerchID}', BranchID: $(this).val()},
                success: function (data) {
                    $('#terminal-div').html(data);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  CMS (View Documents)" + thrownError);
                }
            });
        });
    </script>
        </c:otherwise>
    </c:choose>        
    
</html>
