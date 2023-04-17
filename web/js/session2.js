/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var page = /[^/]*$/.exec(window.location.href)[0];
var SessionTimer=setInterval(function () {

    if (page == 'index.jsp' || page == 'ForgotPassword.jsp' || page == '' || page == 'Login.jsp') {

        $.ajax({
            url: 'Session/ID.jsp',
            type: 'POST',
            success: function (data) {
                if (data !== '') {
                    window.location.href = "dashboard.jsp";
                } else {

                }
            },
            error: function (xhr, ajaxOptions, thrownError) {

                window.location.href = 'index.jsp';


                console.log("Error! Scripts (Get Session)" + thrownError);
            }
        });
    } else {

        $.ajax({
            url: 'Session/ID.jsp',
            type: 'POST',
            success: function (data) {
                if (data !== '') {
                  
                } else {

                    window.location.href = 'index.jsp';

                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                if (page === 'ForgotPassword.jsp') {
                    window.location.href = 'ForgotPassword.jsp';
                }else if (page === 'Login.jsp') {
                    window.location.href = 'Login.jsp';
                } else {
                    window.location.href = 'index.jsp';
                }
                console.log("Error! Scripts (Get Session)" + thrownError);
            }
        });

    }
}, 5000);
