<%-- 
    Document   : index
    Created on : 11 17, 20, 4:12:37 PM
    Author     : IT-Programmer
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>ALB P2M Merchant Portal</title>

        <!-- Custom fonts for this template-->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
              rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="Bootstrap/startbootstrap-sb-admin-2-gh-pages/css/sb-admin-2.min.css" rel="stylesheet">

    </head>

    <body class="bg-gradient-primary" style="background-image: url(https://portal.allbank.ph/ALB/MOS/bg/MOSBG.jpg)">

        <div class="container">

            <!-- Outer Row -->
            <div class="row justify-content-end">

                <div class="col-xl-4 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <!--Nested Row within Card Body-->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-4">Welcome to AllBank P2M Merchant's Portal!</h1>
                                        </div>
                                        <form class="user" id="form-LogIn">
                                            <div class="form-group">
						<input type="hidden" name="csrfToken" value="8des535dsrjkl0"/>
                                                <input required name="username" type="text" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp"  placeholder="Enter Username">
                                            </div>
                                            <div class="form-group">
                                                <input required name="password" type="password" class="form-control form-control-user" id="password" placeholder="Password">
                                            </div>
                                            <div class="form-group">
                                                <div class="custom-control custom-checkbox small">
                                                    <input onclick="ShowPassword()" type="checkbox" class="custom-control-input" id="customCheck">
                                                    <label class="custom-control-label" for="customCheck">Show Password </label>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-user btn-block">
                                                Login
                                            </button>
                                            <!--hr>
                                            <a href="register.jsp" class="btn btn-google btn-user btn-block">
                                                <i class="fab fa-google fa-fw"></i> Become a P2M Merchant Now!
                                            </a-->
                                            <input type="hidden" name="Type" value="1"/>
                                        </form>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="ForgotPass">Forgot Password?</a>
                                        </div>
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
         <script src="js/session.js"></script>
         <script src="js/index.js"></script>
        

    </body>

</html>