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
    <jsp:include page="./common/headload.jsp"/>
</head>
<body style="background-color: #E5E5E5">
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<main class="mt-5 mb-3 mx-3">
    <div class="row">
        <div class="col-md-12">
            <div class="tile" style="background-color: rgb(55, 63, 73);">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <a class="back_to_subjects_btn" href="subjects"><h5 class="fw-bold"><i
                                class="bi bi-chevron-left"></i>Back to subjects</h5></a>
                        <h1 class="page-header fw-bold">${requestScope.subject.name}</h1>
                        <h5 class="tagline">${requestScope.subject.tagLine}</h5>
                    </div>
                    <div class="col-md-4 d-flex flex-column">
                        <img class="subject-thumbnail mt-auto"
                             src="assets/images/thumbnail/subject/${requestScope.subject.thumbnail}"
                             alt="Subject_Thumbnail">
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="tile mt-3 pb-3">
                        <h4 class="fw-bold">Description</h4>
                        <span>
                            ${requestScope.subject.longDescription}
                        </span>
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

                        <c:choose>
                            <c:when test="${subject.isRegistered}">
                                <div class="col-md-12 mt-1 mb-3 text-center">
                                    <button class="btn"
                                            style="background-color:#e0e0e0; color:black; border:none; width: 100%"
                                            type="button" disabled>
                                        Registered
                                    </button>
                                    <a href="my_registration">Modify</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-md-12 mt-1 mb-3">
                                    <a class="btn btn-primary btn-lg" style="width: 100%"
                                       href="register_subject?subject_id=${requestScope.subject.id}">Register</a>
                                </div>
                            </c:otherwise>
                        </c:choose>

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

<jsp:include page="./layout/footer.jsp"/>
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

</style>
</html>