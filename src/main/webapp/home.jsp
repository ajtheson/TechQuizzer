<%--
  Created by IntelliJ IDEA.
  User: anhnn
  Date: 23/05/2025
  Time: 10:44 CH
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .hero {
            position: relative;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .background-blur {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: blur(4px);
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }

        .overlay-content {
            position: relative;
            z-index: 2;
            text-align: center;
            padding-top: 250px;
            color: white;
            max-width: 40%;
            margin: 0 auto;
        }

        .btn-explore {
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 18px;
            border-radius: 30px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.3);
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-explore:hover {
            background: linear-gradient(to right, #00f2fe, #4facfe);
            box-shadow: 0 6px 20px rgba(0, 242, 254, 0.5);
            transform: translateY(-2px);
        }

        #overview, #featured-subject {
            scroll-margin-top: 25vh;
        }
    </style>
</head>
<body>
<jsp:include page="./common/headload.jsp"/>
<jsp:include page="./common/jsload.jsp"/>
<jsp:include page="./layout/header.jsp"/>
<jsp:include page="./user/user_profile.jsp"/>

<%--slider--%>
<div style="height: 700px; width: 100%">
    <div id="slider" class="carousel slide">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#slider" data-bs-slide-to="0" class="active" aria-current="true"
                    aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#slider" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#slider" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="hero">
                    <img src="${pageContext.request.contextPath}/assets/images/slider/slider_1.png"
                         class="d-block background-blur">
                    <div class="overlay-content">
                        <h1>Welcome to TechQuizzer</h1>
                        <p>TechQuizzer is an online platform offering interactive quizzes in tech,
                            programming, and digital skills. With a user-friendly design and regularly
                            updated content, it helps learners test and improve their knowledge in a fun way.</p>
                        <a href="#overview" class="btn-explore">Explore</a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="hero">
                    <img src="${pageContext.request.contextPath}/assets/images/slider/slider_2.png"
                         class="d-block background-blur">
                    <div class="overlay-content">
                        <h1>Master In-Demand IT Skills</h1>
                        <p>Learn Programming, Web Development, Data Science, Cybersecurity, Cloud Computing and more –
                            all in one platform.</p>
                        <a href="#featured-subject" class="btn-explore">Browse Courses</a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="hero">
                    <img src="${pageContext.request.contextPath}/assets/images/slider/slider_3.png"
                         class="d-block background-blur">
                    <div class="overlay-content">
                        <h1>Join TechQuizzer's Community</h1>
                        <p>Connect with thousands of IT learners and professionals.<br>
                            Share knowledge, grow your network, and be inspired together.</p>
                        <a href="${pageContext.request.contextPath}/account/register" class="btn-explore">Register
                            Now</a>
                    </div>
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

<%--overview--%>
<div id="overview" style="margin: 150px 40px">
    <h1 class="text-center mb-5">Why Choose TechQuizzer?</h1>

    <div class="row justify-content-center text-center">
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-laptop-code fa-3x mb-3 text-primary"></i>
                    <h5 class="card-title">Interactive Coding</h5>
                    <p class="card-text">Practice real code with live feedback.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-chart-line fa-3x mb-3 text-success"></i>
                    <h5 class="card-title">Progress Tracking</h5>
                    <p class="card-text">Monitor your performance and achievements.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-graduation-cap fa-3x mb-3 text-warning"></i>
                    <h5 class="card-title">Certified Learning</h5>
                    <p class="card-text">Earn certificates after completing each course.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center mt-4">
        <p class="lead">TechQuizzer is a modern learning platform for IT students and professionals. We provide
            high-quality courses, interactive quizzes, and real-world projects to help you grow.</p>
    </div>
</div>

<%--featured subject--%>
<div id="featured-subject" style="margin: 150px 40px">
    <h1 class="text-center mb-5">Featured Subject</h1>

    <div class="position-relative">
        <button class="btn btn-outline-secondary position-absolute top-50 start-0 translate-middle-y z-3" id="prevBtn"
                type="button">
            <i class="bi bi-chevron-left"></i>
        </button>

        <div id="carouselViewport" class="mx-auto" style="overflow: hidden; width: 76rem;">
            <!-- 18rem * 4 + 16px * 3 -->
            <div class="d-flex" id="subjectCarousel" style="scroll-behavior: smooth; overflow-x: hidden">
                <c:forEach var="subject" items="${requestScope.featuredSubjects}">
                    <a href="${pageContext.request.contextPath}/subject/detail?subject_id=${subject.getId()}"
                       style="text-decoration: none">
                        <div class="card me-3" style="width: 18rem;">
                            <img src="${pageContext.request.contextPath}/assets/images/thumbnail/subject/${subject.getThumbnail()}"
                                 class="card-img-top"
                                 alt="subject thumbnail"
                                 style="width: 100%; height: 250px; object-fit: cover;">
                            <div class="card-body">
                                <h5 class="card-title">${subject.getName()}</h5>
                                <p class="card-text">${subject.getTagLine()}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <button class="btn btn-outline-secondary position-absolute top-50 end-0 translate-middle-y z-3" id="nextBtn"
                type="button">
            <i class="bi bi-chevron-right"></i>
        </button>
    </div>

    <div class="text-center mt-3">
        <a href="${pageContext.request.contextPath}/subject/list">View all</a>
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
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="position-relative"
                                 style="width: 100%; height: 500px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="${pageContext.request.contextPath}/assets/images/thumbnail/post/new_1.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-4 py-2 rounded">
                                        New
                                    </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                        <div>
                                            <i class="bi bi-clock"></i> 22/07/2024
                                        </div>
                                        <h3>General Tech Trends</h3>
                                    </span>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <div class="position-relative"
                                 style="width: 100%; height: 500px; overflow: hidden; border-radius: 8px; padding: 0px">
                                <img src="assets/images/thumbnail/post/new_2.png" alt="post thumbnail"
                                     style="width: 100%; height: 100%; object-fit: cover;">
                                <span class="position-absolute top-0 start-0 text-bg-primary px-4 py-2 rounded">
                                        New
                                    </span>
                                <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                        <div>
                                            <i class="bi bi-clock"></i> 11/03/
                                        </div>
                                        <h3>Programming & Development</h3>
                                    </span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <%--right--%>
            <div class="col-6">
                <div class="row g-0">
                    <div class="col-6">
                        <div class="position-relative"
                             style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                            <img src="assets/images/thumbnail/post/hot_1.png" alt="post thumbnail"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                            <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                            <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> 29/01/2025
                                    </div>
                                    <h5>AI & Machine Learning</h5>
                                </span>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="position-relative"
                             style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                            <img src="assets/images/thumbnail/post/hot_2.png" alt="post thumbnail"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                            <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                            <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> 19/10/2023
                                    </div>
                                    <h5>Career & Learning</h5>
                                </span>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="position-relative"
                             style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                            <img src="assets/images/thumbnail/post/hot_3.png" alt="post thumbnail"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                            <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                            <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> 07/12/2022
                                    </div>
                                    <h5>Basic IT Knowledge</h5>
                                </span>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="position-relative"
                             style="width: 100%; height: 250px; overflow: hidden; border-radius: 8px; padding: 0px">
                            <img src="assets/images/thumbnail/post/hot_4.png" alt="post thumbnail"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                            <span class="position-absolute top-0 start-0 text-bg-primary px-3 py-1 rounded">
                                    Hot
                                </span>
                            <span class="position-absolute bottom-0 start-0 text-white px-3 py-2">
                                    <div>
                                        <i class="bi bi-clock"></i> 09/02/2022
                                    </div>
                                    <h5>Cybersecurity</h5>
                                </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<jsp:include page="./layout/footer.jsp"/>
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
