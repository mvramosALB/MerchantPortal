<%-- 
    Document   : BranchDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <label>Accounts</label>
    <select required class="form-control BranchDD" name="Branch" id='BranchDD' multiple value="${BranchID}">
        <sql:query dataSource = "${ALBMOSDB}" var = "resultBranch">
            EXEC DDMerchantsBranch ${param.MerchID}
        </sql:query>
        <c:forEach var = "rowBranch" items = "${resultBranch.rows}">
            <c:set var="DDID" value="${rowBranch.DDID}"/>
            <c:set var="DDDescription" value="${rowBranch.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
        </c:forEach>
        
    </select>
</html>
