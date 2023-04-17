/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function removeAccount(id) {
    $('.NewAccountDiv_' + id).remove();
    var Newaccountnumber = parseInt($('#NewAccountCountsss').val());
    var Newnewaccountcount = Newaccountnumber - 1;
    $('#NewAccountCountsss').val(Newnewaccountcount);
    //alert('new Account count : ' + Newnewaccountcount);
}
function removeExistingAccount(id) {
    var oldToRemoveAccount = $('#toRemoveAccount').val();
    var oldToRemoveAccountArrayValues = oldToRemoveAccount.split(",");
    oldToRemoveAccountArrayValues.push(id);
    $('#toRemoveAccount').val(oldToRemoveAccountArrayValues);
    $('.ExistingAccountDiv_' + id).remove();
    //minus the Account Count
    var AccountCount = parseInt($('#AccountCount').val());
    var NewAccountCount = AccountCount - 1;
    $('#AccountCount').val(NewAccountCount);
//toRemoveAccounta add value
//    $('.NewAccountDiv_' + id).remove();
//    var Newaccountnumber = parseInt($('#NewAccountCountsss').val());
//    var Newnewaccountcount=Newaccountnumber-1;
//    $('#NewAccountCountsss').val(Newnewaccountcount);
//    alert('new Account count : '+Newnewaccountcount);
}

function AddNewAccount() {
    var accountnumber = parseInt($('#AccountCount').val());
    var Newaccountnumber = parseInt($('#NewAccountCountss').val());
    var NewNewaccountnumber = parseInt($('#NewAccountCountsss').val());
    $.ajax({
        url: 'Registration/AddNewAccount.jsp',
        type: 'POST',
        data: {AccountNo: Newaccountnumber + 1},
        success: function (data) {
            $('#Accounts-Div').append(data);

            $('#NewAccountCountss').val(Newaccountnumber + 1);
            $('#NewAccountCountsss').val(NewNewaccountnumber + 1);
         //   alert($('#NewAccountCountss').val());
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
    accountnumber++;
}
function AddUnits(Branchid, start, end) {
    //  alert('#NewAccountUnitsCount'+Branchid);
    $('#NewAccountUnitsCount' + Branchid).val("2");
    $.ajax({
        url: 'DD/OnboardTypeDDOption.jsp',
        type: 'POST',
        data: {dummy: null},
        success: function (data) {
            var i;
            for (i = start; i < end; i++) {
                //alert("#UnitTableBodyBranch" + Branchid + "Append")
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
    // alert('#ANoUnits' + BranchIDNo + ":" + NoTerminals);
    var NoTerminalCurrent = $('#ANoUnits' + BranchIDNo + 'Current').val();
    var NoTerminalNew = NoTerminals;
    if (NoTerminalCurrent < NoTerminalNew) {
        //  alert("add from:" + NoTerminalCurrent + " to :" + NoTerminalNew);
        AddUnits(BranchIDNo, NoTerminalCurrent, NoTerminalNew);
    } else if (NoTerminalCurrent > NoTerminalNew) {
        //  alert("remove from:" + NoTerminalNew + " to :" + NoTerminalCurrent);
        RemoveUnits(BranchIDNo, NoTerminalNew, NoTerminalCurrent);
    } else {
        //  alert("ANoUnitsCurrent" + BranchIDNo + " : " + NoTerminalCurrent + " NoTerminalNew" + BranchIDNo + " : " + NoTerminalNew)

    }

    $('#ANoUnits' + BranchIDNo + 'Current').val(NoTerminalNew);

}


function LoadPendingMerchants() {
    $.ajax({
        url: 'Merchants/RejectedDisapprovedMerchantLists.jsp',
        type: 'POST',
        data: {dummy: null},
        success: function (data) {
            $('#div-userContainer').html(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  Rejected/Disapproved Merchant ( Load Pending Merchant)" + thrownError);
        }
    });
}
function LoadMerchant(MerchantID) {
    $.ajax({
        url: 'Merchants/MerchantInfo.jsp',
        type: 'POST',
        data: {MerchantID: MerchantID},
        success: function (data) {
            $('#div-userContainer').html(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  Rejected/Disapproved Merchant (Load Merchant)" + thrownError);
        }
    });
}
function LoadDisapprovedMerchantInfo(MerchantID) {
    $.ajax({
        url: 'Merchants/MerchantInfo.jsp',
        type: 'POST',
        data: {MerchantID: MerchantID, Action: '2'}, //Action 2 is with save buttons
        success: function (data) {
            $('#div-userContainer').html(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  Rejected/Disapproved Merchant (Load Disapproved erchant Information)" + thrownError);
        }
    });
}
function LoadRejectedMerchantInfo(MerchantID) {
    $.ajax({
        url: 'Merchants/MerchantInfo.jsp',
        type: 'POST',
        data: {MerchantID: MerchantID, Action: '0'}, //Action 2 is with save buttons
        success: function (data) {
            $('#div-userContainer').html(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  Rejected/Disapproved Merchant ( Load Rejected Merchant Info)" + thrownError);
        }
    });
}
function ApproveMerchant(id) {
    $('#ApprovalMerch').val(id);
    $('#ApprovalAction').val("3");
    $('#DisapproveDiv').hide();
    $('#ApproveDiv').show();
}
function DisApproveMerchant(id) {
    $('#ApprovalMerch').val(id);
    $('#ApprovalAction').val("4");
    $('#DisapproveDiv').show();
    $('#ApproveDiv').hide();
}
function RejectMerchant(id) {
    $('#ApprovalMerch').val(id);
    $('#ApprovalAction').val("5");
    $('#DisapproveDiv').show();
    $('#ApproveDiv').hide();
}


function AddTerminals(Branchid, start, end) {
    var i;
    for (i = start; i < end; i++) {
        //  alert('Add#TerminalTableBodyBranch' + Branchid);
        $('#TerminalTableBodyBranch' + Branchid).append('<tr id="Branch' + Branchid + 'Terminal' + i + '">' +
                '<td> <input type="number" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalIDNew" id="Branch' + Branchid + 'TerminalID' + i + '" placeholder=""></td>' +
                '<td> <input type="Text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTypeNew" id="Branch' + Branchid + 'TerminalType' + i + '" placeholder=""></td>' +
                '<td> <input type="text" class="form-control form-control-range" name="Branch' + Branchid + 'TerminalTelcoNew" id="Branch' + Branchid + 'TerminalTelco' + i + '" placeholder=""></td>' +
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


    $('#BNoTerminals' + BranchIDNo + 'Current').val(NoTerminalNew);


}


function AddNewBranch() {
    var branchnumber = parseInt($('#BranchCount').val());
    var Newbranchnumber = parseInt($('#NewBranchCount').val());
    $.ajax({
        url: 'Registration/AddNewBranch.jsp',
        type: 'POST',
        data: {BranchNo: branchnumber + 1},
        success: function (data) {
            $('#Branches-Div').append(data);
            $('#NewBranchCount').val(Newbranchnumber + 1)
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  Rejected/Disapproved Merchant ( Add New Branch )" + thrownError);
        }
    });


}

function SubmitEditedMerchant() {
    $('#submitbutton').click();
}