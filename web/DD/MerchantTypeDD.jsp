<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select required class="form-control" name="MerchType" id='MerchantTypeDD' value="${MerchantTypeID}">
        <option value="">--Select Merchant Type--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantType">
            EXEC DDMerchantType
        </sql:query>
        <c:forEach var = "rowMerchantType" items = "${resultMerchantType.rows}">
            <c:set var="DDID" value="${rowMerchantType.DDID}"/>
            <c:set var="DDDescription" value="${rowMerchantType.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>
    </select>
</html>
