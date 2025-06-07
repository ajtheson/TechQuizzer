<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 05/06/2025
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%@include file="common/headload.jsp" %>
    <title>Register Subject</title>
    <style>
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
        .subject-thumbnail {
            width: 100%;
            aspect-ratio: 1 / 1;
            object-fit: cover;
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
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>TechQuizzer</h1>
    </div>

    <div class="login-box" style="min-height: 555px; min-width: 900px;">
        <div class="row">
            <!-- Form -->
            <div class="col-md-7">
                <form class="login-form row" action="guest_register_subject" method="post">
                    <h3 class="login-head"><i class="bi bi-journal-plus me-2"></i>REGISTER SUBJECT</h3>
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

                        <input type="hidden" name="subjectId" value="${subject.id}">
                        <input type="hidden" name="packageId" id="selectedPackageId" value="">
                        <!-- Information Inputs -->
                        <c:set var="info" value="${requestScope.information}"/>
                        <div class="mb-3" style="display: flex; gap: 12px">
                            <div class="form-group" style="flex: 1">
                                <input
                                        class="form-control"
                                        type="text"
                                        placeholder="Full name"
                                        autofocus
                                        required
                                        name="name"
                                        value="${info.getName()}"
                                />
                            </div>
                            <div class="form-group" style="flex: 1">
                                <select class="form-control" required name="gender">
                                    <option value="" disabled selected>Gender</option>
                                    <option value="male" ${info.getGenderString() == 'male' ? 'selected' : ''}>Male</option>
                                    <option value="female" ${info.getGenderString() == 'female' ? 'selected' : ''}>Female</option>
                                    <option value="other" ${info.getGenderString() == 'other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3" style="display: flex; gap: 12px">
                            <div class="form-group" style="flex: 1">
                                <input
                                        class="form-control"
                                        type="email"
                                        placeholder="Email"
                                        autofocus
                                        required
                                        name="email"
                                        pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                        title="Please enter a valid email address (e.g., example@email.com)"
                                        value="${info.getEmail()}"
                                />
                            </div>
                            <div class="form-group" style="flex: 1">
                                <input
                                        class="form-control"
                                        type="text"
                                        placeholder="Mobile"
                                        autofocus
                                        required
                                        name="mobile"
                                        pattern="0\d{9}"
                                        title="Mobile number must start with 0 and be exactly 10 digits"
                                        value="${info.getMobile()}"
                                />
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <input
                                    class="form-control"
                                    type="text"
                                    placeholder="Address"
                                    autofocus
                                    required
                                    name="address"
                                    value="${info.getAddress()}"
                            />
                        </div>
                        <c:if test="${fn:length(fn:trim(requestScope.error)) > 0}">
                            <div class="alert alert-danger text-center" role="alert">
                                    ${requestScope.error}
                            </div>
                        </c:if>

                        <!-- Register Button -->
                        <div class="row justify-content-end">
                            <div class="col-auto">
                                <div class="d-flex gap-2">
                                    <button class="btn btn-primary">
                                        <i class="bi bi-check2-circle me-2 fs-5"></i> Register
                                    </button>
                                    <a href="home" class="btn btn-light border border-secondary text-dark">Cancel</a>
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
        selectPackage(packages[0].id);
    }

    function selectPackage(id) {
        const salePriceSpan = document.getElementById("salePrice");
        const listPriceSpan = document.getElementById("listPrice");
        const selectedInput = document.getElementById("selectedPackageId");

        packages.forEach(p => {
            const btn = document.getElementById("btn-" + p.id);
            if (p.id === id) {
                salePriceSpan.innerText = "₫" + p.salePrice.toLocaleString();
                listPriceSpan.innerText = "₫" + p.listPrice.toLocaleString();
                btn.classList.add("active");
                selectedInput.value = p.id;
            } else {
                btn.classList.remove("active");
            }
        });
    }
</script>
<%@include file="layout/footer.jsp"%>
<%@include file="common/jsload.jsp" %>
</body>
</html>
