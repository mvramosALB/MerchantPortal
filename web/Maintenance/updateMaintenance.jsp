<%-- 
    Document   : addMaintenance
    Created on : 03 5, 21, 10:39:13 AM
    Author     : IT-Programmer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <input type="hidden" value="2" name="action"/>
    <input type="hidden" value="${param.id}" name="mfid"/>
    <input type="hidden" value="${param.type}" name="maintenanceType"/>
    <sql:query dataSource = "${ALBMOSDB}" var = "resultMFInfo">
        EXEC GetMFInfo ${param.id},${param.type}
    </sql:query>
    <c:forEach var = "rowMFInfo" items = "${resultMFInfo.rows}">
        <c:set var="mfdescription" value="${rowMFInfo.mfdescription}"/>
    </c:forEach>
    <div class="form-group row">
        <div class="col-sm-12 mb-12 mb-sm-0">
            <label>Description</label>
            <input type="text" class="form-control form-control-range" name="description"   maxlength="20" value="${mfdescription}">
        </div>
    </div>

</html>
