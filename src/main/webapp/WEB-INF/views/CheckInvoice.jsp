<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Check Invoice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.8/axios.min.js"
            integrity="sha512-PJa3oQSLWRB7wHZ7GQ/g+qyv6r4mbuhmiDb8BjSFZ8NZ2a42oTtAq5n0ucWAwcQDlikAtkub+tPVCw4np27WCg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
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
<h1 style="  display: flex;
        flex-direction: column;
        margin-top: 1%;
        justify-content: center;
        align-items: center;">Check Lịch Sử Hóa Đơn
</h1>

<div id="search_bar" style="display: flex;
        flex-direction: column;
        margin-top: 1%;
        justify-content: center;
        align-items: center;">
    <form action="../users/search" method="get" class="input-group input-group-lg" style="width: 70%">
        <span class="input-group-text" id="inputGroup-sizing-lg">
            <button type="submit" class="btn btn-primary">
                Tìm Kiếm
            </button>
        </span>
        <input type="text" id="username" name="username" class="form-control" aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-lg" placeholder="Nhập tên khách hàng">
    </form>
</div>

<!-- Nội dung hóa đơn sẽ được cập nhật vào đây -->
<div style="width: 70%; margin: 0 auto;" id="billContainer">
    <div id="invoice_list">
        <c:forEach var="l" items="${list}">
            <div class="card" style="margin-bottom: 7px">
                <div class="card-body">
                    <h5 class="card-title">${l.username}</h5>
                    <c:set var="displayed" value="false"/> <!-- Biến cờ để kiểm soát việc hiển thị -->
                    <c:forEach var="b" items="${bills}">
                        <c:if test="${b.user.id == l.id && displayed == false}">
                            <b><fmt:formatDate value="${b.date}" pattern="HH:mm:ss dd/MM/yyyy"/></b>
                            <c:set var="displayed" value="true"/> <!-- Sau khi hiển thị, đổi giá trị biến cờ -->
                        </c:if>
                    </c:forEach>
                    <br>
                    <button type="button" class="btn btn-success"
                            onclick="window.location.href='/bills/showTheBillById?id=${l.id}'">Xem
                    </button>
                    <button type="button" class="btn btn-danger" onclick="deleteBill(${l.id})">Xóa

                    </button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<script>

    function deleteBill(id) {
        console.log(id);
        let isConfirm = confirm("Bạn có muốn xóa hóa đơn này không ?");
        if (isConfirm) {
            axios.delete(`${api_url}/invoice/deleteBill/` + id).then((response) => {
                alert("Xóa thành công !");
                window.location.href="../invoice/checkInvoice";
            })
        }
    }
</script>


</body>
</html>
