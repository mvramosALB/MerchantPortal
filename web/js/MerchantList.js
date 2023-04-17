/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
   function ViewMerchantProfile(id) {

                //window.location.href = "MerchantProfile.jsp?ID=" + id;
                $('#id').val(id);
                $('#formredirect').submit();

            }
            $(document).ready(function () {
                $('#MerchantsListDatatables').DataTable({
                    dom: '<"top"Bf>rt<"bottom"lip>',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            title: 'Transactions List ',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            extend: 'csvHtml5',
                            title: 'Transactions List ',
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
                    "order": [6, 'desc'],
                    "bInfo": true,
                    "iDisplayStart": 0,
                    "serverSide": true,
                    "sAjaxSource": "ApprovedMerchantsDatatables",
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
                            "mData": 8,
                            "bVisible": true
                        }, {
                            "mData": 9,
                            "bVisible": true
                        }, {
                            "mData": null,
                            "bSortable": false,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "text-primary"

                                var returnString = '';

                                if (full[11] === 'Active') {
                                    textcolor = "text-success"
                                } else if (full[11] === 'InActive') {
                                    textcolor = "text-danger"
                                }
                                returnString = '<center><p class="' + textcolor + '">' + full[11] + '</p></center>';

                                return returnString;

                            }
                        }, {
                            "mData": null,
                            "bSortable": false,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var functionOnclick1 = "ViewMerchantProfile('" + full[0] + "')";//view
                                var functionOnclick2 = "ViewMerchantProfile('" + full[0] + "')";//edit
                                var returnString = '';

                                if (full[11] === 'Active') {
                                    returnString = '<center><div class="btn-group"></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view" onclick="' + functionOnclick1 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                                } else if (full[11] === 'Inactive') {

                                    returnString = '<center><div class="btn-group"></button>\n\
                        <button type="button" class="btn btn-info btn-sm rm-view" onclick="' + functionOnclick2 + '"><i class="fa fa-eye"></i></button>\n\
                        </div></center>';
                                }

                                return returnString;

                            }
                        }]
                });
            });

