<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <jsp:include page="./layout/header.jsp"/>
    <jsp:include page="./user_profile.jsp"/>
    <title>Modify Registration</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
        }
        .package-btn {
            padding: 6px 12px;
            margin-right: 10px;
            background-color: lightgray;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .package-btn.active {
            border: 2px solid green;
            background-color: white;
            font-weight: bold;
        }
        .package-btn:disabled {
            cursor: not-allowed;
            opacity: 0.6;
        }
        .subject-thumbnail {
            border: 1px black solid;
            border-radius: 10px;
            width: 100%;
            height: 200px;
            margin-left: 10px;
        }
        .package-price {
            font-size: 18px;
            font-weight: bold;
            color: #08645c; /* xanh lá đậm */
        }
        .list-price {
            text-decoration: line-through;
            color: gray;
            font-size: 14px;
            margin-left: 10px;
        }
    </style>
</head>
<body onload="initPackages()">
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>

    <div class="login-box" style="min-height: 465px; min-width: 650px;">
        <div class="row">
            <!-- Form -->
            <div class="col-md-7">
                <form class="login-form row" action="user_modify_registration" method="post" id="modifyForm">
                    <h3 class="login-head"><i class="bi bi-journal-plus me-2"></i> MODIFY REGISTRATION</h3>

                    <!-- Thumbnail -->
                    <div class="col-md-5 text-center">
                        <img class="subject-thumbnail" src="assets/images/thumbnail/subject/${subject.thumbnail}" alt="${subject.name}">
                    </div>

                    <div class="col-md-7">
                        <!-- Subject Title -->
                        <h4>${subject.name}</h4>

                        <!-- Price -->
                        <div class="mb-3 package-price">
                            <span id="salePrice"></span>
                            <span id="listPrice" class="list-price"></span>
                        </div>

                        <!-- Package Selection -->
                        <div class="mb-3">
                            <c:forEach var="p" items="${packages}">
                                <button type="button" class="package-btn mb-2" id="btn-${p.id}"
                                        onclick="selectPackage(${p.id})">${p.name}</button>
                            </c:forEach>
                        </div>

                        <input type="hidden" name="registrationID" value="${requestScope.registrationID}">
                        <input type="hidden" name="packageId" id="selectedPackageId" value="">

                        <c:if test="${fn:length(fn:trim(requestScope.error)) > 0}">
                            <div class="alert alert-danger text-center" role="alert">
                                    ${requestScope.error}
                            </div>
                        </c:if>
                        <c:if test="${fn:length(fn:trim(requestScope.success)) > 0}">
                            <div class="alert alert-success text-center" role="alert">
                                    ${requestScope.success}
                            </div>
                        </c:if>

                        <!-- Register Button -->
                        <div class="row justify-content-end">
                            <div class="col-auto">
                                <div class="d-flex gap-2">
                                    <button id="submitBtn" class="btn btn-primary" disabled>
                                        <i class="bi bi-check2-circle me-2 fs-5"></i> Update
                                    </button>
                                    <a href="my_registration" class="btn btn-light border border-secondary text-dark">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    let packages = [];
    // userChoice là packageId user đang đăng ký
    let userChoice = ${userChoice != null ? userChoice : -1};

    function initPackages() {
        packages = [
            <c:forEach var="p" items="${packages}" varStatus="loop">
            {
                id: ${p.id},
                name: '${p.name}',
                salePrice: ${p.salePrice},
                listPrice: ${p.listPrice}
            }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        packages.forEach(p => {
            const btn = document.getElementById("btn-" + p.id);
            if (p.id === userChoice) {
                btn.classList.add("active");
                btn.disabled = true; // disable nút user đã chọn
                btn.title = "This package is your current selection and cannot be reselected";
            } else {
                btn.disabled = false;
                btn.classList.remove("active");
            }
        });

        // Chọn gói đầu tiên khác với userChoice để user phải thay đổi
        const firstSelectable = packages.find(p => p.id !== userChoice);
        if (firstSelectable) {
            selectPackage(firstSelectable.id);
            document.getElementById("submitBtn").disabled = false; // bật nút submit khi có gói chọn khác
        } else {
            // Trường hợp userChoice là duy nhất (hiếm), disable luôn nút submit
            document.getElementById("submitBtn").disabled = true;
        }
    }

    function selectPackage(id) {
        if (id === userChoice) {
            // Không cho chọn lại gói hiện tại
            return;
        }

        const salePriceSpan = document.getElementById("salePrice");
        const listPriceSpan = document.getElementById("listPrice");
        const selectedInput = document.getElementById("selectedPackageId");

        packages.forEach(p => {
            const btn = document.getElementById("btn-" + p.id);
            if (p.id === id) {
                salePriceSpan.innerText = "$" + p.salePrice.toLocaleString();
                listPriceSpan.innerText = "$" + p.listPrice.toLocaleString();
                btn.classList.add("active");
                selectedInput.value = p.id;
            } else {
                if (p.id !== userChoice) {
                    btn.classList.remove("active");
                }
            }
        });
    }
</script>

<%@include file="layout/footer.jsp" %>
<%@include file="common/jsload.jsp" %>
</body>
</html>
