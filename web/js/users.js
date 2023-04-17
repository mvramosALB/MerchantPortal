/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function LoadUserMaintenance() {
    $.ajax({
        url: 'Users/main.jsp',
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
function LoadAddUser() {
    $.ajax({
        url: 'Users/add.jsp',
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
function LoadUser(UserID) {
    $.ajax({
        url: 'Users/UsersInfo.jsp',
        type: 'POST',
        data: {UserID: UserID},
        success: function (data) {
            $('#div-userContainer').html(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error!  CMS (View Documents)" + thrownError);
        }
    });
}
