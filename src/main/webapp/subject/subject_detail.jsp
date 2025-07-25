<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 10-Jun-25
  Time: 4:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: Ud
  Date: 03-Jun-25
  Time: 1:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Subject Detail</title>
    <jsp:include page="../common/headload.jsp"/>
</head>
<body style="background-color: #E5E5E5">
<jsp:include page="../common/jsload.jsp"/>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../user/user_profile.jsp"/>

<main class="mt-5 mb-3 mx-3">
    <div class="row">
        <div class="col-md-12">
            <div class="tile" style="background-color: rgb(55, 63, 73);">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <a class="back_to_subjects_btn" href="${pageContext.request.contextPath}/subject/list"><h5
                                class="fw-bold"><i
                                class="bi bi-chevron-left"></i>Back to subjects</h5></a>
                        <h1 class="page-header fw-bold">${requestScope.subject.name}</h1>
                        <h5 class="tagline">${requestScope.subject.tagLine}</h5>
                    </div>
                    <div class="col-md-4 d-flex flex-column">
                        <img class="subject-thumbnail mt-auto"
                             src="${pageContext.request.contextPath}/assets/images/thumbnail/subject/${requestScope.subject.thumbnail}"
                             alt="Subject_Thumbnail">
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="tile mt-3 pb-3">
                        <h4 class="fw-bold">Description</h4>
                        <span style="font-size: 15px" class="mt-3">
                            ${requestScope.subject.longDescription}
                        </span>
                    </div>

                    <div class="tile mt-3 pb-3">
                        <h4 class="fw-bold">Subject Description Images</h4>
                        <div class="subject-images-container">
                            <div class="row">
                                <c:forEach items="${requestScope.subjectDescriptionImages}" var="image">
                                    <div class="col-md-4 mb-3">
                                        <img src="${pageContext.request.contextPath}/assets/images/subject_description/${image.url}"
                                             alt="Subject Image"
                                             class="subject-image"
                                             onclick="openImageModal('${pageContext.request.contextPath}/assets/images/subject_description/${image.url}')"
                                        >
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>


                    <div class="tile mt-3 pt-3 pb-3">
                        <h4 class="fw-bold">Price Package</h4>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Duration</th>
                                <th>Description</th>
                                <th>Original price</th>
                                <th>Sale off price</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.pricePackages}" var="pricePackage">
                                <tr>
                                    <td>${pricePackage.name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${pricePackage.duration > 1}">
                                                ${pricePackage.duration} months
                                            </c:when>
                                            <c:otherwise>
                                                ${pricePackage.duration} month
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${pricePackage.description}</td>
                                    <td class="text-muted text-decoration-line-through">$${pricePackage.listPrice}</td>
                                    <td>$${pricePackage.salePrice}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="tile mt-3 pt-3 pb-3">
                        <h4 class="fw-bold">Lesson</h4>
                        <c:forEach items="${requestScope.lessons}" var="lesson">
                            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                <span class="d-flex align-items-center" style="font-size: 15px;">
                                    <i class="bi bi-journal me-2"></i> ${lesson.name}
                                </span>
                                <c:if test="${requestScope.isValidRegistration == true}">
                                    <a class="btn btn-sm btn-outline-primary"
                                       href="${pageContext.request.contextPath}/lesson/detail?id=${lesson.id}">
                                        View lesson
                                    </a>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>

                </div>
                <div class="col-md-4">
                    <div class="tile subject_card row">
                        <div class="col-md-5 sale-price">
                            <p class="fw-bold">From $${requestScope.minSalePrice}</p>
                        </div>
                        <div class="col-md-2 d-flex align-items-center list-price">
                            <p class="text-decoration-line-through text-muted">$${requestScope.minListPrice}</p>
                        </div>
                        <div class="col-md-4 d-flex justify-content-end align-items-center">
                            <span class="discount-badge">
                                Sale of ${requestScope.discount}%
                            </span>
                        </div>
                        <div class="col-md-12 mt-1 mb-3">
                            <c:if test="${requestScope.isValidRegistration == true}">
                                <button class="btn btn-secondary btn-lg" style="width: 100%" disabled>
                                    Registered
                                </button>
                            </c:if>
                            <c:if test="${requestScope.subject.published == false}">
                                <button class="btn btn-secondary btn-lg" style="width: 100%" disabled>
                                    Not available
                                </button>
                            </c:if>
                            <c:if test="${requestScope.isValidRegistration == false && requestScope.subject.published == true}">
                                <a class="btn btn-primary btn-lg" style="width: 100%"
                                   href="${pageContext.request.contextPath}/registration/register_subject?subject_id=${requestScope.subject.id}">Register</a>
                            </c:if>
                        </div>
                        <hr>

                        <div class="col-md-12 mt-1 mb-3 brief-description">
                            <h4 class="fw-bold">This subject includes:</h4>
                            <p class="text-muted"><i class="bi bi-play-circle"></i>Step-by-step tutorial videos</p>
                            <p class="text-muted"><i class="bi bi-journal-text"></i>Comprehensive learning materials</p>
                            <p class="text-muted"><i class="bi bi-code-slash"></i>Practical coding exercises</p>
                            <p class="text-muted"><i class="bi bi-check-lg"></i>Real-world project examples</p>
                        </div>

                        <hr>

                        <div class="col-md-12 mt-1 mb-3">
                            <h6 class="mb-3 text-center">
                                Need More Advice? Contact TechQuizzer
                            </h6>
                            <div class="d-flex justify-content-center">
                                <a class="btn btn-outline-primary btn-sm" href="https://zalo.me/0343008127"
                                   target="_blank">Ask
                                    Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Modal hiển thị ảnh phóng to -->
<div id="imageModal" class="image-modal" onclick="closeImageModal()">
    <div class="modal-content">
        <span class="close-btn" onclick="closeImageModal()">&times;</span>
        <img id="modalImage" class="modal-image" src="" alt="Enlarged Image">
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
    // Hàm mở modal với ảnh được chọn
    function openImageModal(imageSrc) {
        document.getElementById('imageModal').style.display = 'flex';
        document.getElementById('modalImage').src = imageSrc;
        document.body.style.overflow = 'hidden'; // Ngăn scroll khi modal mở
    }

    // Hàm đóng modal
    function closeImageModal() {
        document.getElementById('imageModal').style.display = 'none';
        document.body.style.overflow = 'auto'; // Cho phép scroll lại
    }

    // Đóng modal khi nhấn phím ESC
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeImageModal();
        }
    });

    // Ngăn modal đóng khi click vào ảnh
    document.getElementById('modalImage').addEventListener('click', function(event) {
        event.stopPropagation();
    });
