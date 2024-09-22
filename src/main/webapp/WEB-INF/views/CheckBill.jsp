<%--
  Created by IntelliJ IDEA.
  User: Quang Huy
  Date: 9/16/2024
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Check Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.8/axios.min.js"
            integrity="sha512-PJa3oQSLWRB7wHZ7GQ/g+qyv6r4mbuhmiDb8BjSFZ8NZ2a42oTtAq5n0ucWAwcQDlikAtkub+tPVCw4np27WCg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<style>

    table.table tbody tr {
        line-height: 0.3; /* Giảm chiều cao dòng */
        padding: 5px 0; /* Điều chỉnh khoảng cách bên trong */
    }

    .invoice-container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        min-height: 30vh; /* Canh giữa bảng theo chiều dọc */
    }

    .invoice-table {
        margin: 0 auto; /* Canh giữa bảng */
        border-collapse: collapse;
        text-align: center;
        background-color: #f2f2f2; /* Màu nền xám nhạt */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Thêm bóng */
    }

    .invoice-table caption {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .invoice-table th, .invoice-table td {
        padding: 10px;
        border: 1px solid #ddd;
    }

    @media print {
        @page {
            size: A4 portrait; /* A4 dọc */
            margin: 10mm; /* Điều chỉnh lề in */
        }

        body {
            width: 210mm; /* Chiều ngang khổ A4 */
            height: 297mm; /* Chiều dọc khổ A4 */
            font-size: 12pt; /* Điều chỉnh kích thước chữ cho phù hợp */
            transform: scale(1); /* Giữ nguyên tỷ lệ */
        }

        /* Ẩn các thành phần không muốn in, ví dụ như nút "Print" */
        .noPrint {
            display: none;
        }
    }

</style>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary noPrint">
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
<div class="heading" style="display: flex">
    <div style="width: 67%">
        <h3>VẬT LIỆU XÂY DỰNG HÙNG MẬN</h3>
        <div><b>CHUYÊN: GẠCH ỐP LÁT - THIẾT BỊ NHÀ BẾP, SEN VÒI, ỐNG NƯỚC</b></div>
        <div>ĐC:Khu đô thị mới - Đường Hai Bà Trưng - TT Lim -Tiên Du - Bắc Ninh</div>
        <div>ĐT: 0978310966 - 0978209366</div>
        <div>STK: 104000208646. ViettinBank. Nguyễn Thị Mận</div>
    </div>
    <div>
        <h4 style="margin-left: 20px">HÓA ĐƠN BÁN HÀNG</h4>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">
            ${error}
    </div>
</c:if>

<%--Phần sửa đổi thông tin khách hàng--%>
<div class="information-user" id="userInformation">
    <b>Tên khách hàng: </b> <input disabled type="text" style="border: none;background-color: white;width: 500px"
                                   value="${user.username}"><br>

    <b>SĐT: </b><input disabled type="text" style="border: none;background-color: white;width: 500px"
                       value="${user.phone}"><br>

    <b>Địa chỉ: </b><input disabled type="text" style="border: none;background-color: white;width:500px"
                           value="${user.address}"><br>
</div>


<%--Phần Hóa Đơn--%>
<div class="invoice-container">
    <table class="table table-striped table-hover invoice-table">
        <thead>
        <tr>
            <th scope="col">STT</th>
            <th scope="col">Tên hàng và quy cách sản phẩm</th>
            <th scope="col">Đơn vị</th>
            <th scope="col">Số lượng</th>
            <th scope="col">Đơn giá</th>
            <th scope="col">Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bills}" var="bill" varStatus="status">
            <tr>
                <th scope="row">${status.index + 1}</th>
                <td>${bill.getNameProduct()}</td>
                <td>${bill.getUnit()}</td>
                <td>${bill.getQuantity()}</td>
                <td><fmt:formatNumber value="${bill.getPrice()}" type="number" minFractionDigits="0"
                                      maxFractionDigits="0"/></td>
                <td><fmt:formatNumber value="${bill.getAmount()}" type="number" minFractionDigits="0"
                                      maxFractionDigits="0"/></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5">Tổng cộng:</td>
            <td colspan="3"><fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="0"
                                              maxFractionDigits="0"/></td>
        </tr>
        <tr>
            <td colspan="5">Nợ cũ:</td>
            <td colspan="3"><input type="number" id="debt"
                                   style="border: none;background-color: transparent;text-align: center"
                                   value="${bills.get(0).invoicee.debt}">
            </td>
        </tr>
        <tr>
            <td colspan="5">Tiền khách đưa:</td>
            <td colspan="3"><input type="number" id="cash"
                                   style="border: none;background-color: transparent;text-align: center"
                                   value="${bills.get(0).invoicee.cash}">
            </td>
        </tr>
        <tr>
            <td colspan="5">Tổng cần thanh toán:</td>
            <td colspan="3"><input style="border: none; background-color: transparent; text-align: center;" type="text"
                                   disabled id="totalInvoice">
               </td>
        </tr>
        </tbody>
    </table>
