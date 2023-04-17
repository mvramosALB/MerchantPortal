<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select required class="form-control" name="RateType" id='RateTypeDD' value="${RateTypeID}">
        <option value="">--Select Rate Type--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultRateType">
            EXEC DDRateType
        </sql:query>
        <c:forEach var = "rowRateType" items = "${resultRateType.rows}">
            <c:set var="DDID" value="${rowRateType.DDID}"/>
            <c:set var="DDDescription" value="${rowRateType.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>
    </select>
</html>
