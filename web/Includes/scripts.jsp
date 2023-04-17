<%-- 
    Document   : scripts
    Created on : 11 18, 20, 10:04:02 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
    </body>
    <!-- Bootstrap core JavaScript-->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/jquery/jquery.min.js"></script>
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/js/sb-admin-2.min.js"></script>
    <!-- Page level plugins -->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/js/demo/chart-area-demo.js"></script>
    <script src="graphs/merchant-piechart.js"></script>
    <!-- Toaster-->  
    <script src="js/jquery.toaster.js"></script>
    <!-- Session Checker-->  
    <script src="js/session.js" type="text/javascript"></script> 
    <!-- Page level plugins -->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <!--datatables button-->
    <script src="https://cdn.datatables.net/buttons/1.6.5/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.flash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.colVis.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="Bootstrap/startbootstrap-sb-admin-2-gh-pages/js/demo/datatables-demo.js"></script>

    <!--Mask-->
    <script src="js/jquery.mask.min.js"></script>
    <script src="js/jquery.mask.js"></script>
    <script src="js/session.js"></script>
    <script>

        $('.newpass').on("keyup", function () {
            if ($('#newpass').val() !== $('#cnewpass').val() || $('#cnewpass').val() === '') {
                //console.log('not match');
                $('#submit-password').attr("disabled", true);
                $('#npassval').val("0");
            } else {
                //console.log('matched');
                $('#submit-password').attr("disabled", false);
                $('#npassval').val("1");

            }
            CheckPasswordValidity();
        });

        function CheckPasswordValidity() {
            var cval = $('#cpassval').val();
            var nval = $('#npassval').val();
            //alert("cval : " + cval + " nval : " + nval);
            if (cval === '1' && nval === '1') {
                $('#submit-password').attr("disabled", false);
                //  alert("false");
            } else {
                $('#submit-password').attr("disabled", true);
                //  alert("true");
            }
        }
        function CheckCurrentPassword() {
            var returnmess = "", title = "", color = "", mess = "", userid = "";

            var cpass = $('#cpass').val();
            $.ajax({
                url: 'CheckCurrentPassword',
                type: 'Post',
                data: {cpass: cpass},
                success: function (data) {
                    returnmess = data.split(";;");
                    title = returnmess[0];
                    color = returnmess[1];
                    mess = returnmess[2];
                    if (title === 'Success') {
                        $('#cpassval').val("1");
                        //   alert('change cpassval to 1');
                    } else {
                        $('#cpassval').val("0");
                    }
                    CheckPasswordValidity();
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  Check Current Password : " + thrownError);
                }
            });
        }
        function ChangePassword() {
            $('#form-ChangePassword').submit();
        }
        function ClearChangePassword() {
            $('#form-ChangePassword')[0].reset();

        }

        $('#form-ChangePassword').submit(function (e) {
            var returnmess = "", title = "", color = "", mess = "", userid = "";
            var form = $(this);
            var dataArray = $(form).serializeArray();
            $.ajax({
                url: 'ChangePassword',
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
                        // window.location.href = "index.jsp";

                        if (userType > 3) {
                            window.location.href = "index.jsp";
                            //LogOut();
                        } else {
                            //  LogOut();
                            window.location.href = "Login.jsp";
                        }

                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error! Change Password (New Password)" + thrownError);
                }
            });
            e.preventDefault();
        });
    </script>

</html>
