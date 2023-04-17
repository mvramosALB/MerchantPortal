<%-- 
    Document   : LogoutModal
    Created on : 01 14, 21, 3:06:12 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Are you to Logout</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary" onclick="LogOut();">Logout</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function LogOut() {
             var returnmess = "", title = "", color = "", mess = "", userid = "";
            $.ajax({
                url: 'LogOutController', // use original page here
                type: 'POST',
                data: {dummy: null},
                success: function (data) {
                    returnmess = data.split(";;");
                    title = returnmess[0];
                    color = returnmess[1];
                    mess = returnmess[2];
                    var usertype = returnmess[3];
                    $.toaster({message: mess, title: title, priority: color});
                    if (title === "Alert") {

                    } else if (title === "Success") {
                        alert(usertype)
                        if(usertype === 1){
                            window.location.href = "index.jsp";
                        }else{
                            window.location.href = "Login.jsp";
                        }
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log("Error!  Scripts (SignOut)" + thrownError);
                }
            });

        }
    </script>
</html>
