/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



            $(document).ready(function () {
                $('#AuditLogsDatatable').DataTable({
                    dom: '<"top"Bf>rt<"bottom"lip>',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            title: 'Audit Logs',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            title: 'Audit Logs',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            extend: 'csvHtml5',
                            title: 'Audit Logs',
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
                    "order": [0, 'desc'],
                    "bInfo": true,
                    "iDisplayStart": 0,
                    "serverSide": true,
                    "sAjaxSource": "AuditLogsDatatables",
                    "sServerMethod": "POST",
                    "fnCreatedRow": function (nRow, aData, iDataIndex) {
                        //   $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'DocSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#modal-clinichour");
                    },
                    "fnServerParams": function (aoData)
                    {
                        aoData.push({"name": "ProcessStatus", "value": $('#ProcessStatus').val()});
                        aoData.push({"name": "FilterDateMin", "value": $('#min').val()});
                        aoData.push({"name": "FilterDateMax", "value": $('#max').val()});
                    },
                    "aoColumns": [{
                    "mData": 0,
                    "bVisible": true
                }, {
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
                    "mData": 9,
                    "bVisible": true
                }, {
                    "mData": 7,
                    "bVisible": true
                }, {
                    "mData": 8,
                    "bVisible": true
                }]
                });
            });
            
             $('#min, #max').keyup(function () {
            $('#AuditLogsDatatable').DataTable().ajax.reload();
        });
        $('#min').change(function () {
            $('#AuditLogsDatatable').DataTable().ajax.reload();
        });
        $('#max').change(function () {
            $('#AuditLogsDatatable').DataTable().ajax.reload();
        });