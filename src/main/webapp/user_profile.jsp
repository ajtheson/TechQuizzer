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
            <div class="modal-body row">
                <div class="col-5 mt-3">
                    <form id="avatarForm" action="upload-avatar" method="post" enctype="multipart/form-data">
                        <div style="width: 170px; height: 200px; margin: auto;">
                            <img src="assets/images/avatar/${sessionScope.user.avatar}" alt="avatar image"
                                 style="width: 100%; height: 100%; object-fit: cover; border: #4d5154 solid 2px"/>
                        </div>

                        <div style="text-align: center; margin-top: 10px;">
                            <input type="file" id="imageInput" name="image" accept="image/*" style="display: none"/>
                            <button type="button" onclick="document.getElementById('imageInput').click()">Change
                                avatar
                            </button>
                        </div>
                    </form>
                </div>
                <div class="col-6">
                    <form id="form_update_profile" action="update-profile" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" name="name" value="${sessionScope.user.name}" class="form-control"
                                   id="fullName" required>
                        </div>

                        <div class="mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select name="gender" id="gender" class="form-select" aria-label="Default select example" required>
                                <option value="male" ${sessionScope.user.gender == true ? 'selected' : ''}>Male</option>
                                <option value="female" ${sessionScope.user.gender == false ? 'selected' : ''}>Female
                                </option>
                                <option value="null" ${sessionScope.user.gender == null ? 'selected' : ''}>Other
                                </option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <span id="email" class="form-control-plaintext"
                                  style="padding: 0px">${sessionScope.user.email}</span>
                        </div>

                        <div class="mb-3">
                            <label for="mobile" class="form-label">Mobile</label>
                            <span id="mobile" class="form-control-plaintext"
                                  style="padding: 0px">${sessionScope.user.mobile}</span>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" name="address" value="${sessionScope.user.address}" class="form-control"
                                   id="address" required>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="document.getElementById('form_update_profile').requestSubmit()">Save changes</button>
            </div>
        </div>
    </div>
</div>

</body>

<script>

    const userProfileModal = document.getElementById('userProfile');
    userProfileModal.addEventListener('show.bs.modal', function () {
        fetch('user-detail', {
            method: 'GET'
        })
            .then(response => response.json())
            .then(data => {
                if (data) {
                    document.getElementById('fullName').value = data.name || '';
                    document.getElementById('address').value = data.address || '';
                    document.getElementById('gender').value = data.gender === true ? 'male' : (user.gender === false ? 'female' : 'null');
                } else {
                    alert("get user failed");
                }
            })
            .catch(error => {
                console.error('Lỗi:', error);
            });
    });

</script>


</html>
