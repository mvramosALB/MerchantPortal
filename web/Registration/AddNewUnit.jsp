<%-- 
    Document   : AddNewUnit
    Created on : 02 17, 21, 6:34:47 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<tr id="Branch' + Branchid + 'Terminal' + i + '">' +
                            '<td> <input type="number" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalIDNew" id="Branch' + Branchid + 'TerminalID' + i + '" placeholder=""></td>' +
                            '<td> <input type="Text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTypeNew" id="Branch' + Branchid + 'TerminalType' + i + '" placeholder=""></td>' +
                            '<td> <input type="text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTelcoNew" id="Branch' + Branchid + 'TerminalTelco' + i + '" placeholder=""></td>' +
                            '</tr>

