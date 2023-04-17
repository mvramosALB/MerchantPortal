<%-- 
    Document   : main
    Created on : 01 25, 21, 10:40:11 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Disapprove/Rejected Merchants/Partners</h1>
    <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header d-sm-flex align-items-center justify-content-between mb-4">
            <h6 class="m-0 font-weight-bold text-primary">List</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="datatable" width="100%" cellspacing="0" style="font-size: 12px;">
                    <thead>
                        <tr>
                            <th>Partner Name</th>
                            <th>Merchant Type</th>
                            <th>Rate Type</th>
                            <th>Rate Value</th>
                            <th>QR Expiration</th>
                            <th>Disapprove/Rejected By</th>
                            <th>Disapprove/Rejected Date</th>
                            <th>Reason</th>
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
        function ViewMerchant(id, viewoption) {
            if (viewoption === '0') {
                //  alert("check rejected")
              //  window.location.href = "RejectedDisapprovedMerchant.jsp?LOC=RejectedMerchantInfo&ID=" + id;
                $('#id').val(id);
                $('#loc').val("RejectedMerchantInfo");
                $('#formredirect').submit();
            } else if (viewoption === '2') {
                //  alert("check disapproved")
               // window.location.href = "RejectedDisapprovedMerchant.jsp?LOC=DisapprovedMerchantInfo&ID=" + id;
                $('#id').val(id);
                $('#loc').val("DisapprovedMerchantInfo");
                $('#formredirect').submit();
            } else {
                // alert(viewoption)
            }

        }
        $(document).ready(function () {
            $('#datatable').DataTable({
                "processing": true,
                "bPaginate": true,
                "responsive": true,
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]],
                "order": [0, 'asc'],
                "bInfo": true,
                "iDisplayStart": 0,
                "serverSide": true,
                "sAjaxSource": "RejectedDisapprovedMerchantDatatables",
                "sServerMethod": "POST",
                "fnCreatedRow": function (nRow, aData, iDataIndex) {
                    //   $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'DocSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#modal-clinichour");
                },
                "fnServerParams": function (aoData)
                {
                    aoData.push({"name": "ProcessStatus", "value": $('#ProcessStatus').val()});
                },
                "aoColumns": [{
                        "mData": 1,
                        "bVisible": true
                    }, {
                        "mData": 2,
                        "bVisible": true
                    }, {
                        "mData": 3,
                        "bVisible": true
                    }, {
                        "mData": 4,
                        "bVisible": true
                    }, {
                        "mData": 5,
                        "bVisible": true
                    }, {
                        "mData": 6,
                        "bVisible": true
                    }, {
                        "mData": 7,
                        "bVisible": true
                    }, {
                        "mData": 8,
                        "bVisible": true
                    }, {
                        "mData": null,
                        "bSortable": false,
                        "className": "all",
                        "mRender": function (data, type, full) {
                            var textcolor = "text-primary"

                            var returnString = '';

                            if (full[9] === 'Rejected') {
                                textcolor = "text-danger"
                            } else if (full[9] === 'Disapproved') {
                                textcolor = "text-warning"
                            }
                            returnString = '<center><p class="' + textcolor + '">' + full[9] + '</p></center>';

                            return returnString;

                        }
                    }, {
                        "mData": null,
                        "bSortable": false,
                        "className": "all",
                        "mRender": function (data, type, full) {
                            var functionOnclick1 = "ViewMerchant('" + full[0] + "','0')";//view
                            var functionOnclick2 = "ViewMerchant('" + full[0] + "','2')";//edit
                            var returnString = '';

                            if (full[9] === 'Rejected') {
                                returnString = '<center><div class="btn-group"></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view" onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                            } else if (full[9] === 'Disapproved') {

                                returnString = '<center><div class="btn-group"></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view" onclick="' + functionOnclick2 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                            }

                            return returnString;

                        }
                    }]
            });
        });

    </script>

</html>
