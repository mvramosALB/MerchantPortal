<%-- 
    Document   : index
    Created on : 11 17, 20, 4:12:37 PM
    Author     : IT-Programmer
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>`

<%response.addHeader("X-Frame-Options" ,"DENY"); %>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        
        <title>ALB P2M Merchant - Forgot Password</title>

        <!-- Custom fonts for this template-->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
              rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/css/sb-admin-2.min.css" rel="stylesheet">
        <style>
            .vertical-center {
                min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
                min-height: 100vh; /* These two lines are counted as one :-)       */

                display: flex;
                align-items: center;
            }
        </style>
    </head>

    <body class="bg-gradient-primary" style="background-image: url()">

        <div class="container">

            <!-- Outer Row -->
            <div class="row justify-content-center vertical-center">

                <div class="col-xl-4 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <!--Nested Row within Card Body-->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 id="cardtext" class="h4 text-gray-900 mb-4">Forgot Password</h1>
                                        </div>
                                        <form class="user" id="form-ForgotPassword">
                                            <div id="step1">
                                                <div class="form-group">
						   <input type="hidden" name="csrfToken" value="8des535dsrjkl0"/>
                                                   <input hidden name="action" value="1" id="action"/>
                                                   <input type="hidden" name="csrfToken" value="8des535dsrjkl0"/>
                                                   <input name="UserName" type="text" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp"  placeholder="Enter Username">
                                                    <div class="form-group row">
                                                        <div class="col-sm-6 mb-3 mb-sm-0">

                                                            <br>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="OTPType" id="PassNotif1" value="sms" checked>
                                                                <label class="form-check-label" for="PassNotif1">
                                                                    via SMS
                                                                </label>
                                                            </div>
                                                            <div class="form-check form-check-inline">
                                                                <input class="form-check-input" type="radio" name="OTPType" id="PassNotif2" value="email">
                                                                <label class="form-check-label" for="PassNotif2">
                                                                    via Email
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn btn-primary btn-user btn-block">
                                                    Submit
                                                </button>
                                                <input type="hidden" name="Type" value="1"/>
                                            </div>
                                            <div style="display:none" id="step2">
                                                <div class="form-group">
                                                    <input name="OTP" type="text" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp"  placeholder="Enter OTP">
                                                </div>
                                                <button type="submit" class="btn btn-primary btn-user btn-block">
                                                    Submit
                                                </button>
                                            </div>

                                        </form>
                                        <form class="user" id="form-NewPassword">
                                            <div style="display:none" id="step3">
                                                <div class="form-group">
							<input type="hidden" name="csrfToken" value="8des535dsrjkl0"/>
                                                    <input name="newpass" type="password" class="form-control form-control-user  newpass" id="newpass" aria-describedby="emailHelp"  placeholder="Enter New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" onchange="CheckPasswordMatch()">
                                                </div>
                                                <div class="form-group">
                                                    <input name="cnewpass" type="password" class="form-control form-control-user newpass"  id="cnewpass" aria-describedby="emailHelp"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Confirm New Password">
                                                </div>
                                                <div class="form-group">
                                                    <div class="custom-control custom-checkbox small">
                                                        <input onclick="ShowPassword()" type="checkbox" class="custom-control-input" id="customCheck">
                                                        <label class="custom-control-label" for="customCheck">Show Password </label>
                                                    </div>
                                                </div>
                                                <button id="submit-password"  type="submit" class="btn btn-primary btn-user btn-block">
                                                    Submit
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/jquery/jquery.min.js"></script>
        <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/js/sb-admin-2.min.js"></script>
        <!-- Toaster-->  
        <script src="js/jquery.toaster.js"></script>
        <script src="js/forgotpassword.js"></script>
        <script>
        </script>

    </body>

</html>