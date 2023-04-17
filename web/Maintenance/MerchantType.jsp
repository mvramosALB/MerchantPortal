<%-- 
    Document   : MerchantType
    Created on : 01 7, 21, 2:34:47 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Merchant Type</h1>
    <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header d-sm-flex align-items-center justify-content-between mb-4">
            <h6 class="m-0 font-weight-bold text-primary">List</h6>
            <a onclick="AddMaintenance('TYPE')"class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"  data-toggle="modal" data-target="#AddMaintenanceModal"><i
                    class="fas fa-plus-square fa-sm text-white-50"></i> Add Type</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered MFDatatable" id="MerchantTypeDatatable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Action</th>       
                        </tr>
                    </thead>

                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>
        $('#MerchantTypeDatatable').DataTable({

            "processing": true,
            "bPaginate": true,
            "responsive": true,
            "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]],
            "order": [0, 'asc'],
            "bInfo": true,
            "iDisplayStart": 0,
            "serverSide": true,
            "sAjaxSource": "MerchantTypeDatatables",
            "sServerMethod": "POST",
            "fnCreatedRow": function (nRow, aData, iDataIndex) {
                //  $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'IncidentTypeSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#IncidentTypeModal");
            },
            "fnServerParams": function (aoData)
            {
                //aoData.push({"name": "Status", "value": "" + $('#Status').val() + ""});
            },
            "aoColumns": [
                {
                    "mData": 0,
                    "bVisible": true,
                    "className": "all"
                }, {
                    "mData": 1,
                    "bVisible": true,
                    "className": "all"
                }, {
                    "mData": 2,
                    "bVisible": true,
                    "className": "all"
                }, {
                    "mData": null,
                    "bSortable": false,
                    "className": "all",
                    "mRender": function (data, type, full) {
                        var functionOnclick1 = "EditMF('TYPE','" + full[0] + "')";//view
                        var functionOnclick2 = "DisableDisableMF('TYPE','" + full[0] + "')";//disable
                        var functionOnclick3 = "EnableMF('TYPE','" + full[0] + "')";//enable
                        var returnString = '';
                        if (full[2] === 'Active') {
                            returnString = '<center><div class="btn-group">\n\
                        <button type="button" class="btn  btn-danger btn-sm rm-edit_modal"  onclick="' + functionOnclick2 + '"><i class="fa  fa-lock"></i></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view"  data-toggle="modal" data-target="#UpdateMaintenanceModal"  onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                        } else if (full[2] === 'Inactive') {
                            returnString = '<center><div class="btn-group">\n\
                        <button type="button" class="btn btn-success btn-sm rm-edit_modal"  onclick="' + functionOnclick3 + '"><i class="fa fa-unlock"></i></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view"  data-toggle="modal" data-target="#UpdateMaintenanceModal" onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                        } else {
                            returnString = '';
                        }

                        return returnString;

                    }
                }]
        });
    </script>
</html>
