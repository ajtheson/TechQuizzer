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
    <title>Subject List</title>
    <jsp:include page="./common/headload.jsp"/>
</head>
<body style="background-color: #E5E5E5">
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>
<!-- Hero Section -->
<section class="hero-section text-white text-center text-md-start py-5 mb-5"
         style="background: linear-gradient(135deg, #00897B, #26C6DA); border-radius: 15px; margin-left: 15px; margin-right: 15px;">
    <div class="container px-4 px-md-5 py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <h1 class="display-5 fw-bold mb-3">
                    Master IT Skills with <span style="text-decoration: underline;">TechQuizzer</span>
                </h1>
                <p class="lead mb-4">
                    Practice programming, algorithms, and core IT concepts with our interactive quiz system.<br>
                    <strong>TechQuizzer</strong> makes it easy to learn and improve — anytime, anywhere, from beginner
                    to advanced.
                </p>
                <a href="#myTabContent" class="btn btn-light btn-lg px-4 rounded-pill shadow">Start Learning</a>
            </div>
        </div>
    </div>
</section>

<!-- Main content -->
<main class="container" id="myTabContent">
    <div class="row user">
        <%--Main content left/Sider--%>
        <div class="col-md-4">
            <div class="card" style="margin-top: 20px">
                <div class="card-body p-0">

                    <!-- Search -->
                    <div class="p-3 border-bottom">
                        <div class="input-group rounded shadow-sm">
                            <input type="search" id="searchInput" class="form-control"
                                   placeholder="Search by name..." value="${requestScope.search}"">
                            <button class="btn btn-primary" type="button" id="searchBtn">Search</button>
                        </div>
                    </div>


                    <!-- Featured Subject -->
                    <div class="p-3 border-bottom hover-bg position-relative d-flex justify-content-between align-items-center">
                        <h6 class="text-uppercase fw-bold mb-0">Featured Subject</h6>
                        <input type="checkbox"
                               class="form-check-input"
                               id="featuredCheckbox"
                        ${requestScope.isFeatured ? 'checked' : ''}>
                    </div>

                    <!-- Subject Category-->
                    <div class="accordion border-bottom" id="accordionCategory">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed p-3 bg-white fw-bold text-uppercase hover-bg"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategory">
                                    Subject Category
                                </button>
                            </h2>
                            <div id="collapseCategory" class="accordion-collapse collapse show">
                                <div class="accordion-body px-3 pt-2 pb-3" id="categoryList">
                                    <c:forEach items="${requestScope.categories}" var="category">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="category"
                                                   value="${category.id}"
                                                   id="${category.id}" ${requestScope.categoryId == category.id ? 'checked' : ''}>
                                            <label for="${category.id}"
                                                   class="form-check-label">${category.name}</label>
                                        </div>
                                    </c:forEach>
                                    <!--Clear Category -->
                                    <div class="d-flex justify-content-center">
                                        <button id="clearCategoryBtn" class="btn btn-outline-primary btn-sm">Clear
                                            Category
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--Show Fields (Accordion Dropdown) -->
                    <div class="accordion border-bottom" id="accordionFields">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed p-3 bg-white fw-bold text-uppercase hover-bg"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#collapseFields">
                                    Show Fields
                                </button>
                            </h2>
                            <div id="collapseFields" class="accordion-collapse collapse show">
                                <div class="accordion-body px-3 pt-2 pb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="thumbnail" checked>
                                        <label class="form-check-label" for="thumbnail">Thumbnail</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="tag-line" checked>
                                        <label class="form-check-label" for="tag-line">Tag Line</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="list-price" checked>
                                        <label class="form-check-label" for="list-price">List Price</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="sale-price" checked>
                                        <label class="form-check-label" for="sale-price">Sale Price</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Need More Advice -->
                    <div class="p-3">
                        <h6 class="mb-3 text-center">
                            Need More Advice? Contact TechQuizzer
                        </h6>
                        <div class="d-flex justify-content-center">
                            <a class="btn btn-outline-primary btn-sm" href="https://zalo.me/0343008127" target="_blank">Ask
                                Now</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--Main content right -->
        <div class="col-md-8">
            <div class="tab-content">
                <%--Part on the subject list--%>
                <div class="mb-3 d-flex align-items-center justify-content-between">
                    <%--Number of subject shown--%>
                    <label class="form-label mb-0" for="type">
                        <c:if test="${totalSubjects == 0}">
                        No data</label>
                    </c:if>
                    <c:if test="${totalSubjects > 0}">
                        Showing ${size*(page-1)+1} to ${size * page > totalSubjects ? totalSubjects: size * page} of ${totalSubjects} items</label>
                    </c:if>
                    <%--Sort order--%>
                    <select class="form-select w-auto ms-2" name="sortOrder" id="sortOrderSelect">
                        <option value="desc" ${sortOrder == 'desc' ? 'selected="selected"' : ''}>Newest to
                            Oldest
                        </option>
                        <option value="asc" ${sortOrder == 'asc' ? 'selected="selected"' : ''}>
                            Oldest to Newest
                        </option>
                    </select>
                </div>

                <%--Subject list--%>
                <div class="tab-pane active" id="user-timeline">
                    <%--Part for one subject--%>
                    <c:forEach items="${subjects}" var="subject">
                        <div class="timeline-post">
                            <div class="row">
                                <div class="subject-media col-md-4">
                                    <a href="get-subject-detail?id=${subject.id}">
                                        <img class="subject-thumbnail"
                                             src="assets/images/thumbnail/subject/${subject.thumbnail}"
                                             alt="Subject_Thumbnail">
                                    </a>
                                </div>
                                <div class="post-content col-md-6">
                                    <h4 class="text-uppercase">${subject.name}</h4>
                                    <p class="subject-tagline">${subject.tagLine}</p>
                                </div>
                                <div class="price_register_button col-md-2">
                                    <p class="text-decoration-line-through subject-list-price">
                                        $${subject.minListPrice}</p>
                                    <p class="fw-bold subject-sale-price">$${subject.minSalePrice}</p>
                                    <a class="btn" style="background-color:#00897B; color:white; border:none;"
                                       href="register_subject?subject_id=${subject.id}"
                                       type="button">Register
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <%--Pagination--%>
            <div class="d-flex align-items-center justify-content-between mb-3">
                <%--Items per page--%>
                <div class="d-flex align-items-center me-3">
                    <label for="size" class="me-2 mb-0">Items per page:</label>
                    <input type="number" min="1" name="size" class="form-control me-2" style="width: 80px;"
                           value="${requestScope.size != 5 ? requestScope.size : 5}" id="sizeInput">
                    <button type="submit" class="btn btn-primary btn-sm" id="sizeBtn">Apply</button>
                </div>

                <%--Page list--%>
                <nav>
                    <ul class="pagination mb-0">
                        <c:if test="${page > 1}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="?page=${requestScope.page - 1}&size=${requestScope.size}&${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.isFeatured ? '&isFeatured=true' : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}&sortOrder=${requestScope.sortOrder}">Previous</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == page ? 'active' : ''}">
                                <a class="page-link"
                                   href="?page=${i}&size=${requestScope.size}&${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.isFeatured ? '&isFeatured=true' : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}&sortOrder=${requestScope.sortOrder}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="?page=${requestScope.page + 1}&size=${requestScope.size}&${not empty requestScope.search ? '&search='.concat(requestScope.search) : ''}${requestScope.isFeatured ? '&isFeatured=true' : ''}${requestScope.categoryId != 0 ? '&categoryId='.concat(requestScope.categoryId) : ''}&sortOrder=${requestScope.sortOrder}">Next</a>
                            </li>
                        </c:if>

                    </ul>
                </nav>
            </div>
        </div>
    </div>
