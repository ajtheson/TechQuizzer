<html>
<head>
    <title>Title</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="accordion" id="siderFilters">
    <!-- XẾP HẠNG -->
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingRating">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseRating" aria-expanded="true">
                ⭐ Xếp hạng
            </button>
        </h2>
        <div id="collapseRating" class="accordion-collapse collapse show" data-bs-parent="#siderFilters">
            <div class="accordion-body">
                <!-- Star rating giả lập -->
                <div>
                    ★★★★★<br>
                    <small class="text-muted">Tất chọn nửa sao</small>
                </div>
            </div>
        </div>
    </div>

    <!-- DANH MỤC KHÓA HỌC -->
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingCategory">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategory">
                📂 Danh mục khóa học
            </button>
        </h2>
        <div id="collapseCategory" class="accordion-collapse collapse" data-bs-parent="#siderFilters">
            <div class="accordion-body">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="cat1">
                    <label class="form-check-label" for="cat1">Software Engineering</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="cat2">
                    <label class="form-check-label" for="cat2">Mathematics</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="cat3">
                    <label class="form-check-label" for="cat3">Language</label>
                </div>
            </div>
        </div>
    </div>

    <!-- CẤP ĐỘ -->
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingLevel">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLevel">
                🎓 Cấp độ
            </button>
        </h2>
        <div id="collapseLevel" class="accordion-collapse collapse" data-bs-parent="#siderFilters">
            <div class="accordion-body">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="level" id="level1">
                    <label class="form-check-label" for="level1">Student</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="level" id="level2">
                    <label class="form-check-label" for="level2">University</label>
                </div>
            </div>
        </div>
    </div>

    <!-- NÚT XÓA BỘ LỌC -->
    <div class="mt-3">
        <button class="btn btn-primary w-100">Xóa bộ lọc</button>
    </div>
</div>

</body>
</html>