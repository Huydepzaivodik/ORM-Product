<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.8/axios.min.js"
            integrity="sha512-PJa3oQSLWRB7wHZ7GQ/g+qyv6r4mbuhmiDb8BjSFZ8NZ2a42oTtAq5n0ucWAwcQDlikAtkub+tPVCw4np27WCg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</head>
<style>
    .invoice-container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        min-height: 30vh; /* Canh giữa bảng theo chiều dọc */
    }

    .invoice-table {
        margin: 5px auto; /* Canh giữa bảng */
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
<br>
<%--Phần sửa đổi thông tin khách hàng--%>
<div class="information-user" id="userInformation">
    <b>Tên khách hàng: </b> <input disabled type="text" style="border: none;background-color: white;width: 500px"
                                   value="${currentUser.username}"><br>

    <b>SĐT: </b><input disabled type="text" style="border: none;background-color: white;width: 500px"
                       value="${currentUser.phone}"><br>

    <b>Địa chỉ: </b><input disabled type="text" style="border: none;background-color: white;width:500px"
                           value="${currentUser.address}"><br>
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-primary noPrint" data-bs-toggle="modal" data-bs-target="#exampleModal">
        Sửa thông tin khách hàng
    </button>
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Thông tin khách hàng</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group2 mb-3">
                        <input type="hidden" value="${currentUser.getId()}" id="customer_id">
                        <span class="input-group-text" id="basic-addon-username"
                              style="background-color: darkgray">Tên</span>
                        <input type="text" class="form-control" placeholder="Nhập tên..."
                               aria-label="Username"
                               aria-describedby="basic-addon-username" id="customer_name_update">
                    </div>

                    <div class="input-group2 mb-3">
                                        <span class="input-group-text" id="basic-addon-phone"
                                              style="background-color: darkgrey">Điện thoại</span>
                        <input type="text" class="form-control" placeholder="Nhập SĐT..."
                               aria-label="Username"
                               aria-describedby="basic-addon-phone" id="customer_phone_update">
                    </div>

                    <div class="input-group2 mb-3">
                                        <span class="input-group-text" id="basic-addon-address"
                                              style="background-color: darkgray">Địa Chỉ</span>
                        <input type="text" class="form-control" placeholder="Nhập địa chỉ..."
                               aria-label="Username" aria-describedby="basic-addon-address"
                               id="customer_address_update">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng
                    </button>
                    <button type="button" class="btn btn-primary" onclick="capNhatTen()">Lưu
                    </button>
                </div>
            </div>
        </div>
    </div>
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
            <th scope="col" colspan="2" class="chinh_sua noPrint">Chỉnh Sửa</th>
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
                <td class="btn_chinh_sua noPrint">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-success" data-bs-toggle="modal"
                            data-bs-target="#exampleModal${bill.getId()}">
                        Chỉnh Sửa
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal${bill.getId()}" tabindex="-1"
                         aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel1">Chỉnh Sửa</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">

                                    <div class="input-group mb-3">
                                        <span class="input-group-text" id="basic-addon10">Tên</span>
                                        <input type="text" id="nameProduct${bill.getId()}" class="form-control"
                                               placeholder="Tên sản phẩm..." aria-label="Username"
                                               aria-describedby="basic-addon10">
                                    </div>

                                    <div class="input-group mb-3">
                                        <span class="input-group-text" id="basic-addon11">Đơn vị</span>
                                        <input type="text" id="unit${bill.getId()}" class="form-control"
                                               placeholder="Đơn vị..."
                                               aria-label="Username" aria-describedby="basic-addon11">
                                    </div>

                                    <div class="input-group mb-3">
                                        <span class="input-group-text" id="basic-addon12">Số lượng</span>
                                        <input type="number" id="quantity${bill.getId()}" class="form-control"
                                               placeholder="Số lượng..." aria-label="Username"
                                               aria-describedby="basic-addon12" oninput="calculate(${bill.getId()})">
                                    </div>

                                    <div class="input-group mb-3">
                                        <span class="input-group-text" id="basic-addon13">Đơn giá</span>
                                        <input type="number" id="unitPrice${bill.getId()}" class="form-control"
                                               placeholder="Đơn giá..." aria-label="Username"
                                               aria-describedby="basic-addon13" oninput="calculate(${bill.getId()})">
                                    </div>

                                    <div class="input-group mb-3">
                                        <span class="input-group-text" id="basic-addon14">Thành tiền</span>
                                        <input type="number" id="total${bill.getId()}" class="form-control"
                                               placeholder="Thành Tiền..." aria-label="Username"
                                               aria-describedby="basic-addon14">
                                    </div>


                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng
                                    </button>
                                    <button type="button" class="btn btn-primary" onclick="updateBill(${bill.getId()})">
                                        Lưu
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td class="btn_xoa noPrint">
                    <button type="button" class="btn btn-danger" onclick="deleteBill(${bill.getId()})">Xóa</button>
                </td>
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
                                   style="border: none;background-color: transparent;text-align: center">
            </td>
        </tr>
        <tr>
            <td colspan="5">Tiền khách đưa:</td>
            <td colspan="3"><input type="number" id="cash"
                                   style="border: none;background-color: transparent;text-align: center">
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
<br>
<div style="float: right;margin-right: 100px">
    Ngày...... tháng...... năm......
    <br>
    <b style="margin-left: 19px">Chủ cửa hàng</b>
</div>

<button type="button" class="btn btn-warning noPrint" onclick="window.print()">In hóa đơn</button>
<button class="btn btn-success noPrint" id="saveInvoice" onclick="saveInvoice()">Lưu Hóa Đơn</button>

<script>
    function capNhatTen() {
        let id = document.getElementById("customer_id").value;
        let username = document.getElementById("customer_name_update").value;
        let phone = document.getElementById("customer_phone_update").value;
        let address = document.getElementById("customer_address_update").value;

        let user = {
            id: id,
            username: username,
            phone: phone,
            address: address
        }
        axios.post('http://localhost:8080/users/updateUser', user).then((response) => {
            window.location.reload();
        })
    }

    function updateBill(id) {

        console.log(id);

        let nameProduct = document.getElementById(`nameProduct` + id).value;
        let unit = document.getElementById(`unit` + id).value;
        let quantity = document.getElementById(`quantity` + id).value;
        let price = document.getElementById(`unitPrice` + id).value;
        let amount = document.getElementById(`total` + id).value;

        let billUpdate = {
            id: id,
            nameProduct: nameProduct,
            quantity: quantity,
            unit: unit,
            price: price,
            amount: amount
        }

        axios.post("http://localhost:8080/bills/updateBill", billUpdate).then((response) => {
            window.location.href = "/bills/showInvoice"
        });

    }
</script>
<script>
    function deleteBill(id) {
        let isConfirm = confirm("Bạn có muốn xóa sản phẩm này không ?");
        if (isConfirm) {
            axios.delete(`http://localhost:8080/bills/deleteBill/` + id).then((response) => {
                window.location.href = "/bills/showInvoice"
            })
        }
    }
</script>
<script>
    function calculate(id) {
        let quantity = document.getElementById(`quantity` + id).value;
        let unitPrice = document.getElementById(`unitPrice` + id).value;
        let totalField = document.getElementById(`total` + id);

        // Kiểm tra nếu số lượng và đơn giá đều có giá trị
        if (quantity && unitPrice) {
            let total = quantity * unitPrice;
            totalField.value = total;
        } else {
            // Nếu một trong hai trường trống, đặt giá trị thành tiền thành 0
            totalField.value = 0;
        }
    }
</script>
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
    // Biến để theo dõi xem hóa đơn đã được lưu hay chưa
    let isInvoiceSaved = false;

    function saveInvoice() {


        let debt = document.getElementById("debt").value;
        let cash = document.getElementById("cash").value;
        if (debt.trim() === "" || cash.trim() === "") {
            debt = 0;
            cash = 0;
        }

        let invoice = {
            debt: debt,
            cash: cash
        }

        axios.post("http://localhost:8080/invoice/addInvoice", invoice).then((response) => {
            let invoice = response.data;
            let bills = ${billsJson};
            let bill_ids = [];
            for (let i = 0; i < bills.length; i++) {
                bill_ids.push(bills[i].id);
            }
            console.log(bill_ids);
            console.log(invoice.id);
            let invoiceId = invoice.id

            let data = {
                bill_ids: bill_ids,
                invoiceId: invoiceId
            }

            console.log(data);

            axios.post("http://localhost:8080/bills/editBillWithInvoiceId", data).then((response) => {
                alert("Lưu hóa đơn thành công !");


                // Disable nút "Lưu Hóa Đơn" sau khi lưu thành công
                document.getElementById("saveInvoice").disabled = true;

                // Đánh dấu hóa đơn đã được lưu
                isInvoiceSaved = true;

                let homeButton = document.createElement("button");
                homeButton.type = "button";
                homeButton.className = "btn btn-primary noPrint";
                homeButton.textContent = "Về màn hình chính";
                homeButton.onclick = function () {
                    window.location.href = "../";
                };
                document.body.append(homeButton);

            });
        })
    }

    // Thêm sự kiện beforeunload để cảnh báo khi người dùng rời khỏi trang mà chưa lưu hóa đơn
    window.addEventListener("beforeunload", function (e) {
        if (!isInvoiceSaved) {
            const confirmationMessage = "Bạn chưa lưu hóa đơn. Bạn có chắc chắn muốn rời khỏi trang này?";
            e.returnValue = confirmationMessage; // Hiển thị thông báo cảnh báo
            return confirmationMessage; // Một số trình duyệt yêu cầu return giá trị
        }
    });

</script>

</body>
</html>
