<%-- 
    Document   : POSForm
    Created on : 01 7, 21, 10:25:00 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Onboarding Options</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <form class="user">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Merchant Type</label>
                                <select class="form-control form-control-range">
                                    <option>Merchant</option>
                                    <option>Micro</option>
                                </select>
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Merchant Class</label>
                                <select class="form-control form-control-range">
                                    <option>Supermarket</option>
                                    <option>E-commerce</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Rate Type</label>
                                <select class="form-control form-control-range">
                                    <option>Fixed</option>
                                    <option>Percent</option>
                                </select>
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Rate Value</label>
                                <input type="text" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. 100.00 or 1%">
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>

    </div>

    <!--Business Details-->
    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Partner Institution Details</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <form class="user">
                        <div class="form-group row">

                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Corporate/ Business Name</label>
                                <input type="text" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. AllHome">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Type of Business</label>
                                <select class="form-control form-control-range">
                                    <option>Fixed</option>
                                    <option>Percent</option>
                                </select>
                            </div>
                            <div class="col-sm-12 mb-6 mb-sm-0">
                                <label>Head Office Address</label>
                                <input type="text" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Mandaluyong City">
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>

    </div>
    <!--Authorized Signature-->
    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Authorized Signature</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <label><b>Authorized Signature 1</b></label>
                    <form class="user">
                        <div class="form-group row col-12">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Accounting">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. 0912-345-6789">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                        </div>
                    </form>
                    <label><b>Authorized Signature 2</b></label>
                    <form class="user">
                        <div class="form-group row  col-12">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Accounting">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. 0912-345-6789">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <!--Branch and Pos Terminal-->
    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Branch and Pos Terminal</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <form class="user" id="Branches-Div">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Registered Address</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>No. of Terminals</label>
                                <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. 1">
                            </div>

                            <div class="col-sm-12 mb-12 mb-sm-0">
                                <br>
                                <label>Terminals</label>
                                <table width="100%">
                                    <thead class="text-center">
                                        <tr>
                                            <th>Terminal ID</th>
                                            <th>Type</th>
                                            <th>Telco Provider</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                        </tr>
                                        <tr>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                            <td> <input type="number" class="form-control form-control-range" id="exampleInputEmail"
                                                        placeholder=""></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </form>

                    <a onclick="AddNewBranch()" class="btn btn-primary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-plus-square"></i>
                        </span>
                        <span class="text">Add New Registered Address</span>
                    </a>
                </div>
            </div>
        </div>

    </div>

    <!--Contact Person-->
    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Contact Person</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <form class="user">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Name</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Juan Dela Cruz">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Designation</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. Accounting">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Department</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. 0912-345-6789">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Contact Number</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Fax Number</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Email Address</label>
                                <input type="email" class="form-control form-control-range" id="exampleInputEmail"
                                       placeholder="ex. juandelacruz@phil.ph">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <!--Attachements-->
    <div class="col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
               role="button" aria-expanded="true" aria-controls="collapseCardExample">
                <h6 class="m-0 font-weight-bold text-primary">Attachments</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse show" id="collapseCardExample">
                <div class="card-body">
                    <form class="user" id="Attachments-Div">
                        <div class="form-group row">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Attachment Name</label>
                                <input type="type" class="form-control form-control-range" name="attachement_name" id="exampleInputEmail" placeholder="Sample attachment">
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                <label>Attachment File</label>
                                <input type="file" class="form-control" name="attachement_file"id="exampleInputEmail">
                            </div>

                        </div>
                    </form>
                    <a onclick="AddNewAttachment()" class="btn btn-primary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-plus-square"></i>
                        </span>
                        <span class="text">Add New Attachement</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12">

        <a href="login.html" class="btn btn-primary btn-user btn-block">
            Register Account
        </a>

    </div>
</html>