</main>

<script>
    const size = ${requestScope.size};
    const search = "${requestScope.search}";
    const isFeatured = ${requestScope.isFeatured ? 'true' : 'false'};
    const categoryId = ${requestScope.categoryId};
    const sortOrder = "${requestScope.sortOrder}";

    //Handle change item per page
    document.getElementById("sizeBtn").addEventListener("click", (e) => {
        let sizeInput = document.getElementById("sizeInput").value.trim()
        sizeInput = parseInt(sizeInput);
        sizeInput = isNaN(sizeInput) || sizeInput < 1 ? 5 : sizeInput;
        let url = "?page=1&size=" + sizeInput
        if (search.length > 0) {
            url += "&search=" + searchInput
        }
        if (isFeatured) {
            url += "&isFeatured=true"
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
        }
        if (sortOrder != null) {
            url += "&sortOrder=" + sortOrder
        }
        window.location.href = url
    });

    //Handle search by name
    document.getElementById("searchBtn").addEventListener("click", (e) => {
        let searchInput = document.getElementById("searchInput").value.trim()
        let url = "?page=1&size=" + size
        if (searchInput.length > 0) {
            url += "&search=" + searchInput
        }
        if (isFeatured) {
            url += "&isFeatured=true"
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
        }
        if (sortOrder != null) {
            url += "&sortOrder=" + sortOrder
        }
        window.location.href = url
    });

    //handle Featured subject
    document.getElementById("featuredCheckbox").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (e.target.checked) {
            url += "&isFeatured=true"
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
        }
        if (sortOrder != null) {
            url += "&sortOrder=" + sortOrder
        }
        window.location.href = url
    });

    //Handle filter subject by category
    document.getElementById("categoryList").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (isFeatured) {
            url += "&isFeatured=true"
        }
        if (e.target.value != null) {
            url += "&categoryId=" + e.target.value
        }
        if (sortOrder != null) {
            url += "&sortOrder=" + sortOrder
        }
        window.location.href = url
    });

    //handle clear filter subject by category
    document.getElementById("clearCategoryBtn").addEventListener("click", () => {
        let url = "?page=1&size=" + size;
        if (search.length > 0) {
            url += "&search=" + search;
        }
        if (isFeatured) {
            url += "&isFeatured=true";
        }
        if (sortOrder != null) {
            url += "&sortOrder=" + sortOrder;
        }
        window.location.href = url;
    });

    // Handle sort order
    document.getElementById("sortOrderSelect").addEventListener("change", (e) => {
        let url = "?page=1&size=" + size
        if (search.length > 0) {
            url += "&search=" + search
        }
        if (isFeatured) {
            url += "&isFeatured=true"
        }
        if (categoryId !== 0) {
            url += "&categoryId=" + categoryId
        }
        if (e.target.value != null) {
            url += "&sortOrder=" + e.target.value
        }
        window.location.href = url
    });

    function updateFieldVisibility() {
        const showThumbnail = document.getElementById("thumbnail").checked;
        const showTagLine = document.getElementById("tag-line").checked;
        const showListPrice = document.getElementById("list-price").checked;
        const showSalePrice = document.getElementById("sale-price").checked;

        document.querySelectorAll(".subject-media").forEach(el => {
            el.style.display = showThumbnail ? "block" : "none";
        });

        document.querySelectorAll(".subject-tagline").forEach(el => {
            el.style.display = showTagLine ? "block" : "none";
        });

        document.querySelectorAll(".subject-list-price").forEach(el => {
            el.style.display = showListPrice ? "block" : "none";
        });

        document.querySelectorAll(".subject-sale-price").forEach(el => {
            el.style.display = showSalePrice ? "block" : "none";
        });
    }

    // Gán sự kiện thay đổi cho tất cả checkbox
    ["thumbnail", "tag-line", "list-price", "sale-price"].forEach(id => {
        document.getElementById(id).addEventListener("change", updateFieldVisibility);
    });

    // Gọi lần đầu khi trang tải
    document.addEventListener("DOMContentLoaded", updateFieldVisibility);
</script>


<jsp:include page="./layout/footer.jsp"/>
</body>
<style>
    /* Xoá bo góc nút accordion */
    .accordion-button {
        border-radius: 0 !important;
    }

    /* Xoá bo góc phần chứa nội dung khi mở ra */
    .accordion-item {
        border-radius: 0 !important;
    }

    .subject-media {
        border: 1px black solid;
        border-radius: 10px;
    }

    .subject-thumbnail {
        width: 250px;
        height: 200px;
        margin-left: 10px;
    }

    .price_register_button {
        display: flex;
        flex-direction: column;
        align-items: flex-end; /* căn tất cả nội dung sang phải */
        height: 200px; /* hoặc 100%, nếu cha có chiều cao xác định */
    }

    .col-md-2 button {
        margin-top: auto; /* đẩy nút xuống dưới cùng */
    }
</style>
</html>
