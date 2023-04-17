<%-- 
    Document   : AddNewAccount
    Created on : 02 17, 21, 6:33:37 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <div class="form-group row NewAccountDiv_${param.AccountNo}" >
        <div class="col-sm-12 mb-12 mb-sm-0">
               <hr>
        </div>
     
    </div>
    <div class="form-group row NewAccountDiv_${param.AccountNo}" >
        
        <input style="display:none" name="AccountsNewIds" value="${param.AccountNo}">
        <div class="col-sm-4 mb-3 mb-sm-0">
            <label>Depository Branch</label>
            <select class="form-control form-control-range" id="ADepositoryBranch${param.AccountNo}New" name="ADepositoryBranchNew">
                <option>--Select Branch--</option>     
                <sql:query dataSource = "${ALBMOSDB}" var = "resultBOA">
                    EXEC DDBranchOfAccount
                </sql:query>
                <c:forEach var = "rowBOA" items = "${resultBOA.rows}">
                    <c:set var="DDID" value="${rowBOA.DDID}"/>
                    <c:set var="DDDescription" value="${rowBOA.DDDescription}"/>
                    <option value='${DDID}'>${DDDescription}</option>
                </c:forEach>      
            </select>
        </div>
        <div class="col-sm-4 mb-3 mb-sm-0">
            <label>Account Number</label>
            <input required type="text" class="form-control form-control-range accountnumber" name="AAccountNumberNew" id="AAccountNumber${param.AccountNo}" placeholder="ex. 20-00001-2">
        </div>

        <div class="col-sm-2 mb-2 mb-sm-0">
            <label>No. of Units</label>
            <input required type="number" min="1" class="form-control form-control-range ANoUnitsNew"  name="ANoUnitsNew" id="ANoUnits${param.AccountNo}" placeholder="ex. 1" onchange="AddUnit('${param.AccountNo}')"  value="0">
            <input type="hidden" id="ANoUnits${param.AccountNo}Current" value="0"/>
            <input type="hidden" id="ANoUnits${param.AccountNo}New" value="0"/>
        </div>
        <div class="col-sm-2 mb-2 mb-sm-0">
            <label>Action</label>
            <button class="btn btn-block btn-danger" type="button" onclick="removeAccount('${param.AccountNo}')">Remove</button>    
        </div>
        <div class="col-sm-12 mb-12 mb-sm-0 unitsTable${param.AccountNo}" style="display:none" >
            <br>
            <label>Units</label>
            <table width="100%">
                <thead class="text-center">
                    <tr>
                        <th>Unit Name</th>
                        <th>Type</th>
                        <th>Terminal ID (if applicable)</th>
                        <th>Mobile Number</th>
                    </tr>
                </thead>
                <tbody id="UnitTableBodyBranch${param.AccountNo}">
               </tbody>
            </table>
        </div>

    </div>
    <script>
        $('.accountnumber').mask('00-00000-0');
         $('.ANoUnitsNew').on('keyup', function () {
            if ($(this).val() < 0) {
                $(this).val(0);
            }
        });
    </script>
</html>
