<%-- 
    Document   : UserGroupDD
    Created on : 01 25, 21, 10:53:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <select class="form-control" name="UserGroup" id='UserGroupDD' value="${UserGroupID}">
        <option value="">--Select User Group--</option>
        <sql:query dataSource = "${ALBMOSDB}" var = "resultUserGroup">
            EXEC DDUserGroup '${USERGROUP}'
        </sql:query>
        <c:forEach var = "rowUserGroup" items = "${resultUserGroup.rows}">
            <c:set var="DDID" value="${rowUserGroup.DDID}"/>
            <c:set var="DDDescription" value="${rowUserGroup.DDDescription}"/>
            <option value='${DDID}'>${DDDescription}</option>
        </c:forEach>
     </select>
</html>
