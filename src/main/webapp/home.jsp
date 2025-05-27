<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 23/05/2025
  Time: 10:44 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>


<div id="carouselExample" class="carousel slide">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="../assets/images/avatar/default.webp" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="../assets/images/avatar/default.webp" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
            <img src="../assets/images/avatar/default.webp" class="d-block w-100" alt="...">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<%--notification--%>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="successToast" class="toast align-items-center text-bg-success border-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Update successfully!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>


</body>

<script>
    document.getElementById('imageInput').addEventListener('change', function () {
        const fileInput = document.getElementById("imageInput");
        const formData = new FormData();
        if (fileInput.files.length > 0) {
            formData.append("image", fileInput.files[0]);
            fetch('upload-avatar', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.querySelector('#avatarForm img').src = 'assets/images/avatar/' + data.newAvatar;
                        const toast = new bootstrap.Toast(document.getElementById('successToast'));
                        toast.show();
                    } else {
                        alert("Upload failed");
                    }
                })
                .catch(error => {
                    console.error('error:', error);
                });
        }
    });

     document.getElementById("form_update_profile").addEventListener("submit", function(e){
         e.preventDefault()

         const form = document.getElementById("form_update_profile")
         const formData = new FormData(form);

         fetch("update-profile", {
             method: "POST",
             body: formData
         })
             .then(response => response.json())
             .then(data => {
                 if (data.success) {
                     const toast = new bootstrap.Toast(document.getElementById('successToast'));
                     toast.show();
                 } else {
                     alert("updated failed");
                 }
             })
             .catch(error => {
                 console.error("Lỗi:", error);
             });
     });

</script>

</html>
