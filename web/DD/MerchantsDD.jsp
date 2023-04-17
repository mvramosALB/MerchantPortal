<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select required class="form-control" name="Merchant" id='MerchantDD' value="${MerchantID}">
        <option value="">--Select Merchant--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchant">
            EXEC DDMerchants
        </sql:query>
        <c:forEach var = "rowMerchant" items = "${resultMerchant.rows}">
            <c:set var="DDID" value="${rowMerchant.DDID}"/>
            <c:set var="DDDescription" value="${rowMerchant.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>
        
    </select>
</html>
