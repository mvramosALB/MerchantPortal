/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function ShowPassword() {
    var x = document.getElementById("password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}
$('#form-LogIn').submit(function (e) {
    var returnmess = "", title = "", color = "", mess = "", userid = "";
    var form = $(this);
    var dataArray = $(form).serializeArray();
    $.ajax({
        url: 'LogInController',
        type: 'POST',
        data: dataArray,
        success: function (data) {
            returnmess = data.split(";;");
            title = returnmess[0];
            color = returnmess[1];
            mess = returnmess[2];
            // userid = returnmess[3];
            $.toaster({message: mess, title: title, priority: color});
            if (title === "Alert") {
            } else if (title === "Success") {
                window.location.href = "dashboard.jsp";
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("Error! Index (Form-Submit)" + thrownError);
        }
    });
    e.preventDefault();
});

