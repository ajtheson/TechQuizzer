<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 26/05/2025
  Time: 2:43 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="modal fade" id="userProfile" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">User Profile</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form class="modal-body row" id="form_update_profile" action="update-profile" method="post"
                  enctype="multipart/form-data">
                <div class="col-5 mt-3">
                    <div style="width: 170px; height: 200px; margin: auto;">
                        <img id="avatarPreview" src="assets/images/avatar/default.webp"
                             alt="preview avatar image"
                             style="width: 100%; height: 100%; object-fit: cover; border: #4d5154 solid 2px"/>
                    </div>

                    <div style="text-align: center; margin-top: 10px;">
                        <input type="file" id="imageInput" name="image" accept="image/*" style="display: none"/>
                        <button type="button" onclick="document.getElementById('imageInput').click()">Change
                            avatar
                        </button>
                    </div>
                </div>
                <div class="col-6">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" name="name" value="" class="form-control"
                               id="fullName" required>
                    </div>

                    <div class="mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select name="gender" id="gender" class="form-select" aria-label="Default select example"
                                required>
                            <option value="male" ${sessionScope.user.gender == true ? 'selected' : ''}>Male</option>
                            <option value="female" ${sessionScope.user.gender == false ? 'selected' : ''}>Female
                            </option>
                            <option value="null" ${sessionScope.user.gender == null ? 'selected' : ''}>Other
                            </option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <span id="emailSpan" class="form-control-plaintext"
                              style="padding: 0px"></span>
                        <input type="hidden" name="email" value="" class="form-control"
                               id="emailInput" required>
                    </div>

                    <div class="mb-3">
                        <label for="mobile" class="form-label">Mobile</label>
                        <span id="mobile" class="form-control-plaintext"
                              style="padding: 0px"></span>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" name="address" value="" class="form-control"
                               id="address" required>
                    </div>
                </div>
            </form>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary"
                        onclick="document.getElementById('form_update_profile').requestSubmit()">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

<%--notification--%>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="toast" class="toast align-items-center border-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">

            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>

</body>

<script>

    const imageInput = document.getElementById('imageInput');
    const userProfileModal = document.getElementById('userProfile');

    userProfileModal.addEventListener('show.bs.modal', function () {
        fetch('user-detail', {
            method: 'GET'
        })
            .then(response => response.json())
            .then(data => {
                if(data){
                    document.getElementById('fullName').value = data.name || '';
                    document.getElementById('address').value = data.address || '';
                    document.getElementById('gender').value = data.gender === true ? 'male' : (data.gender === false ? 'female' : 'null');
                    document.getElementById('emailInput').value = data.email || '';
                    document.getElementById('emailSpan').textContent = data.email || '';
                    document.getElementById('mobile').textContent = data.mobile || '';
                    document.getElementById('avatarPreview').src = 'assets/images/avatar/' + data.avatar
                }else {
                    alert("get user detail failed")
                }
            })
            .catch(error => {
                console.error('Lỗi:', error);
            });
    });

    imageInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (file) {
            const img = document.getElementById("avatarPreview");
            img.src = URL.createObjectURL(file);
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
                const toastElement = document.getElementById('toast');
                const toastElementBody = toastElement.querySelector('.toast-body');
                if (data.status) {
                    toastElementBody.textContent = data.message || 'Update successfully!';
                    toastElement.classList.remove('text-bg-danger');
                    toastElement.classList.add('text-bg-success');
                } else {
                    toastElementBody.textContent = data.message || 'Update failed!';
                    toastElement.classList.remove('text-bg-success');
                    toastElement.classList.add('text-bg-danger');
                }
                const toast = bootstrap.Toast.getOrCreateInstance(toastElement);
                toast.show();
            })
            .catch(error => {
                console.error("Lỗi:", error);
            });
    });

</script>


</html>
