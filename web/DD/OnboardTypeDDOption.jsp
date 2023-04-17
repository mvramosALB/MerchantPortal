<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
      <option value="">--Select Onboarding Type--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultOnboardType">
            EXEC DDOnboardType
        </sql:query>
        <c:forEach var = "rowOnboardType" items = "${resultOnboardType.rows}">
            <c:set var="DDID" value="${rowOnboardType.DDID}"/>
            <c:set var="DDDescription" value="${rowOnboardType.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>

</html>
