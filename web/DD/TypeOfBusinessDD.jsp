<%-- 
    Document   : MerchantDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select required class="form-control" name="TypeOfBusiness" id='TypeOfBusinessDD' value="${TypeOfBusinessID}">
        <option value="">--Select Type of Business--</option>
        
        <sql:query dataSource = "${ALBMOSDB}" var = "resultTypeOfBusiness">
            EXEC DDTypeOfBusiness
        </sql:query>
        <c:forEach var = "rowTypeOfBusiness" items = "${resultTypeOfBusiness.rows}">
            <c:set var="DDID" value="${rowTypeOfBusiness.DDID}"/>
            <c:set var="DDDescription" value="${rowTypeOfBusiness.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
           
        </c:forEach>
    </select>
</html>
