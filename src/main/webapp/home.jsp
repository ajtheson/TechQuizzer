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
        #subjectCarousel .card {
            min-width: 18rem;
            margin-right: 16px;
        }

        .position-relative {
            padding-left: 40px;
            padding-right: 40px;
        }

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
    <div id="slider" class="carousel slide">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#slider" data-bs-slide-to="0" class="active" aria-current="true"
                    aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#slider" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#slider" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_1.png" class="d-block w-100"
                     alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Title</h5>
                </div>
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_2.jpg" class="d-block w-100"
                     alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Title</h5>
                </div>
            </div>
            <div class="carousel-item">
                <img style="width: 100%; height: 100%" src="assets/images/slider/slider_3.png" class="d-block w-100"
                     alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Title</h5>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#slider" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#slider" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<%--featured subject--%>
<div style="margin: 150px 40px">
    <h1 class="text-center mb-5">Featured Subject</h1>

    <div class="position-relative">
        <button class="btn btn-outline-secondary position-absolute top-50 start-0 translate-middle-y z-3" id="prevBtn"
                type="button">
            <i class="bi bi-chevron-left"></i>
        </button>

        <div id="carouselViewport" class="mx-auto" style="overflow: hidden; width: 76rem;">
            <!-- 18rem * 4 + 16px * 3 -->
            <div class="d-flex" id="subjectCarousel" style="scroll-behavior: smooth; overflow-x: hidden">
                <a href="subject/1" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_1.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 1</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/2" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_2.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 2</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/3" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_3.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 3</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/4" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_4.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 4</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/5" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_5.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 5</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/6" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_6.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 6</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/7" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_7.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 7</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/8" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_8.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 8</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>

                <a href="subject/9" style="text-decoration: none">
                    <div class="card me-3" style="width: 18rem;">
                        <img src="assets/images/thumbnail/subject/subject_9.png" class="card-img-top"
                             alt="subject thumbnail"
                             style="width: 100%; height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Title 9</h5>
                            <p class="card-text">Tag line</p>
                        </div>
                    </div>
                </a>
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
<div style="margin: 150px 0px">
    <h1 class="text-center mb-5">Hot post</h1>

    <div class="container">
        <div class="row g-0">
            <%--left--%>
            <div class="col-6">
                <div id="postSlide" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#postSlide" data-bs-slide-to="0" class="active"
                                aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#postSlide" data-bs-slide-to="1"
                                aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#postSlide" data-bs-slide-to="2"
                                aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <a href="post/1">
                                <div class="position-relative"
                                     style="width: 100%; height: 500px; overflow: hidden; border-radius: 8px; padding: 0px">
                                    <img src="assets/images/thumbnail/post/new_1.png" alt="post thumbnail"
                                         style="width: 100%; height: 100%; object-fit: cover;">
                                    <span class="position-absolute top-0 start-0 text-bg-primary px-4 py-2 rounded">
                                        New
                                    </span>
                                    <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                        <div>
                                            <i class="bi bi-clock"></i> post date
                                        </div>
                                        <h3>Title</h3>
                                    </span>
                                </div>
                            </a>
                        </div>

                        <div class="carousel-item">
                            <a href="post/2">
                                <div class="position-relative"
                                     style="width: 100%; height: 500px; overflow: hidden; border-radius: 8px; padding: 0px">
                                    <img src="assets/images/thumbnail/post/new_2.png" alt="post thumbnail"
                                         style="width: 100%; height: 100%; object-fit: cover;">
                                    <span class="position-absolute top-0 start-0 text-bg-primary px-4 py-2 rounded">
                                        New
                                    </span>
                                    <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                        <div>
                                            <i class="bi bi-clock"></i> post date
                                        </div>
                                        <h3>Title</h3>
                                    </span>
                                </div>
                            </a>
                        </div>

                        <div class="carousel-item">
                            <a href="post/3">
                                <div class="position-relative"
                                     style="width: 100%; height: 500px; overflow: hidden; border-radius: 8px; padding: 0px">
                                    <img src="assets/images/thumbnail/post/new_3.png" alt="post thumbnail"
                                         style="width: 100%; height: 100%; object-fit: cover;">
                                    <span class="position-absolute top-0 start-0 text-bg-primary px-4 py-2 rounded">
                                        New
                                    </span>
                                    <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                        <div>
                                            <i class="bi bi-clock"></i> post date
                                        </div>
                                        <h3>Title</h3>
                                    </span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

            </div>

            <%--right--%>
            <div class="col-6">
                <div class="row g-0">
                    <div class="col-6">
                        <a href="post/4">
                            <div class="position-relative"
                                 style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="assets/images/thumbnail/post/hot_1.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> post date
                                    </div>
                                    <h5>Title</h5>
                                </span>
                            </div>
                        </a>
                    </div>

                    <div class="col-6">
                        <a href="post/5">
                            <div class="position-relative"
                                 style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="assets/images/thumbnail/post/hot_2.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> post date
                                    </div>
                                    <h5>Title</h5>
                                </span>
                            </div>
                        </a>
                    </div>

                    <div class="col-6">
                        <a href="post/6">
                            <div class="position-relative"
                                 style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="assets/images/thumbnail/post/hot_3.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> post date
                                    </div>
                                    <h5>Title</h5>
                                </span>
                            </div>
                        </a>
                    </div>

                    <div class="col-6">
                        <a href="post/7">
                            <div class="position-relative"
                                 style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="assets/images/thumbnail/post/new_2.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> post date
                                    </div>
                                    <h5>Title</h5>
                                </span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<jsp:include page="./layout/footer.jsp"/>

</body>

<script>
    const carousel = document.getElementById("subjectCarousel");
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
