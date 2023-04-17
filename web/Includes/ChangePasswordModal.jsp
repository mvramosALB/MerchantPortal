<%-- 
    Document   : ChangePasswordModal
    Created on : 02 19, 21, 6:41:54 PM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <div class="modal fade" id="ChangePasswordModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <form class="user" id="form-ChangePassword">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span><input hidden id="cpassval" value="0"/><input hidden id="npassval" value="0"/>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input name="cpass" type="password" class="form-control form-control-user  cpass passvalidity" id="cpass" aria-describedby="emailHelp"  placeholder="Enter Current Password"  title="" onchange="CheckCurrentPassword()">
                        
                    </div>
                    <div class="form-group">
                        <input name="newpass" type="password" class="form-control form-control-user  newpass passvalidity" id="newpass" aria-describedby="emailHelp"  placeholder="Enter New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" >
                    </div>
                    <div class="form-group">
                        <input name="cnewpass" type="password" class="form-control form-control-user newpass passvalidity"  id="cnewpass" aria-describedby="emailHelp"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Confirm New Password">
                    </div>
                    <div class="form-group">
                        <div class="custom-control custom-checkbox small">
                            <input onclick="ShowPassword()" type="checkbox" class="custom-control-input" id="customCheck">
                            <label class="custom-control-label" for="customCheck">Show Password </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" onclick="ClearChangePassword();" type="button" data-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary" id="submit-password" disabled type="button" onclick="ChangePassword();">ChangePassword</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    <script>
        function ShowPassword() {
            var x = document.getElementById("newpass");
            var y = document.getElementById("cnewpass");
            var z = document.getElementById("cpass");
            if (x.type === "password") {
                x.type = "text";
                y.type = "text";
                z.type = "text";
            } else {
                x.type = "password";
                y.type = "password";
                z.type = "password";
            }
        }
        
      
    </script>
</html>
