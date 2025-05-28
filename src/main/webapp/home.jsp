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
    <style>
        #courseCarousel {
            scroll-behavior: smooth;
            overflow-x: hidden; /* ẩn thanh cuộn ngang */
        }

        #courseCarousel .card {
            min-width: 18rem;
            margin-right: 16px;
        }

        /* Đặt padding để nút không che card */
        .position-relative {
            padding-left: 40px;
            padding-right: 40px;
        }

        /* Nút điều khiển */
        #prevBtn, #nextBtn {
            width: 38px;
            height: 38px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user_profile.jsp"/>

<%--slider--%>
<div style="height: 600px; width: 100%">
    <div id="carouselExample" class="carousel slide">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_1.png" class="d-block w-100"
                     alt="...">
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_2.jpg" class="d-block w-100"
                     alt="...">
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_3.png" class="d-block w-100"
                     alt="...">
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
</div>

<%--featured subject--%>
<div style="margin: 60px 40px">
    <h2 class="text-center mb-3">Featured Subject</h2>

    <div class="position-relative">
        <button class="btn btn-outline-secondary position-absolute top-50 start-0 translate-middle-y z-3" id="prevBtn"
                type="button">
            <i class="bi bi-chevron-left"></i>
        </button>

        <div id="carouselViewport" class="mx-auto" style="overflow: hidden; width: 76rem;">
            <!-- 18rem * 4 + 16px * 3 -->
            <div class="d-flex" id="courseCarousel">
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_1.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 1</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_2.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 2</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_3.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 3</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_4.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 4</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 5</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 6</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 7</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 8</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
                <div class="card me-3" style="width: 18rem;">
                    <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                         alt="subject thumbnail"
                         style="width: 100%; height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Title 9</h5>
                        <p class="card-text">Tag line</p>
                    </div>
                </div>
            </div>
        </div>

        <button class="btn btn-outline-secondary position-absolute top-50 end-0 translate-middle-y z-3" id="nextBtn"
                type="button">
            <i class="bi bi-chevron-right"></i>
        </button>
    </div>

    <div class="text-center mt-3">
        <a href="#">View all</a>
    </div>
</div>

<%--hot post--%>
<div style="margin: 60px 40px">
    <h2 class="text-center mb-3">Hot post</h2>
</div>


<jsp:include page="./layout/footer.jsp"/>

</body>

<script>
    const carousel = document.getElementById("courseCarousel");
    const nextBtn = document.getElementById("nextBtn");
    const prevBtn = document.getElementById("prevBtn");

    const cards = carousel.querySelectorAll(".card");
    const cardWidth = cards[0].offsetWidth + 16; //cards[0].offsetWidth for gain width of first card (include border, padding)
    const cardPerPage = 4
    const totalCards = cards.length;
    const maxPage = Math.ceil(totalCards / cardPerPage) - 1;
    let currentPage = 0;

    function scrollToPage(page) {
        carousel.scrollTo({
            left: page * cardPerPage * cardWidth,
            behavior: 'smooth'
        });
    }

    nextBtn.addEventListener("click", () => {
        if (currentPage >= maxPage) {
            currentPage = 0; // quay lại đầu
        } else {
            currentPage++;
        }
        scrollToPage(currentPage);
    });

    prevBtn.addEventListener("click", () => {
        if (currentPage <= 0) {
            currentPage = maxPage; // về cuối
        } else {
            currentPage--;
        }
        scrollToPage(currentPage);
    });
</script>

</html>
