<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>

<style>
    .centered-container {
        text-align: center; /* Căn giữa nội dung bên trong container */
    }

    .centered-form {
        display: inline-block; /* Để form không chiếm toàn bộ chiều rộng */
        width: 60%; /* Đặt chiều rộng cho form */
        margin: 20px auto; /* Đưa form ra giữa màn hình theo chiều ngang */
        padding: 20px; /* Thêm khoảng trống bên trong form */
        border: 2px solid #007bff; /* Tạo border màu xanh quanh form */
        border-radius: 8px; /* Bo tròn góc của border */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Thêm đổ bóng nhẹ để form nổi bật hơn */
        background-color: wheat; /* Nền trắng cho form */
    }


</style>

<script>
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };
</script>

<body>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="../"><b>Showroom Hùng Mận</b></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="../"><b>Home</b></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../users/formUser"><b>Tạo Mới Khách Hàng</b></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../invoice/checkInvoice"><b>Xem Hóa Đơn</b></a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="centered-container">
    <h1>Nhập Thông Tin Cho Khách Hàng</h1>
    <form class="centered-form" action="/users/addUser" method="post" onsubmit="return validateForm()">
        <div class="mb-3">
            <label for="username" class="form-label"><b>Tên Khách Hàng</b></label>
            <input type="text" class="form-control" id="username" name="username">
            <span id="username_error" style="font-size: small;color: red"></span>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label"><b>Số điện thoại</b></label>
            <input type="number" class="form-control" id="phone" name="phone">
            <span id="phone_error" style="font-size: small;color: red"></span>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label"><b>Địa chỉ</b></label>
            <input type="text" class="form-control" id="address" name="address">
            <span id="address_error" style="font-size: small;color: red"></span>
        </div>
        <c:if test="${not empty error}">
            <div style="color: red;">
                <strong>${error}</strong>
            </div>
        </c:if>

        <button type="submit" class="btn btn-primary">Tiếp tục tạo đơn hàng</button>
    </form>
</div>

<script>
    function validateForm() {
        let isValid = true;

        // Kiểm tra từng trường nhập liệu
        const username = document.getElementById("username").value;
        const phone = document.getElementById("phone").value;
        const address = document.getElementById("address").value;

        if (username === "") {
            document.getElementById("username_error").textContent = "Tên khách hàng không được để trống";
            isValid = false;
        } else {
            document.getElementById("username_error").textContent = "";
        }

        const regex = /^\d+$/;
        if (phone === "") {
            document.getElementById("phone_error").textContent = "Số điện thoại không được để trống";
            isValid = false;
        } else if (!regex.test(phone)) {
            document.getElementById("phone_error").textContent = "Vui lòng nhập số điện thoại hợp lệ";
            return false;
        } else {
            document.getElementById("phone_error").textContent = "";
        }

        if (address === "") {
            document.getElementById("address_error").textContent = "Địa chỉ không được để trống";
            isValid = false;
        } else {
            document.getElementById("address_error").textContent = "";
        }

        return isValid;
    }
</script>
</body>
</html>
