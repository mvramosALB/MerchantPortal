
<%-- 
    Document   : TerminalDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <label>Unit</label>
    <select required class="form-control" name="Terminal" id='TerminalDD' multiple value="${TerminalID}">
        <option value="">--Select Unit--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultTerminal">
            EXEC DDMerchantsTerminal ${param.MerchID},${param.BranchID} 
        </sql:query>
        <c:forEach var = "rowTerminal" items = "${resultTerminal.rows}">
            <c:set var="DDID" value="${rowTerminal.DDID}"/>
            <c:set var="DDDescription" value="${rowTerminal.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
        </c:forEach>
    </select>
</html>
