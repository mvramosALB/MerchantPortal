<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select required class="form-control" name="MerchClass" id='MerchantClassDD' value="${MerchantClassID}">
        <option value="">--Select Merchant Class--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultMerchantClass">
            EXEC DDMerchantClass
        </sql:query>
        <c:forEach var = "rowMerchantClass" items = "${resultMerchantClass.rows}">
            <c:set var="DDID" value="${rowMerchantClass.DDID}"/>
            <c:set var="DDDescription" value="${rowMerchantClass.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>
    </select>
        
</html>