</div>
<div style="float: right;margin-right: 100px">
    Ngày...... tháng...... năm......
    <br>
    <b style="margin-left: 19px">Chủ cửa hàng</b>
</div>

<button type="button" class="btn btn-warning noPrint" onclick="window.print()">In hóa đơn</button>
<button class="btn btn-success noPrint" id="saveInvoice" onclick="saveBill()">Lưu Hóa Đơn</button>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var debtInput = document.getElementById('debt');
        var cashInput = document.getElementById('cash');
        var totalInvoiceInput = document.getElementById('totalInvoice');
        var totalAmount = parseFloat('${totalAmount}');


        // Hàm định dạng số với dấu phẩy kiểu Việt Nam
        function formatNumber(value) {
            // Chuyển số thành chuỗi và làm tròn đến số nguyên
            var numberStr = value.toFixed(0);
            // Thay thế các nhóm ba chữ số bằng dấu phẩy
            return numberStr.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        }

        // Hàm tính toán tổng cần thanh toán
        function calculateTotalInvoice() {
            var debt = parseFloat(debtInput.value) || 0;
            var cash = parseFloat(cashInput.value) || 0;

            // Nếu cả nợ cũ và tiền khách đưa đều là 0 hoặc rỗng, thì tổng cần thanh toán bằng totalAmount
            if (debt === 0 && cash === 0) {
                totalInvoiceInput.value = formatNumber(totalAmount);
            } else {
                var totalInvoice = totalAmount + debt - cash;
                totalInvoiceInput.value = formatNumber(totalInvoice);
            }
        }

        // Gọi hàm để cập nhật tổng cần thanh toán khi trang được tải lần đầu tiên
        calculateTotalInvoice();

        // Lắng nghe sự thay đổi trên các trường nhập liệu
        debtInput.addEventListener('input', calculateTotalInvoice);
        cashInput.addEventListener('input', calculateTotalInvoice);
    });
</script>
<script>
    function saveBill() {

        let debt = document.getElementById("debt").value;
        let cash = document.getElementById("cash").value;
        let invoiceId = ${bills.get(0).invoicee.id};
        if (debt.trim() === "" || cash.trim() === "") {
            debt = 0;
            cash = 0;
        }

        let invoice = {
            id: invoiceId,
            debt: debt,
            cash: cash
        }

        axios.put("http://localhost:8080/invoice/edit", invoice).then((response) => {
            alert("Chỉnh sửa thành công !");
        })

        // Disable nút "Lưu Hóa Đơn" sau khi lưu thành công
        document.getElementById("saveInvoice").disabled = true;

        let homeButton = document.createElement("button");
        homeButton.type = "button";
        homeButton.className = "btn btn-primary noPrint";
        homeButton.textContent = "Về màn hình chính";
        homeButton.onclick = function () {
            window.location.href = "../";
        };

        document.body.append(homeButton);
    }

</script>

</body>
</html>
