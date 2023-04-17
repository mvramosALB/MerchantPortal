/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

                                                        function ShowPassword() {
                                                            var x = document.getElementById("newpass");
                                                            var y = document.getElementById("cnewpass");
                                                            if (x.type === "password") {
                                                                x.type = "text";
                                                                y.type = "text";
                                                            } else {
                                                                x.type = "password";
                                                                y.type = "password";
                                                            }
                                                        }
                                                        $('#form-ForgotPassword').submit(function (e) {
                                                            var returnmess = "", title = "", color = "", mess = "", userid = "";
                                                            var form = $(this);
                                                            var dataArray = $(form).serializeArray();
                                                            $.ajax({
                                                                url: 'ForgotPassword',
                                                                type: 'POST',
                                                                data: dataArray,
                                                                success: function (data) {
                                                                    returnmess = data.split(";;");
                                                                    title = returnmess[0];
                                                                    color = returnmess[1];
                                                                    mess = returnmess[2];
                                                                    $.toaster({message: mess, title: title, priority: color});
                                                                    if (title === "Alert") {

                                                                    } else if (title === "Success") {
                                                                        //   window.location.href = "dashboard.jsp?menucode=DASH";
                                                                        if (mess === 'Enter OTP') {
                                                                            $('#step1').hide();
                                                                            $('#step2').show();
                                                                            $('#action').val("2");
                                                                            $('#cardtext').text(mess);
                                                                        } else if (mess === 'Enter New Password') {
                                                                            $('#step2').hide();
                                                                            $('#step3').show();
                                                                            $('#action').val("3");
                                                                            $('#cardtext').text(mess);
                                                                        }
                                                                    }
                                                                },
                                                                error: function (xhr, ajaxOptions, thrownError) {
                                                                    console.log("Error! Index (Form-Submit)" + thrownError);
                                                                }
                                                            });
                                                            e.preventDefault();
                                                        });
                                                        $('#form-NewPassword').submit(function (e) {
                                                            var returnmess = "", title = "", color = "", mess = "", userid = "";
                                                            var form = $(this);
                                                            var dataArray = $(form).serializeArray();
                                                            $.ajax({
                                                                url: 'ResetPassword',
                                                                type: 'POST',
                                                                data: dataArray,
                                                                success: function (data) {
                                                                    returnmess = data.split(";;");
                                                                    title = returnmess[0];
                                                                    color = returnmess[1];
                                                                    mess = returnmess[2];
                                                                    var userType = returnmess[3];

                                                                    $.toaster({message: mess, title: title, priority: color});
                                                                    if (title === "Alert") {
                                                                        //$("#form-logIn")[0].reset();
                                                                    } else if (title === "Success") {
                                                                        if (userType > 3) {
                                                                            window.location.href = "index.jsp";
                                                                        } else {
                                                                            window.location.href = "Login.jsp";
                                                                        }

                                                                    }
                                                                },
                                                                error: function (xhr, ajaxOptions, thrownError) {
                                                                    console.log("Error! Forgot Password (New Password)" + thrownError);
                                                                }
                                                            });
                                                            e.preventDefault();
                                                        });
                                                        $('.newpass').on("keyup", function () {
                                                            if ($('#newpass').val() !== $('#cnewpass').val()) {
                                                                console.log('not match');
                                                                $('#submit-password').attr("disabled", true);
                                                            } else {
                                                                console.log('matched');
                                                                $('#submit-password').attr("disabled", false);
                                                            }
                                                        });