</script>
</body>
<style>
    .subject-thumbnail {
        width: 430px;
        height: 300px;
        margin-left: 10px;
        box-shadow: 0 4px 12px rgba(255, 255, 255, 0.5); /* 👈 đổ bóng trắng nhẹ */
    }

    .tagline, .page-header {
        color: white;
    }

    .tile {
        padding-bottom: 0px;
        margin-bottom: 0px;
    }

    .subject_card {
        margin-left: 7px;
        width: 430px;
        border-top: 1px solid #E5E5E5;
    }

    .subject_card .col-md-5 {
        padding-right: 1%;
    }

    .subject_card .col-md-4 {
        margin-left: 8%;
    }

    .back_to_subjects_btn {
        color: white;
        text-decoration: none;
    }

    .back_to_subjects_btn:hover {
        color: white;
        text-decoration: underline;
    }

    .sale-price {
        font-size: 25px
    }

    .list-price {
        padding-left: 0px;
        font-size: 20px
    }

    .discount-badge {
        color: #00695C;
        padding: 5px;
        border-radius: 5px;
        border: 1px solid grey;
        margin-bottom: 10px;
    }

    .brief-description p {
        margin-bottom: 8px;
        font-size: 15px;
    }

    .brief-description p i {
        padding-right: 25px;
    }

    .subject-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 8px;
        cursor: pointer;
        transition: transform 0.3s ease;
    }

    .subject-image:hover {
        transform: scale(1.05);
    }

    /* CSS cho modal phóng to ảnh */
    .image-modal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.9);
        justify-content: center;
        align-items: center;
        animation: fadeIn 0.3s ease;
    }

    .modal-content {
        position: relative;
        max-width: 90%;
        max-height: 90%;
        text-align: center;
    }

    .modal-image {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(255, 255, 255, 0.1);
        animation: zoomIn 0.3s ease;
    }

    .close-btn {
        position: absolute;
        top: -40px;
        right: 0;
        color: white;
        font-size: 40px;
        font-weight: bold;
        cursor: pointer;
        transition: color 0.3s ease;
        z-index: 10000;
    }

    .close-btn:hover {
        color: #ccc;
        transform: scale(1.1);
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes zoomIn {
        from {
            transform: scale(0.7);
            opacity: 0;
        }
        to {
            transform: scale(1);
            opacity: 1;
        }
    }

    /* Responsive cho modal */
    @media (max-width: 768px) {
        .modal-content {
            max-width: 95%;
            max-height: 95%;
        }

        .close-btn {
            top: -30px;
            font-size: 30px;
        }
    }
</style>
</html>