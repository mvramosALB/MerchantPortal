<%-- 
    Document   : AddNewBranch
    Created on : 01 7, 21, 11:05:20 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <hr>

    <div class="form-group row">
        <div class="col-sm-5 mb-3 mb-sm-0">
            <label>Branch Name</label>
            <input type="text" class="form-control form-control-range" name="BbranchNameNew" id="BbranchName${param.BranchNo}" placeholder="ex. Main Branch">
        </div>
        <div class="col-sm-5 mb-3 mb-sm-0">
            <label>Registered Address</label>
            <input type="text" class="form-control form-control-range" name="BRegisteredAddressNew" id="BRegisteredAddress${param.BranchNo}" placeholder="ex. Mandaluyong City">
        </div>
        <div class="col-sm-2 mb-2 mb-sm-0">
            <label>No. of Terminals</label>
            <input type="number" min="0" class="form-control form-control-range" name="BNoTerminalsNew" id="BNoTerminals${param.BranchNo}" placeholder="ex. 1" onchange="AddTerminal('${param.BranchNo}')" value='0'>
            <input type="hidden" id="BNoTerminals${param.BranchNo}Current" value="0"/>
            <input type="hidden" id="BNoTerminals${param.BranchNo}New" value="0"/>
        </div>
        <div class="col-sm-12 mb-12 mb-sm-0">
            <br>
            <label>Terminals</label>
            <table width="100%">
                <thead class="text-center">
                    <tr>
                        <th>Terminal ID</th>
                        <th>Type</th>
                        <th>Telco Provider</th>
                    </tr>
                </thead>
                <tbody id="TerminalTableBodyBranch${param.BranchNo}">


                </tbody>
            </table>
        </div>

    </div>
</html>
