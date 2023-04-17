/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



          
            function LoadPendingMerchants() {
                $.ajax({
                    url: 'Merchants/PendingMerchantLists.jsp',
                    type: 'POST',
                    data: {dummy: null},
                    success: function (data) {
                        $('#div-userContainer').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
            function LoadPendingMerchantInfo(MerchantID) {
                $.ajax({
                    url: 'Merchants/MerchantInfo.jsp',
                    type: 'POST',
                    data: {MerchantID: MerchantID,Action:'1'},//Action 1 is with approve buttons
                    success: function (data) {
                        $('#div-userContainer').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
            function LoadDisapprovedMerchantInfo(MerchantID) {
                $.ajax({
                    url: 'Merchants/MerchantInfo.jsp',
                    type: 'POST',
                    data: {MerchantID: MerchantID,Action:'2'},//Action 2 is with save buttons
                    success: function (data) {
                        $('#div-userContainer').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
               function LoadRejectedMerchantInfo(MerchantID) {
                $.ajax({
                    url: 'Merchants/MerchantInfo.jsp',
                    type: 'POST',
                    data: {MerchantID: MerchantID,Action:'0'},//Action 2 is with save buttons
                    success: function (data) {
                        $('#div-userContainer').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error!  CMS (View Documents)" + thrownError);
                    }
                });
            }
            function ApproveMerchant(id) {
                $('#ApprovalMerch').val(id);
                $('#ApprovalAction').val("3");
                $('#DisapproveDiv').hide();
                $('#ApproveDiv').show();
                $('#confirmbutton').text("Approve");
            }
            function DisApproveMerchant(id) {
                $('#ApprovalMerch').val(id);
                $('#ApprovalAction').val("4");
                $('#DisapproveDiv').show();
                $('#ApproveDiv').hide();
                $('#confirmbutton').text("Submit");
            }
             function RejectMerchant(id) {
                $('#ApprovalMerch').val(id);
                $('#ApprovalAction').val("5");
                $('#DisapproveDiv').show();
                $('#ApproveDiv').hide();
                $('#confirmbutton').text("Submit");
            }

            $('#Form-MerchantApprove').submit(function (e) {
                var returnmess = "", title = "", color = "", mess = "", userid = "", newUserLogin = "";
                var form = $(this);
                var dataArray = $(form).serializeArray();
                $.ajax({
                    url: 'MerchantUpdate',
                    type: 'POST',
                    data: dataArray,
                    success: function (data) {
                        returnmess = data.split(";;");
                        title = returnmess[0];
                        color = returnmess[1];
                        mess = returnmess[2];
                        userid = returnmess[3];

                        $.toaster({message: mess, title: title, priority: color});
                        if (title === "Alert") {

                        } else if (title === "Success") {
                            window.location.href = "PendingMerchant.jsp";
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("Error! Index (Form-Submit)" + thrownError);
                    }
                });

                e.preventDefault();
            });