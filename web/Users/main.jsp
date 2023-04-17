<%-- 
    Document   : main
    Created on : 01 25, 21, 10:40:11 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">User Maintenance</h1>
    <p class="mb-4"><a target="_blank" href="https://datatables.net"></a></p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header d-sm-flex align-items-center justify-content-between mb-4">
            <h6 class="m-0 font-weight-bold text-primary">Users List</h6>
            <a onclick="LoadAddUser()"class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                    class="fas fa-plus-square fa-sm text-white-50"></i> Add User</a>

        </div>
        <div class="card-body">


            <div class="table-responsive">
                <table class="table table-bordered" id="UsersDatatables" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Name of User</th>
                            <th>Username</th>
                            <th>User Group</th>
                            <th>Merchant</th>
                            <th>Status</th>
                            <th>Last Login</th>
                            <th>Created By</th>
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
        function ViewUser(id) {
            //  window.location.href = "Users.jsp?LOC=UsersInfo&ID=" + id;
        $('#id').val(id);   
        $('#formredirect').submit();
           
        }
        function DisableUser(id) {
            var returnmess = "", title = "", color = "", mess = "", userid = "";

            $.ajax({
                url: 'UserStatusUpdate', // use original page here
                type: 'post',
                data: {action: "0", id: id},
                success: function (data) {
                   
                    returnmess = data.split(";;");
                    title = returnmess[0];
                    color = returnmess[1];
                    mess = returnmess[2];
                    $.toaster({message: mess, title: title, priority: color});
                     $('#UsersDatatables').DataTable().ajax.reload();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Scripts (DisableUser)" + thrownError);
                }

            });
        }
        function EnableUser(id) {
            var returnmess = "", title = "", color = "", mess = "", userid = "";

            $.ajax({
                url: 'UserStatusUpdate', // use original page here
                type: 'post',
                data: {action: "1", id: id},
                success: function (data) {
                   returnmess = data.split(";;");
                    title = returnmess[0];
                    color = returnmess[1];
                    mess = returnmess[2];
                    $.toaster({message: mess, title: title, priority: color});
                    $('#UsersDatatables').DataTable().ajax.reload();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Scripts (DisableUser)" + thrownError);
                }

            });
        }
        $(document).ready(function () {
            $('#UsersDatatables').DataTable({
                

                    dom: '<"top"Bf>rt<"bottom"lip>',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            title: 'Users List ',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            extend: 'csvHtml5',
                            title: 'Users List ',
                            exportOptions: {
                                columns: ':visible'
                            }
                        }, {
                            extend: 'print',
                            exportOptions: {
                                columns: ':visible'
                            }
                        }, 'colvis'
                    ],
                "processing": true,
                "bPaginate": true,
                "responsive": true,
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]],
                "order": [0, 'asc'],
                "bInfo": true,
                "iDisplayStart": 0,
                "serverSide": true,
                "sAjaxSource": "UsersDatatables",
                "sServerMethod": "POST",
                "fnCreatedRow": function (nRow, aData, iDataIndex) {
                    //   $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'DocSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#modal-clinichour");
                },
                "fnServerParams": function (aoData)
                {
                    aoData.push({"name": "ID", "value": "${USERGROUP}"});

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
                        "mData": 7,
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
                        "mData": null,
                        "bSortable": false,
                        "className": "all",
                        "mRender": function (data, type, full) {
                            ///                                 ID      NewStatus     
                            var functionOnclick1 = "ViewUser('" + full[0] + "')";//view
                            var functionOnclick2 = "DisableUser('" + full[0] + "')";//disable
                            var functionOnclick3 = "EnableUser('" + full[0] + "')";//enable
                            var returnString = '';
                            if (full[4] === 'Active') {
                                returnString = '<center><div class="btn-group">\n\
                        <button type="button" class="btn  btn-danger btn-sm rm-edit_modal"  onclick="' + functionOnclick2 + '"><i class="fa  fa-lock"></i></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view"  onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                            } else if (full[4] === 'Inactive') {
                                returnString = '<center><div class="btn-group">\n\
                        <button type="button" class="btn btn-success btn-sm rm-edit_modal"  onclick="' + functionOnclick3 + '"><i class="fa fa-unlock"></i></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view" onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                            } else {
                                returnString = '';
                            }

                            return returnString;

                        }
                    }]
            });
        });

    </script>

</html>
