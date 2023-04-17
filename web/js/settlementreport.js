/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function ViewMerchantProfile(id) {

    window.location.href = "MerchantProfile.jsp?ID=" + id;
}
$(document).ready(function () {
    $('#min, #max').keyup(function () {
        $('#TransactionsDatatable').DataTable().ajax.reload();

    });
    $('#min').change(function () {
        $('#TransactionsDatatable').DataTable().ajax.reload();
    });
    $('#max').change(function () {
        $('#TransactionsDatatable').DataTable().ajax.reload();
    });

//                $('#Onboard_Type').on('change', function () {
//                    CheckParamsValidity();
//                });
//                $('#Account_Number').on('change', function () {
//                    CheckParamsValidity();
//                });
    $('#UnitInfo').on('change', function () {
        getParams();
        CheckParamsValidity();
    });
    function getParams() {
//        var UnitInfo = $('#UnitInfo').val();
//        var UnitInfoDatas = UnitInfo.split(",");
//        var obtype = '';
//        $('#Account_Number').val(UnitInfoDatas[0] + ',' + UnitInfoDatas[1]);
//       $('#TerminalNumber').val(UnitInfoDatas[3]);
//       if (UnitInfoDatas[2] === '2') {
//            obtype = '0';
//        }else{
//                    obtype=UnitInfoDatas[2];
//                }
//                $('#Onboard_Type').val(obtype);
        var GetSelected = $('#UnitInfo').val();
        var GetSelectedDATA = GetSelected.split(";;");
        var GetSelectedDataType = GetSelectedDATA[0]
        if (GetSelectedDataType === 'ALL') {
            var obtype = '';
            $('#Account_Number').val(GetSelectedDATA[2] + ',' + GetSelectedDATA[3]);
            $('#TerminalNumber').val(GetSelectedDATA[4]);
            $('#TerminalNumberBack').val(GetSelectedDATA[5]);
            if (GetSelectedDATA[1] === '2') {
                obtype = '0';
            } else {
                obtype = GetSelectedDATA[1];
            }
            $('#Onboard_Type').val(obtype);
        } else {
            //secondsplit
            var UnitInfo = $('#UnitInfo').val();
            var UnitInfoDatas = UnitInfo.split(",");
            var obtype = '';
            $('#Account_Number').val(UnitInfoDatas[0] + ',' + UnitInfoDatas[1]);
            $('#TerminalNumber').val(UnitInfoDatas[3]);
            $('#TerminalNumberBack').val(UnitInfoDatas[3]);
            if (UnitInfoDatas[2] === '2') {
                obtype = '0';
            } else {
                obtype = UnitInfoDatas[2];
            }
            $('#Onboard_Type').val(obtype);
        }


    }

    function CheckParamsValidity() {
        var obt = $('#Onboard_Type').val();
        var acn = $('#Account_Number').val();

        if (obt === '' || acn === '') {
            if (obt === '') {
                //   alert('Please Select On-board Type');
            } else {
                //  alert('Please Select Account Number');
            }
        } else {
            GetTransaction(obt);
        }

    }
    function GetTransaction(tr_type) {
        $.ajax({
            url: 'Transactions/MerchantSettlementReport.jsp',
            type: 'Post',
            data: {TransactionType: tr_type},
            success: function (data) {
                $('#transactionTable').html(data);
                $('#TransactionsDatatable').DataTable().ajax.reload();
            },
            error: function (xhr, ajaxOptions, thrownError) {
                console.log("Error!  CMS (View Documents)" + thrownError);
            }
        });
    }




});