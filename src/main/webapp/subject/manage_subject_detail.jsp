<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 14-Jun-25
  Time: 3:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%@include file="../common/headload.jsp" %>
    <title>Subject detail</title>
    <style>
        .image-item img {
            width: 300px;
            height: auto;
            margin-right: 10px;
        }

        .description-pair {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            background-color: #D0CECE;
        }

        .description_img_preview {
            margin-top: 10px;
            max-height: 250px;
            max-width: 400px;
        }
    </style>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="../layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="../layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="subject"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="../user/user_profile.jsp"/>
<main class="app-content">
    <div class="app-title d-flex align-items-center justify-content-between">
        <h1 class="mb-0">
            <i class="bi bi-journal-bookmark"></i> Subject details id ${requestScope.subject.id}
        </h1>
        <div class="btn-group ms-3">
            <a href="edit-subject?subject_id=${requestScope.subject.id}" class="btn btn-outline-primary active fw-bold">Overview</a>
            <a href="subject-dimension?id=${requestScope.subject.id}" class="btn btn-outline-primary">Dimension</a>
            <a href="get_price_package?subject_id=${requestScope.subject.id}" class="btn btn-outline-primary">Price
                Package</a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Overview</h3>
                <div class="tile-body">
                    <form action="edit-subject" method="post" enctype="multipart/form-data" id="subjectForm">
                        <div class="row align-items-start">
                            <div class="row col-md-8">
                                <div class="mb-3" hidden>
                                    <label class="col-form-label" for="subjectId">Id:</label>
                                    <input class="form-control" id="subjectId" type="text"
                                           value="${empty requestScope.subject.id ? '' : requestScope.subject.id}"
                                           name="subjectId">
                                </div>
                                <div class="mb-3">
                                    <label class="col-form-label" for="subjectName">Subject name:</label>
                                    <input class="form-control" id="subjectName" type="text"
                                           value="${empty requestScope.subject.name ? '' : requestScope.subject.name}"
                                           name="subjectName">
                                </div>
                                <div class="mb-3 col-md-6">
                                    <label class="form-label" for="subjectCategory">Subject category:</label>
                                    <select class="form-control" id="subjectCategory" name="subjectCategory">
                                        <option value="">--Choose subject category--</option>
                                        <c:forEach items="${requestScope.categories}" var="category">
                                            <option value="${category.id}" ${requestScope.subject.categoryId == category.id ? 'selected="selected"' : ''}>${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <c:if test="${sessionScope.user.roleName == 'Admin'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="form-label" for="status">Status:</label>
                                        <select class="form-control" id="status" name="status">
                                            <option value="">--Choose status--</option>
                                            <option value="Published" ${requestScope.subject.published ? 'selected' : ''}>
                                                Published
                                            </option>
                                            <option value="Unpublished" ${requestScope.subject.published ? '' : 'selected'}>
                                                Unpublished
                                            </option>
                                        </select>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.user.roleName == 'Expert'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="form-label" for="statusDisabled">Status:</label>
                                        <input class="form-control" type="text" id="statusDisabled"
                                               value="${requestScope.subject.published ? 'Published' : 'Unpublished'}"
                                               name="statusDisabled" disabled>
                                        <input class="form-control" id="status" type="text"
                                               value="${requestScope.subject.published ? 'Published' : 'Unpublished'}"
                                               name="status" hidden>
                                    </div>
                                </c:if>
                                <div class="mb-3 mt-1">
                                    <input type="checkbox" name="featured" id="featured"
                                           class="form-check-input" ${requestScope.subject.featuredSubject ? 'checked' : ''}>
                                    <label class="form-check-label" for="featured">Featured Subject</label>
                                </div>
                                <c:if test="${sessionScope.user.roleName == 'Admin'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="col-form-label" for="owner">Owner:</label>
                                        <select class="form-control" id="owner" name="owner">
                                            <option value="">--Choose owner--</option>
                                            <c:forEach items="${requestScope.experts}" var="expert">
                                                <option value="${expert.id}" ${expert.id == requestScope.subject.ownerId ? 'selected' : ''}>${expert.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.user.roleName == 'Expert'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="col-form-label" for="ownerDisabled">Owner:</label>
                                        <select class="form-control" id="ownerDisabled" name="ownerDisabled" disabled>
                                            <c:forEach items="${requestScope.experts}" var="expert">
                                                <option value="${expert.id}" ${expert.id == requestScope.subject.ownerId ? 'selected' : ''}>${expert.name}</option>
                                            </c:forEach>
                                        </select>
                                        <select class="form-control" id="owner" name="owner" hidden>
                                            <c:forEach items="${requestScope.experts}" var="expert">
                                                <option value="${expert.id}" ${expert.id == requestScope.subject.ownerId ? 'selected' : ''}>${expert.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:if>
                                <div class="mb-3 col-md-6">
                                    <label class="col-form-label" for="thumbnail">Thumbnail:</label>
                                    <input class="form-control" id="thumbnail" type="file" name="thumbnail"
                                           accept="image/*">
                                </div>
                            </div>
                            <div class="col-md-3 ms-4">
                                <div class="mb-3 col-md-12">
                                    <label class="col-form-label" id="thumbnailPreviewLabel" for="thumbnailPreview"
                                           style="${not empty requestScope.subject.thumbnail ? 'display:block' : 'display:none'}">Thumbnail
                                        preview:</label>
                                    <img style="max-height: 250px; max-width: 375px; ${not empty requestScope.subject.thumbnail ? 'display:block' : 'display:none'}"
                                         alt="Thumbnail preview"
                                         id="thumbnailPreview"
                                         src="assets/images/thumbnail/subject/${requestScope.subject.thumbnail}"/>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="subjectDescription">Description:</label>
                                <textarea class="form-control" id="subjectDescription" rows="3"
                                          name="subjectDescription">${empty requestScope.subject.longDescription ? '' : requestScope.subject.longDescription}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" for="tagLine">Tag line:</label>
                                <input class="form-control" id="tagLine" type="text" name="tagLine"
                                       value="${not empty requestScope.subject.tagLine ? requestScope.subject.tagLine: ''}">
                            </div>
                            <div class="mb-3" id="subjectDescriptionImageContainer">
                                <label class="col-form-label" for="">Description images:</label>
                                <c:forEach items="${requestScope.subjectDescriptionImages}" var="subjectDescriptionImage">
                                    <div class="description-pair existed">
                                        <input type="hidden" name="existedImageId" value="${subjectDescriptionImage.id}">
                                        <button type="button"
                                                class="btn btn-sm btn-danger shadow-sm remove-group-btn float-end">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                        <div class="mb-2 row">
                                            <div class="col-md-6">
                                                <label class="form-label"
                                                       for="subjectDescriptionImageInput">Image:</label>
                                                <input type="file" class="form-control" name="subjectDescriptionImageInput" accept="image/*"
                                                       id="subjectDescriptionImageInput">
                                                <label class="form-label mt-2" for="subjectDescriptionImageCaption">Caption:</label>
                                                <textarea class="form-control" name="subjectDescriptionImageCaption" rows="5"
                                                          id="subjectDescriptionImageCaption">${subjectDescriptionImage.caption}</textarea>
                                            </div>
                                            <div class="col-md-6 d-flex justify-content-center">
                                                <img src="assets/images/subject_description/${subjectDescriptionImage.url}" class="description_img_preview"
                                                     id="subjectDescriptionImagePreview" alt="Preview">
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="description-pair" id="template" style="display: none">
                                    <button type="button"
                                            class="btn btn-sm btn-danger shadow-sm remove-group-btn float-end">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                    <div class="mb-2 row">
                                        <div class="col-md-6">
                                            <label class="form-label" for="subjectDescriptionImageInput">Image:</label>
                                            <input type="file" class="form-control" name="subjectDescriptionImageInput" accept="image/*"
                                                   id="subjectDescriptionImageInput">
                                            <label class="form-label mt-2"
                                                   for="subjectDescriptionImageCaption">Caption:</label>
                                            <textarea class="form-control" name="subjectDescriptionImageCaption" rows="5"
                                                      id="subjectDescriptionImageCaption"></textarea>
                                        </div>
                                        <div class="col-md-6 d-flex justify-content-center">
                                            <img src="" class="description_img_preview" alt=""
                                                 id="subjectDescriptionImagePreview">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                                <button class="btn btn-outline-success" type="button"
                                        id="addNewSubjectDescriptionImage">Add new description Image
                                </button>
                            </div>

                            <div class="mt-3 d-grid gap-2 d-md-flex justify-content-md-start">
                                <button class="btn btn-primary" type="submit">Save</button>
                                <a href="manage-subject" class="btn btn-secondary">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Toast Notification -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999" data-bs-delay="2000">
    <div id="toast" class="toast align-items-center border-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <!-- Message will be injected here -->
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>

<!-- Essential javascripts for application to work-->
<%@include file="../common/jsload.jsp" %>

<%--Script to get toastNotification from CreateSettingServlet to show and remove it in session--%>
<%
    String toastNotification = (String) session.getAttribute("toastNotification");
    if (toastNotification != null) {
        boolean isSuccess = toastNotification.contains("successfully");
        session.removeAttribute("toastNotification");
%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toastElement = document.getElementById('toast');
        const toastElementBody = toastElement.querySelector('.toast-body');

        toastElementBody.textContent = "<%= toastNotification %>";
        toastElement.classList.remove('<%= isSuccess ? "text-bg-danger" : "text-bg-success" %>');
        toastElement.classList.add('<%= isSuccess ? "text-bg-success" : "text-bg-danger" %>');

        const toast = new bootstrap.Toast(toastElement, {
            autohide: true,
            delay: 2000
        });
        toast.show();
    });
</script>
<%
    }
%>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const thumbnail = document.getElementById("thumbnail");
        const preview = document.getElementById("thumbnailPreview");
        const previewLabel = document.getElementById("thumbnailPreviewLabel");
        const existingRemoveButtons = document.querySelectorAll('.remove-group-btn');
        const descriptionImages = document.querySelectorAll('.description-pair');

        //Show preview thumbnail when upload file
        thumbnail.addEventListener("change", function (e) {
            const files = e.target.files;
            if (files.length > 0) {
                const imgURL = URL.createObjectURL(files[0]);
                preview.src = imgURL;
                preview.style.display = "block";
                previewLabel.style.display = "block";
            } else {
                preview.src = "";
                preview.style.display = "none";
                previewLabel.style.display = "none";
            }
        });

        //show preview of upload exist image description
        descriptionImages.forEach(descriptionImage => {
            const imageInput = descriptionImage.querySelector('#subjectDescriptionImageInput');
            const imagePreview = descriptionImage.querySelector('#subjectDescriptionImagePreview');

            imageInput.addEventListener('change', function () {
                const file = this.files[0];
                if (file) {
                    imagePreview.src = URL.createObjectURL(file);
                    imagePreview.style.display = 'block';
                } else {
                    imagePreview.src = '';
                    imagePreview.style.display = 'none';
                }
            });
        })

        //Add event remove of existing description image
        existingRemoveButtons.forEach(button => {
            button.addEventListener('click', function () {
                const parent = this.closest('.description-pair');
                const confirmed = confirm('Are you sure you want to remove this description image?');
                if(confirmed){
                    parent.remove(); // Xóa phần tử cha chứa nó
                }
            });
        });

        // Thêm vào sự kiện validate khi submit
        document.querySelector('#subjectForm').addEventListener('submit', function (e) {
            //Handle validate subject name, subject description and subject tag line
            const subjectNameInputElement = document.getElementById("subjectName");
            const subjectNameValue = subjectNameInputElement.value.trim();
            const subjectCategoryInputElement = document.getElementById("subjectCategory");
            const subjectCategoryValue = subjectCategoryInputElement.value.trim();
            const statusInputElement = document.getElementById("status");
            const statusValue = statusInputElement.value.trim();
            const ownerInputElement = document.getElementById("owner");
            const ownerValue = ownerInputElement.value.trim();
            const subjectDescriptionInputElement = document.getElementById("subjectDescription");
            const subjectDescriptionValue = subjectDescriptionInputElement.value.trim();
            const tagLineInputElement = document.getElementById("tagLine");
            const tagLineValue = tagLineInputElement.value.trim();
            const descriptionPairs = document.querySelectorAll('.description-pair:not(#template)');
            let isValid = true;
            let firstInvalidElement = null;
            const isAdmin = ${sessionScope.user.roleName == 'Admin'};

            // Clear previous error states
            const clearErrors = () => {
                const invalidFields = document.querySelectorAll('.is-invalid');
                invalidFields.forEach(field => field.classList.remove('is-invalid'));

                const errorMessages = document.querySelectorAll('.text-danger.mt-1');
                errorMessages.forEach(msg => msg.remove());
            };
            clearErrors();

            if (subjectNameValue === "") {
                e.preventDefault();
                subjectNameInputElement.classList.add("is-invalid");
                if (!document.getElementById("name-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "name-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Subject name cannot be empty or just spaces.";
                    subjectNameInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = subjectNameInputElement;
            }
            if (subjectCategoryValue === "") {
                e.preventDefault();
                subjectCategoryInputElement.classList.add("is-invalid");
                if (!document.getElementById("category-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "category-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Please select a category for this subject.";
                    subjectCategoryInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = subjectCategoryInputElement;
            }
            if (statusValue === "" && isAdmin) {
                e.preventDefault();
                statusInputElement.classList.add("is-invalid");
                if (!document.getElementById("status-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "status-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Please select a status for this subject.";
                    statusInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = statusInputElement;
            }
            if (ownerValue === ""  && isAdmin) {
                e.preventDefault();
                ownerInputElement.classList.add("is-invalid");
                if (!document.getElementById("owner-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "owner-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Please select an owner for this subject.";
                    ownerInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = ownerInputElement;
            }
            if (subjectDescriptionValue === "") {
                e.preventDefault();
                subjectDescriptionInputElement.classList.add("is-invalid");
                if (!document.getElementById("description-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "description-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Subject description cannot be empty or just spaces.";
                    subjectDescriptionInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = subjectDescriptionInputElement;
            }
            if (tagLineValue === "") {
                e.preventDefault();
                tagLineInputElement.classList.add("is-invalid");
                if (!document.getElementById("tag-line-error")) {
                    const errorDiv = document.createElement("div");
                    errorDiv.id = "tag-line-error";
                    errorDiv.classList.add("text-danger", "mt-1");
                    errorDiv.textContent = "Subject Tag line cannot be empty or just spaces.";
                    tagLineInputElement.parentNode.appendChild(errorDiv);
                }
                if (!firstInvalidElement) firstInvalidElement = tagLineInputElement;
            }

            //Handle description image
            descriptionPairs.forEach(pair => {
                const fileInput = pair.querySelector('#subjectDescriptionImageInput');
                const captionInputElement = pair.querySelector('#subjectDescriptionImageCaption');
                const caption = captionInputElement.value.trim();
                const previewImg = pair.querySelector('#subjectDescriptionImagePreview');

                const hasNewImage = fileInput && fileInput.files.length > 0;
                const hasExistingImage = previewImg && previewImg.src && previewImg.src !== window.location.href;

                if (!hasNewImage && !hasExistingImage && caption !== '') {
                    if (!firstInvalidElement) firstInvalidElement = captionInputElement;
                    isValid = false;
                }
                if(!hasNewImage && !hasExistingImage && caption === ''){
                    pair.remove();
                }
            });
            if (!isValid) {
                alert('Each description must either have an image or both image and caption. Caption-only is not allowed.');
                e.preventDefault(); // Chặn form submit
            }
            if (firstInvalidElement) {
                firstInvalidElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstInvalidElement.focus();
            }
        });
    });

    document.getElementById('addNewSubjectDescriptionImage').addEventListener('click', () => {
        addDescriptionPair()
    });

    function addDescriptionPair() {
        const container = document.getElementById('subjectDescriptionImageContainer')
        const template = document.getElementById('template').cloneNode(true)
        template.removeAttribute("id");
        template.style.display = 'block'

        // Gắn sự kiện xóa cho nút remove trong mỗi template được thêm
        const removeButton = template.querySelector('.remove-group-btn');
        removeButton.addEventListener('click', () => {
            const confirmed = confirm('Are you sure you want to remove this description image?');
            if(confirmed){
                container.removeChild(template); // Xóa phần tử cha khỏi container
            }
        });

        // Preview ảnh khi người dùng chọn ảnh
        const imageInput = template.querySelector('#subjectDescriptionImageInput');
        const imagePreview = template.querySelector('#subjectDescriptionImagePreview');

        imageInput.addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                imagePreview.src = URL.createObjectURL(file);
                imagePreview.style.display = 'block';
            } else {
                imagePreview.src = '';
                imagePreview.style.display = 'none';
            }
        });
        container.appendChild(template)
    }

</script>
</body>
</html>
