/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var branchnumber = 1;
var accountnumber = 1;
function AddTerminals(Branchid, start, end) {
    var i;
    for (i = start; i < end; i++) {
        $('#TerminalTableBodyBranch' + Branchid).append('<tr id="Branch' + Branchid + 'Terminal' + i + '">' +
                '<td> <input type="number" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalIDNew" id="Branch' + Branchid + 'TerminalID' + i + '" placeholder=""></td>' +
                '<td> <input type="Text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTypeNew" id="Branch' + Branchid + 'TerminalType' + i + '" placeholder=""></td>' +
                '<td> <input type="text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTelcoNew" id="Branch' + Branchid + 'TerminalTelco' + i + '" placeholder=""></td>' +
                '<td> <input type="text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalMobileNew" id="Branch' + Branchid + 'TerminalMobile' + i + '" placeholder=""></td>' +
                '</tr>');
    }
}
function RemoveTerminals(Branchid, start, end) {
    var i;
    for (i = start; i < end; i++) {
        $('#Branch' + Branchid + 'Terminal' + i + '').remove();
    }
}

function AddTerminal(BranchIDNo) {

    var NoTerminals = $('#BNoTerminals' + BranchIDNo).val();
    if (NoTerminals === '') {
        NoTerminals = 0;
        $('#BNoTerminals' + BranchIDNo).val("0");
    }
    var NoTerminalCurrent = $('#BNoTerminals' + BranchIDNo + 'Current').val();
    var NoTerminalNew = NoTerminals;
    if (NoTerminalCurrent < NoTerminalNew) {
        //   alert("add from:" + NoTerminalCurrent + " to :" + NoTerminalNew);
        AddTerminals(BranchIDNo, NoTerminalCurrent, NoTerminalNew);
    } else if (NoTerminalCurrent > NoTerminalNew) {
        //   alert("remove from:" + NoTerminalNew + " to :" + NoTerminalCurrent);
        RemoveTerminals(BranchIDNo, NoTerminalNew, NoTerminalCurrent);
    }

    /**$.ajax({
     url: 'Registration/AddTerminals.jsp',
     type: 'Get',
     data: {BranchIDNo: BranchIDNo, NoTerminals: NoTerminals, from: NoTerminalCurrent, to: NoTerminalNew},
     success: function (data) {
     alert(data)
     $('#TerminalTableBodyBranch' + BranchIDNo).html(data);
     
     },
     error: function (xhr, ajaxOptions, thrownError) {
     console.log("Error!  CMS (View Documents)" + thrownError);
     }
     });
     
     
     **/
    $('#BNoTerminals' + BranchIDNo + 'Current').val(NoTerminalNew);
//                $('#BNoTerminals' + BranchIDNo + 'New').val(NoTerminals);

}
function AddNewBranch() {

    $.ajax({
        url: 'Registration/AddNewBranch.jsp',
        type: 'POST',
        data: {BranchNo: branchnumber + 1},
        success: function (data) {
            $('#Branches-Div').append(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
    branchnumber++;
}
function AddNewAccount() {

    $.ajax({
        url: 'Registration/AddNewAccount.jsp',
        type: 'POST',
        data: {AccountNo: accountnumber + 1},
        success: function (data) {
            $('#Accounts-Div').append(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
    accountnumber++;
}
function AddUnits(Branchid, start, end) {
    //alert('UnitTableBodyBranch' + Branchid);
    $.ajax({
        url: 'DD/OnboardTypeDDOption.jsp',
        type: 'POST',
        data: {dummy: null},
        success: function (data) {
            var i;
            for (i = start; i < end; i++) {
                //  alert("#UnitTableBodyBranch" + Branchid + "Apend")
                $('#UnitTableBodyBranch' + Branchid).append('<tr id="Account' + Branchid + 'Unit' + i + '">' +
                        '<td> <input type="text" class="form-control " name="Account' + Branchid + 'UnitNameNew" id="Account' + Branchid + 'TerminalID' + i + '" placeholder=""></td>' +
                        '<td> <select  class="form-control"  name="Account' + Branchid + 'UnitTypeNew" id="Account' + Branchid + 'UnitType' + i + '">' + data + ' </select></td>' +
                        '<td> <input type="text" class="form-control " name="Account' + Branchid + 'TerminalIDNew" id="Account' + Branchid + 'TerminalTelco' + i + '" placeholder=""></td>' +
                        '<td> <input type="text" class="form-control " name="Account' + Branchid + 'MobileNew" id="Account' + Branchid + 'TerminalMobile' + i + '" placeholder=""></td>' +
                        '</tr>');
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
}
function RemoveUnits(Branchid, start, end) {
    var i;
    for (i = start; i < end; i++) {
        $('#Account' + Branchid + 'Unit' + i + '').remove();
    }
}
function AddUnit(BranchIDNo) {
    $('.unitsTable' + BranchIDNo).show();

    var NoTerminals = $('#ANoUnits' + BranchIDNo + "").val();
    if (NoTerminals === '') {
        NoTerminals = 0;
        $('#ANoUnits' + BranchIDNo).val("0");
    }
    //   alert('#ANoUnits' + BranchIDNo + ":" + NoTerminals);
    var NoTerminalCurrent = $('#ANoUnits' + BranchIDNo + 'Current').val();
    var NoTerminalNew = NoTerminals;
    if (NoTerminalCurrent < NoTerminalNew) {
        //     alert("add from:" + NoTerminalCurrent + " to :" + NoTerminalNew);
        AddUnits(BranchIDNo, NoTerminalCurrent, NoTerminalNew);
    } else if (NoTerminalCurrent > NoTerminalNew) {
        //   alert("remove from:" + NoTerminalNew + " to :" + NoTerminalCurrent);
        RemoveUnits(BranchIDNo, NoTerminalNew, NoTerminalCurrent);
    } else {
        // alert("ANoUnitsCurrent" + BranchIDNo + " : " + NoTerminalCurrent + " NoTerminalNew" + BranchIDNo + " : " + NoTerminalNew)

    }

    $('#ANoUnits' + BranchIDNo + 'Current').val(NoTerminalNew);

}

function AddNewAttachment() {
    $.ajax({
        url: 'Registration/AddNewAttachment.jsp',
        type: 'POST',
        data: {dummy: null},
        success: function (data) {
            $('#Attachments-Div').append(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
}
