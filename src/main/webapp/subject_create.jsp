<%--
  Created by IntelliJ IDEA.
  User: LAM
  Date: 23/06/2025
  Time: 2:07 CH
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Create Subject</title>
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

        .is-invalid {
            border-color: #dc3545;
        }

        .text-danger {
            color: #dc3545;
        }
    </style>
</head>
<body class="app sidebar-mini">
<!-- Navbar-->
<jsp:include page="./layout/manage/header.jsp"/>

<!-- Sidebar menu-->
<jsp:include page="./layout/manage/sidebar.jsp">
    <jsp:param name="currentPage" value="subject"/>
</jsp:include>
<%--User profile--%>
<jsp:include page="./user_profile.jsp"/>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">CREATE NEW SUBJECT</h3>
                <div class="tile-body">
                    <!-- Display error message if any -->
                    <c:if test="${not empty requestScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${requestScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="create-subject" method="post" enctype="multipart/form-data" id="subjectForm">
                        <div class="row align-items-start">
                            <div class="row col-md-8">
                                <div class="mb-3">
                                    <label class="col-form-label" for="subjectName">Subject name: <span class="text-danger">*</span></label>
                                    <input class="form-control" id="subjectName" type="text"
                                           name="subjectName" required>
                                </div>
                                <div class="mb-3 col-md-6">
                                    <label class="form-label" for="subjectCategory">Subject category: <span class="text-danger">*</span></label>
                                    <select class="form-control" id="subjectCategory" name="subjectCategory" required>
                                        <option value="">--Choose subject category--</option>
                                        <c:forEach items="${requestScope.categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <c:if test="${sessionScope.user.roleName == 'Admin'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="form-label" for="status">Status: <span class="text-danger">*</span></label>
                                        <select class="form-control" id="status" name="status" disabled>
                                            <option value="Unpublished">Unpublished</option>
                                        </select>
                                    </div>
                                </c:if>

                                <div class="mb-3 mt-1">
                                    <input type="checkbox" name="featured" id="featured" class="form-check-input">
                                    <label class="form-check-label" for="featured">Featured Subject</label>
                                </div>

                                <c:if test="${sessionScope.user.roleName == 'Admin'}">
                                    <div class="mb-3 col-md-6">
                                        <label class="col-form-label" for="owner">Owner: <span class="text-danger">*</span></label>
                                        <select class="form-control" id="owner" name="owner" required>
                                            <option value="">--Choose owner--</option>
                                            <c:forEach items="${requestScope.experts}" var="expert">
                                                <option value="${expert.id}">${expert.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:if>

                                <div class="mb-3 col-md-6">
                                    <label class="col-form-label" for="thumbnail">Thumbnail: <span class="text-danger">*</span></label>
                                    <input class="form-control" id="thumbnail" type="file" name="thumbnail"
                                           accept="image/*" required>
                                </div>
                            </div>

                            <div class="col-md-3 ms-4">
                                <div class="mb-3 col-md-12">
                                    <label class="col-form-label" id="thumbnailPreviewLabel" for="thumbnailPreview" style="display:none">
                                        Thumbnail preview:
                                    </label>
                                    <img style="max-height: 250px; max-width: 375px; display:none"
                                         alt="Thumbnail preview"
                                         id="thumbnailPreview" src=""/>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="subjectDescription">Description: <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="subjectDescription" rows="3"
                                          name="subjectDescription" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="tagLine">Tag line: <span class="text-danger">*</span></label>
                                <input class="form-control" id="tagLine" type="text" name="tagLine" required>
                            </div>

                            <div class="mb-3" id="subjectDescriptionImageContainer">
                                <label class="col-form-label">Description images:</label>

                                <!-- Template for new description images -->
                                <div class="description-pair" id="template" style="display: none">
                                    <button type="button"
                                            class="btn btn-sm btn-danger shadow-sm remove-group-btn float-end">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                    <div class="mb-2 row">
                                        <div class="col-md-6">
                                            <label class="form-label">Image:</label>
                                            <input type="file" class="form-control subjectDescriptionImageInput"
                                                   name="subjectDescriptionImageInput" accept="image/*">
                                            <label class="form-label mt-2">Caption:</label>
                                            <textarea class="form-control subjectDescriptionImageCaption"
                                                      name="subjectDescriptionImageCaption" rows="5"></textarea>
                                        </div>
                                        <div class="col-md-6 d-flex justify-content-center">
                                            <img src="" class="description_img_preview" alt="" style="display:none">
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
                                <button class="btn btn-primary" type="submit">Create Subject</button>
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
<%@include file="common/jsload.jsp" %>

<%--Script to get toastNotification from CreateSubjectServlet to show and remove it in session--%>
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
        const form = document.getElementById("subjectForm");

        // Show preview thumbnail when upload file
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

        // Form validation
        form.addEventListener('submit', function (e) {
            let isValid = true;
            let firstInvalidElement = null;

            // Clear previous error states
            clearErrorStates();

            // Get form values
            const subjectName = document.getElementById("subjectName").value.trim();
            const subjectCategory = document.getElementById("subjectCategory").value;
            const subjectDescription = document.getElementById("subjectDescription").value.trim();
            const tagLine = document.getElementById("tagLine").value.trim();
            const thumbnailFile = document.getElementById("thumbnail").files.length > 0;

            // Check if user is admin
            const isAdmin = ${sessionScope.user.roleName == 'Admin'};
            let status = "";
            let owner = "";

            if (isAdmin) {
                const statusElement = document.getElementById("status");
                const ownerElement = document.getElementById("owner");
                if (statusElement) status = statusElement.value;
                if (ownerElement) owner = ownerElement.value;
            }

            // Validate required fields
            if (!subjectName) {
                setFieldError("subjectName", "Subject name cannot be empty.");
                isValid = false;
            }

            if (!subjectCategory) {
                setFieldError("subjectCategory", "Please select a category.");
                isValid = false;
            }

            if (!subjectDescription) {
                setFieldError("subjectDescription", "Description cannot be empty.");
                isValid = false;
            }

            if (!tagLine) {
                setFieldError("tagLine", "Tag line cannot be empty.");
                isValid = false;
            }

            if (!thumbnailFile) {
                setFieldError("thumbnail", "Please select a thumbnail image.");
                isValid = false;
            }

            // Admin-specific validations
            if (isAdmin) {
                if (!status) {
                    setFieldError("status", "Please select a status.");
                    isValid = false;
                }
                if (!owner) {
                    setFieldError("owner", "Please select an owner.");
                    isValid = false;
                }
            }

            // Validate description images
            const descriptionPairs = document.querySelectorAll('.description-pair:not(#template)');
            descriptionPairs.forEach((pair, index) => {
                const fileInput = pair.querySelector('.subjectDescriptionImageInput');
                const captionInput = pair.querySelector('.subjectDescriptionImageCaption');

                if (fileInput && captionInput) {
                    const hasFile = fileInput.files.length > 0;
                    const hasCaption = captionInput.value.trim() !== '';

                    // If there's a caption but no image, that's invalid
                    if (hasCaption && !hasFile) {
                        alert('Description image #' + (index + 1) + ': Caption without image is not allowed. Please add an image or remove the caption.');
                        isValid = false;
                        return;
                    }

                    // If there's neither image nor caption, remove the pair
                    if (!hasFile && !hasCaption) {
                        pair.remove();
                    }
                }
            });

            if (!isValid) {
                e.preventDefault();
                // Focus on first invalid field
                const firstInvalid = document.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });

        // Helper functions
        function clearErrorStates() {
            const invalidFields = document.querySelectorAll('.is-invalid');
            invalidFields.forEach(field => field.classList.remove('is-invalid'));

            const errorMessages = document.querySelectorAll('.error-message');
            errorMessages.forEach(msg => msg.remove());
        }

        function setFieldError(fieldId, message) {
            const field = document.getElementById(fieldId);
            if (field) {
                field.classList.add('is-invalid');

                const errorDiv = document.createElement('div');
                errorDiv.classList.add('text-danger', 'mt-1', 'error-message');
                errorDiv.textContent = message;
                field.parentNode.appendChild(errorDiv);
            }
        }

        // Add new description image pair
        document.getElementById('addNewSubjectDescriptionImage').addEventListener('click', function() {
            addDescriptionPair();
        });

        function addDescriptionPair() {
            const container = document.getElementById('subjectDescriptionImageContainer');
            const template = document.getElementById('template').cloneNode(true);
            template.removeAttribute("id");
            template.style.display = 'block';

            // Add remove functionality
            const removeButton = template.querySelector('.remove-group-btn');
            removeButton.addEventListener('click', function() {
                const confirmed = confirm('Are you sure you want to remove this description image?');
                if (confirmed) {
                    template.remove();
                }
            });

            // Add image preview functionality
            const imageInput = template.querySelector('.subjectDescriptionImageInput');
            const imagePreview = template.querySelector('.description_img_preview');

            imageInput.addEventListener('change', function() {
                const file = this.files[0];
                if (file) {
                    imagePreview.src = URL.createObjectURL(file);
                    imagePreview.style.display = 'block';
                } else {
                    imagePreview.src = '';
                    imagePreview.style.display = 'none';
                }
            });

            container.appendChild(template);
        }
    });
</script>
</body>
</html>