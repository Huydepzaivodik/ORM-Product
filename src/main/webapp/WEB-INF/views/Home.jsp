
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>

</head>

<style>
    /* Căn giữa div chứa các nút */
    .centered-buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* Chiều cao 100% màn hình */
    }

    /* Khoảng cách giữa các nút */
    .centered-buttons button {
        margin: 0 10px; /* Thêm khoảng cách giữa các nút */
    }
</style>


<body style="background: black">

<div class="centered-buttons">
    <button type="button" class="btn btn-success" style="font-size: 30px;" onclick="window.location.href='/users/formUser'">Tạo Hóa Đơn</button>
    <button type="button" class="btn btn-warning" style="font-size: 30px;" onclick="window.location.href='/invoice/checkInvoice'">Xem Hóa Đơn</button>
</div>

</body>
</html>
