<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<script>alert('${param.from} - ${param.to}')</script>
<c:choose>
    <c:when test="${param.from < param.to}">
        <script>alert('Less Than')</script>
        <c:forEach begin="${param.from}+1" end="${param.NoTerminals}" var="loop">
            <script>alert('Adding ${loop}')</script>
            <tr id="Branch${BranchIDNo}Terminal${loop}">
                <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail" placeholder=""></td>
                <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail" placeholder=""></td>
                <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail" placeholder=""></td>

            </tr>
        </c:forEach>
    </c:when>
    <c:when test="${param.from > param.to}">
        <script>alert('Greater Than')</script>
        <c:forEach begin="${param.to}+1" end="${param.from}" var="loop">
            <script>alert('removing ${loop}')</script>
            <script>

                $('#Branch${BranchIDNo}Terminal${loop}').remove();
            </script>
        </c:forEach>
    </c:when>
    <c:when test="${param.from == param.to}">
        <script>alert('equal')</script>
        ${param.from} - ${param.to} -

    </c:when>
    <c:otherwise>
        <script>alert('unknown')</script>
        ${param.from} - ${param.to}
    </c:otherwise>
</c:choose>



