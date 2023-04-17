<%-- 
    Document   : MerchantTransactions
    Created on : 02 19, 21, 9:37:59 AM
    Author     : IT-Programmer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/Includes/DBConnection.jsp" %>
<html>
    <style>
        #TransactionsDatatable tbody > tr > td {
            max-height: 10px;
        }
    </style>
    <c:choose>
        <c:when test="${param.TransactionType == '0'}">
            <!-- Static -->

            <table class="table table-bordered table-sm table-striped" id="TransactionsDatatable" width="100%" cellspacing="0" style="font-size: 12px;">
                <thead>
                    <tr>
                        <th class="search-filter-doc-cat">Terminal</th>
                        <th class="search-filter-doc-cat">Reference</th>
                        <th class="search-filter-doc-cat">Amount</th>
                        <th class="search-filter-doc-cat">MDR</th>
                        <th class="search-filter-doc-cat ">Commission</th>
                        <th class="search-filter-doc-cat">Net Settlement</th>
                        <th >Transaction Date</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <script>
                var rvt = "2";
                var rvv = "0";
                rvt = $('#rvt').val();
                rvv = parseFloat($('#rvv').val());
                var TRTable = $('#TransactionsDatatable').DataTable({

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
                    "order": [0, 'asc'],
                    "bInfo": true,
                    "iDisplayStart": 0,
                    "serverSide": false,
                    "sAjaxSource": "MerchantsTransactionsDatatables",
                    "sServerMethod": "POST",
                    "fnCreatedRow": function (nRow, aData, iDataIndex) {
                        //   $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'DocSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#modal-clinichour");
                    },
                    "fnServerParams": function (aoData)
                    {
                        aoData.push({"name": "SDate", "value": $('#min').val()});
                        aoData.push({"name": "EDate", "value": $('#max').val()});
                        aoData.push({"name": "AccountNumber", "value": $('#Account_Number').val()});
                        aoData.push({"name": "OnboardType", "value": $('#Onboard_Type').val()});
                        aoData.push({"name": "TerminalID", "value": $('#TerminalNumberBack').val()});
                    },
                    "aoColumns": [{
                            "mData": 3,
                            "bVisible": true
                        }, {
                            "mData": 1,
                            "bVisible": true
                        }, {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                if (full[0] == '0.00') {//Debited
                                    textcolor = "text-danger";
                                    datepaid = full[0];
                                } else {//Credited
                                    textcolor = "text-success";
                                    datepaid = full[0];
                                }



                                returnString = '<p class="' + textcolor + ' amount text-right">' + datepaid + '</p>';
                                return returnString;
                            }
                        }
                        , {
                            //MDR
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                               var returnString = '';
                                if (rvt === '1') {
                                    returnString = rvv;
                                } else {
                                    returnString = rvv + '%';
                                }
                                //returnString = '1%';

                                return returnString;
                            }
                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                //Commision                        
                                var returnString = '';
                                var amount = parseFloat(full[0]).toFixed(2);
                                var mdrRate = (rvv / 100);
                                if (rvt === '1') {
                                    returnString = rvv;
                                } else {
                                    returnString = amount * mdrRate;
                                }
                                returnString = parseFloat(returnString).toFixed(2);
                                returnString = '<center><p class="  text-right amount text-danger">' + returnString + '</p></center>';
                                return returnString;
                            }
                        }

                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                //NetSettlement
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                var amount = parseFloat(full[0]).toFixed(2);
                                var mdrRate = amount * (rvv / 100);
                                if (rvt === '1') {
                                    returnString = amount-rvv;
                                } else {
                                    returnString = amount - mdrRate;
                                }
                                returnString = parseFloat(returnString).toFixed(2);
                                // returnString = full[1] * 0.98;
                                returnString = '<center><p class="  text-right amount text-success">' + returnString + '</p></center>';
                                return returnString;
                            }
                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                var DateTimeUnformatted = full[2];
                                var ParsedDatetime = new Date(full[2]);
                                //var DateTimeFormatted=DateTimeUnformatted.replace('T',' ');
                                var DateTimeFormatted = formatDate(ParsedDatetime);
                                returnString = DateTimeFormatted;
                                return returnString;
                            }
                        }]
                });
                // Setup - add a text input to each header cell

                $('#TransactionsDatatable .search-filter-doc-cat').each(function () {
                    var title2 = $('#TransactionsDatatable .search-filter-doc-cat').eq($(this).index()).text();
                    $(this).html(title2 + '<br><br><input id="' + title2 + 'Filter"  style="width: 100px;display:none" type="text" placeholder="Search " />');
                });
                // Apply the search

                TRTable.columns().eq(0).each(function (colIdx) {

                    $('input', TRTable.column(colIdx).header()).on('keyup change', function () {

                        TRTable
                                .column(colIdx)
                                .search(this.value, true, false)
                                .draw();
                    });
                    $('input', TRTable.column(colIdx).header()).on('click', function (e) {
                        e.stopPropagation();
                    });
                });
                function FilterTerminalID() {
                    $('#TerminalFilter').val($('#TerminalNumber').val());
                    var terminal = $('#TerminalNumber').val();
                    TRTable
                            .column(0)
                            .search("(^" + terminal + "$)", true, false)
                            .draw();
                }
                $(document).ready(function () {
                    var intercount = 0;
                    var interv = setInterval(function () {
                        FilterTerminalID();
                        intercount++;
                        if (intercount > 2) {
                            clearInterval(interv);
                        }
                    }, 100);
                });

            </script>

        </c:when>
        <c:when test="${param.TransactionType == '1'}">
            <!-- Api Based -->
            <table class="table table-bordered table-sm table-striped" id="TransactionsDatatable" width="100%" cellspacing="0" style="font-size: 12px;">
                <thead>
                    <tr>
                        <th>Account Number </th>
                        <th class="search-filter-doc-cat">Reference</th>
                        <th class="search-filter-doc-cat">Token</th>
                        <th style="width:20px" class="search-filter-doc-cat">Terminal</th>
                        <th class="search-filter-doc-cat ammount">Amount</th>
                        <th class="search-filter-doc-cat">MDR</th>
                        <th class="search-filter-doc-cat">Commission</th>
                        <th class="search-filter-doc-cat">Net Settlement</th>
                        <th class="select-filter-doc-cat">Status</th>
                        <th >Date Created</th>
                        <th>Payment Date</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <script>
                var rvt = "2";
                var rvv = "0";
                rvt = $('#rvt').val();
                rvv = parseFloat($('#rvv').val());//$('#rvv').val();
                var TRTable = $('#TransactionsDatatable').DataTable({

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
                    "order": [0, 'asc'],
                    "bInfo": true,
                    "iDisplayStart": 0,
                    "serverSide": false,
                    "sAjaxSource": "MerchantsTransactionsDatatables",
                    "sServerMethod": "POST",
                    "fnCreatedRow": function (nRow, aData, iDataIndex) {
                        //   $(nRow).attr('id', "row" + iDataIndex).attr('onclick', 'DocSelected("' + aData[0] + '");').attr("data-toggle", "modal").attr("data-target", "#modal-clinichour");
                    },
                    "fnServerParams": function (aoData)
                    {
                        aoData.push({"name": "SDate", "value": $('#min').val()});
                        aoData.push({"name": "EDate", "value": $('#max').val()});
                        aoData.push({"name": "AccountNumber", "value": $('#Account_Number').val()});
                        aoData.push({"name": "OnboardType", "value": $('#Onboard_Type').val()});
                        aoData.push({"name": "TerminalID", "value": $('#TerminalNumberBack').val()});
                    },
                    "aoColumns": [{
                            "mData": 0,
                            "bVisible": false
                        }, {
                            "mData": 4,
                            "bVisible": true
                        }, {
                            "mData": 6,
                            "bVisible": false
                        }, {
                            "mData": 5,
                            "bVisible": true
                        }, {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = ""
                                var AmountPaid = "";
                                var returnString = '';
                                if (full[3] === '1900-01-01T00:00:00') {
                                    //    textcolor = "text-danger";
                                    AmountPaid = full[1];
                                } else {
                                    //    textcolor = "text-success";
                                    AmountPaid = full[1];
                                }
                                returnString = '<center><p class="' + textcolor + ' amount text-right">' + AmountPaid + '</p></center>';
                                return returnString;
                            }

                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';

                                if (rvt === '1') {
                                    returnString = rvv;
                                } else {
                                    returnString = rvv + '%';
                                }
                                return returnString;
                            }
                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                var MDR = 0;//full[1] * 0.02;
                                var amount = parseFloat(full[1]).toFixed(2);
                                var mdrRate = (rvv / 100);
                                if (rvt === '1') {
                                    MDR = rvv;
                                } else {
                                    //  returnString = '%';
                                    MDR = amount * mdrRate;
                                }
                                MDR = parseFloat(MDR).toFixed(2);

                                returnString = '<center><p class="  text-right amount text-danger">' + MDR + '</p></center>';
                                return returnString;
                            }
                        }

                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                var NetSettlement = full[1];//full[1] * 0.98;
                                var amount = full[1];
                                var mdrValue = amount * (rvv / 100);
                                if (rvt === '1') {
                                    NetSettlement = amount - rvv;
                                } else {
                                    NetSettlement = amount - mdrValue;
                                }

                                NetSettlement = parseFloat(NetSettlement).toFixed(2);
                                returnString = '<center><p class="  text-right amount text-success">' + NetSettlement + '</p></center>';
                                return returnString;
                            }
                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                if (full[3] === '1900-01-01T00:00:00') {
                                    if (full[2] === '0') {
                                        textcolor = "text-warning";
                                        datepaid = "Not Yet Paid";
                                    } else {
                                        textcolor = "text-warning";
                                        datepaid = "Expired";
                                    }

                                } else {
                                    textcolor = "text-success"
                                    datepaid = " Paid ";
                                }
                                returnString = '<center><p class="' + textcolor + '">' + datepaid + '</p></center>';
                                return returnString;
                            }
                        }, {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                var DateTimeUnformatted = full[7];
                                //var DateTimeFormatted=DateTimeUnformatted.replace('T',' ');
                                var DateFormatted = new Date(full[7]);
                                returnString = formatDate(DateFormatted);
                                return returnString;
                            }
                        }
                        , {
                            "mData": null,
                            "bSortable": true,
                            "className": "all",
                            "mRender": function (data, type, full) {
                                var textcolor = "";
                                var datepaid = "";
                                var returnString = '';
                                if (full[3] === '1900-01-01T00:00:00') {
                                    datepaid = "--"
                                } else {
                                    //datepaid = full[2].replace('T',' ');
                                    datepaid = new Date(full[3]);
                                    datepaid = formatDate(datepaid);
                                }
                                returnString = '<center><p class="' + textcolor + '">' + datepaid + '</p></center>';
                                return returnString;
                            }
                        }]
                });
                // Setup - add a text input to each header cell
                $('#TransactionsDatatable .select-filter-doc-cat').each(function () {
                    var title1 = $('#TransactionsDatatable .select-filter-doc-cat').eq($(this).index()).text();
                    $(this).html('Status<br><br><center><select id="StatusFilter" hidden type="text" ><option value="Paid ">Paid</option></select></center>');
                });
                $('#TransactionsDatatable .search-filter-doc-cat').each(function () {
                    var title2 = $('#TransactionsDatatable .search-filter-doc-cat').eq($(this).index()).text();
                    $(this).html(title2 + '<br><br><input id="' + title2 + 'Filter" style="width: 100px;display:none" type="text" placeholder="Search " />');
                });
                // Apply the search
                TRTable.columns().eq(0).each(function (colIdx) {

                    $('select', TRTable.column(colIdx).header()).on('keyup change', function () {
                        TRTable
                                .column(colIdx)
                                .search(this.value, true, false)
                                .draw();
                    });
                    $('select', TRTable.column(colIdx).header()).on('click', function (e) {
                        e.stopPropagation();
                    });
                });
                TRTable.columns().eq(0).each(function (colIdx) {

                    $('input', TRTable.column(colIdx).header()).on('keyup change', function () {
                        TRTable
                                .column(colIdx)
                                .search(this.value, true, false)
                                .draw();
                    });
                    $('input', TRTable.column(colIdx).header()).on('click', function (e) {
                        e.stopPropagation();
                    });
                });
                function FilterTerminalID() {
                    $('#TerminalFilter').val($('#TerminalNumber').val());
                    var terminal = $('#TerminalNumber').val();
                    var Status = $('#StatusFilter').val();
                    TRTable
                            .column(3)
                            .search("(^" + terminal + "$)", true, false)
                            .draw();
                    TRTable
                            .column(8)
                            .search("" + Status + "", true, false)
                            .draw();
                }
                $(document).ready(function () {
                    var intercount = 0;
                    var interv = setInterval(function () {
                        FilterTerminalID();
                        intercount++;
                        if (intercount > 2) {
                            clearInterval(interv);
                        }

                    }, 100);

                });
            </script>
        </c:when>
    </c:choose>
    <script>
        $(document).ready(function () {
            setInterval(function () {
                $('.amount').mask("###,###,##0.00", {reverse: true});
            }, 1);


        });
        function formatDate(dateVal) {
            var newDate = new Date(dateVal);
            var sMonth = padValue(newDate.getMonth() + 1);
            var sDay = padValue(newDate.getDate());
            var sYear = newDate.getFullYear();
            var sHour = newDate.getHours();
            var sMinute = padValue(newDate.getMinutes());
            var sAMPM = "AM";
            var iHourCheck = parseInt(sHour);
            if (iHourCheck > 12) {
                sAMPM = "PM";
                sHour = iHourCheck - 12;
            } else if (iHourCheck === 0) {
                sHour = "12";
            }

            sHour = padValue(sHour);
            return sMonth + "-" + sDay + "-" + sYear + " " + sHour + ":" + sMinute + " " + sAMPM;
        }

        function padValue(value) {
            return (value < 10) ? "0" + value : value;
        }

    </script>
</html>
