<%-- 
    Document   : Attachments
    Created on : 03 19, 21, 9:21:40 AM
    Author     : IT-Programmer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="js/plugins/dropzone.js"></script>
        <link rel="stylesheet" href="css/plugins/dropzone.css">
    </head>
    <body>
        Attachements
        <form action="UploadAttachements" class="dropzone" id="KBUploader">
            <input type="hidden" name="KBID" id="KBID">
        </form>
        <button  type="button" id="KBFileUploadBTN"></button>
        <script>
             Dropzone.options.KBUploader = {//INITIALIZE THE DROPZONE PLUGIN
                    autoProcessQueue: true,
                    addRemoveLinks: true,
                    parallelUploads: 10,
                    maxFilesize: 50,
                    timeout: 0,
                    init: function () {
                        var submitButtonContractFile2 = document.querySelector("#KBFileUploadBTN");
                        KBUploader = this; // closure
                        submitButtonContractFile2.addEventListener("click", function () {
                            KBUploader.processQueue(); // Tell Dropzone to process all queued files.
                            if (KBUploader.files.length < 1) {
                                $('#KnowledgeBaseModal').modal("toggle");// CLOSE MODAL
                                KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                                $('#KB-NewForm')[0].reset();
                                $('#datatable-KBList').DataTable().ajax.reload();
                            }
                        });
                        this.on("addedfile", function () {
                            // Show submit button here and/or inform user to click it.
                            $('#submit-allcontractfile').show();
                        });
                        this.on("success", function () {
                            $('#KnowledgeBaseModal').modal("toggle");// CLOSE MODAL
                            KBUploader.removeAllFiles(true); // REMOVE ALL FILES
                            $.toaster({message: 'Upload Success!', title: 'Update', priority: 'success'});
                            $('#KB-NewForm')[0].reset();
                            $('#datatable-KBList').DataTable().ajax.reload();
                        });

                    }
                };
        </script>
    </body>
</html>
