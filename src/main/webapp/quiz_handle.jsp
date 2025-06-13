<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quiz Handle</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .option-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }

        .option-radio {
            width: 32px;
            height: 32px;
            background-color: #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            cursor: pointer;
        }

        .option-radio::after {
            content: '';
            width: 16px;
            height: 16px;
            background-color: white;
            border-radius: 50%;
            display: block;
            transition: background-color 0.2s ease;
        }

        .option-item.selected .option-radio::after {
            background-color: black;
        }

        .option-letter {
            font-weight: bold;
            color: #555;
            min-width: 25px;
            margin-right: 8px;
        }

        .option-text {
            color: #333;
        }
    </style>
</head>
<body>

<div class="d-flex flex-column" style="min-height: 100vh;">
    <!-- Thanh trên cùng chứa vị trí + đồng hồ -->
    <div class="d-flex justify-content-end px-2 pt-2">
        <div class="d-flex align-items-center gap-4 px-4">
            <div class="d-flex align-items-center text-secondary fs-5">
                <i class="fas fa-map-marker-alt me-2 fa-lg"></i>
                <span>1 / 20</span>
            </div>
            <div class="d-flex align-items-center fs-5 py-2 px-2" style="background: #a6bee3">
                <i class="fas fa-hourglass-half me-2 fa-lg"></i> 00:10:34
            </div>
        </div>
    </div>

    <!-- Header nền đen -->
    <div class="d-flex justify-content-between align-items-center px-4 py-2 bg-dark text-white mt-2">
        <div class="fw-bold">1)</div>
        <div class="text-secondary small">Question ID: 643</div>
    </div>

    <!-- Quiz Content -->
    <div class="flex-grow-1 d-flex flex-column" style="padding: 20px 40px">
        <div class="fs-5 mb-4 mx-5">
            The ScrumMaster, Sophia, is preparing for a meeting with the project sponsor, Arnold, to report on the
            project's progress. Arnold wants to know how much work is left on the project and when the team will be
            done. Sophia is starting in team's workspace taking a picture of one of their low-tech, high-touch tools to
            show Arnold in this meeting. Which information radiator is she photographing?
        </div>

        <div class="mb-4 mx-5">
            <ul class="list-unstyled m-0 p-0">
                <li class="option-item">
                    <div class="option-radio" onclick="selectOption(this)"></div>
                    <span class="option-letter">A.</span>
                    <span class="option-text">Technical debt graph</span>
                </li>
                <li class="option-item">
                    <div class="option-radio" onclick="selectOption(this)"></div>
                    <span class="option-letter">B.</span>
                    <span class="option-text">Project schedule</span>
                </li>
                <li class="option-item">
                    <div class="option-radio" onclick="selectOption(this)"></div>
                    <span class="option-letter">C.</span>
                    <span class="option-text">Task board</span>
                </li>
                <li class="option-item">
                    <div class="option-radio" onclick="selectOption(this)"></div>
                    <span class="option-letter">D.</span>
                    <span class="option-text">Burnup chart</span>
                </li>
            </ul>
        </div>

        <div class="d-flex justify-content-end gap-3 mt-auto">
            <button class="btn border border-secondary">Peek at answer</button>
            <button class="btn text-white border border-secondary" style="background-color: #64c281;">
                <i class="bi bi-bookmark-fill"></i> Mark for review
            </button>
        </div>
    </div>

    <!-- Quiz Footer -->
    <div class="d-flex justify-content-between align-items-center px-5 py-4 border-top"
         style="background-color: #64c281;">
        <button class="btn text-white border border-white" style="background-color: transparent; width: 180px">
            Review progress
        </button>
        <div class="d-flex gap-2">
            <button class="btn text-white border border-white" style="background-color: transparent; width: 150px">
                Next
            </button>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>

    function selectOption(radioEl) {
        // Tìm phần tử cha là .option-item
        const selectedItem = radioEl.closest('.option-item');

        document.querySelectorAll('.option-item').forEach(item => item.classList.remove('selected'));
        selectedItem.classList.add('selected');
    }

</script>
</body>
</html>
