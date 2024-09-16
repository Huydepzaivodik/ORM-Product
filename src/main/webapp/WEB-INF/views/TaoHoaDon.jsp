<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tao Hoa Don</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.8/axios.min.js"
            integrity="sha512-PJa3oQSLWRB7wHZ7GQ/g+qyv6r4mbuhmiDb8BjSFZ8NZ2a42oTtAq5n0ucWAwcQDlikAtkub+tPVCw4np27WCg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>

<%--    <script>--%>
<%--        history.pushState(null, document.title, location.href);--%>
<%--        window.addEventListener('popstate', function (event)--%>
<%--        {--%>
<%--            history.pushState(null, document.title, location.href);--%>
<%--        });--%>
<%--    </script>--%>

<%--    <script>--%>
<%--        window.onbeforeunload = function() { return "Your work will be lost."; };--%>
<%--    </script>--%>
</head>
<style>
    .container-content {
        display: flex;
        flex-direction: column;
        margin-top: 1%;
        justify-content: center;
        align-items: center;
    }

    #rowAdder {
        margin-left: 17px;
    }

    .information-user {
        border: 10px solid #000; /* Độ dày và màu sắc của viền */
        border-radius: 5px; /* Bo tròn các góc, tùy chọn */
        padding: 15px; /* Khoảng đệm bên trong */
        background-color: antiquewhite;
    }

</style>

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

<div class="container-content">
    <h1 style="color:green">Tạo Hóa Đơn</h1>
    <div style="width:60%;">
        <div>
            <div class="">
                <div class="col-lg-12">
                    <button type="button" id="createBill" class="btn btn-success" onclick="createBill()">Tạo Hóa Đơn
                    </button>
                    <br>
                    <br>
                    <div class="information-user border p-3">
                        <div class="d-flex">
                            <div class="input-group-1 mb-3 mr-3" style="flex: 2; margin-right: 10px;">
                                <input type="text" class="form-control"
                                       placeholder="Nhập tên khách hàng..."
                                       aria-label="Username" aria-describedby="basic-addon-name" id="customer_name"
                                       value="${currentUser.getUsername()}" disabled>
                            </div>

                            <div class="input-group-1 mb-3" style="flex: 1;">
                                <input type="text" class="form-control" placeholder="Nhập số điện thoại..."
                                       aria-label="Username" aria-describedby="basic-addon-phone" id="customer_phone"
                                       value="${currentUser.getPhone()}" disabled>
                            </div>
                        </div>
                        <div class="input-group-1 mb-3">
                            <input type="text" class="form-control" placeholder="Nhập địa chỉ..." aria-label="Username"
                                   aria-describedby="basic-addon-address" id="customer_address"
                                   value="${currentUser.getAddress()}" disabled>
                        </div>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
                                                  style="background-color: wheat">Tên</span>
                                            <input type="text" class="form-control" placeholder="Nhập tên..."
                                                   aria-label="Username"
                                                   aria-describedby="basic-addon-username" id="customer_name_update">
                                        </div>

                                        <div class="input-group2 mb-3">
                                        <span class="input-group-text" id="basic-addon-phone"
                                              style="background-color: wheat">Điện thoại</span>
                                            <input type="text" class="form-control" placeholder="Nhập SĐT..."
                                                   aria-label="Username"
                                                   aria-describedby="basic-addon-phone" id="customer_phone_update">
                                        </div>

                                        <div class="input-group2 mb-3">
                                        <span class="input-group-text" id="basic-addon-address"
                                              style="background-color: wheat">Địa Chỉ</span>
                                            <input type="text" class="form-control" placeholder="Nhập địa chỉ..."
                                                   aria-label="Username" aria-describedby="basic-addon-address"
                                                   id="customer_address_update">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng
                                        </button>
                                        <button type="button" class="btn btn-primary" onclick="updateCustomer()">Lưu
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="row">
                        <div class="input-group m-3">
                            <!-- Cột 1: Nhập tên sản phẩm -->
                            <input type="text" required class="form-control m-input" placeholder="Tên sản phẩm" id="name"
                                   style="width: 25%">
                            <!-- Cột 2: Nhập số lượng -->
                            <input style="margin-left: 5px" type="number" class="form-control" placeholder="Số lượng"
                                   id="quantity" aria-label="Recipient's username" aria-describedby="basic-addon2" required>

                            <!-- Cột 3: Nhập Đơn vị -->
                            <input style="margin-left: 5px" type="text" class="form-control" placeholder="Đơn vị"
                                   id="unit" aria-label="Recipient's username" aria-describedby="basic-addon4" required>

                            <!-- Cột 4: Nhập đơn giá -->
                            <input style="margin-left: 5px" type="number" class="form-control" placeholder="Đơn giá"
                                   id="unitPrice" aria-label="Recipient's username" aria-describedby="basic-addon3"
                                   required>
                            <div class="input-group-append">
                                <span class="input-group-text" id="basic-addon3"><b>VNĐ</b></span>
                            </div>

                            <!-- Cột 5: Tổng tiền (readonly, tự động tính toán) -->
                            <input style="margin-left: 5px" type="number" class="form-control m-input"
                                   placeholder="Tổng tiền" id="totalPrice" aria-label="Recipient's username"
                                   aria-describedby="basic-addon4" readonly>
                            <div class="input-group-append">
                                <span class="input-group-text" id="basic-addon4"><b>VNĐ</b></span>
                            </div>
                            <button style="margin-left: 8px" class="btn btn-danger" id="DeleteRow" type="button"><i
                                    class="bi bi-trash"></i>
                                Xóa
                            </button>
                        </div>
                    </div>

                    <!-- Vùng thêm hàng mới -->
                    <div id="newinput">

                    </div>

                    <button id="rowAdder" type="button" class="btn btn-dark">
                        <span class="bi bi-plus-square-dotted">
                        </span> Thêm một dòng
                    </button>
                </div>
            </div>
        </div>
        <%--        <button onclick="testJson()">Test Json</button>--%>
    </div></div>


<script>
    function testJson() {
        const user = {
            username: "John Doe",
            address: "johndoe@example.com",
            phone: "012"
        };
        axios.post("http://localhost:8080/users/add", user).then(
            (response) => {
                window.location.href = '../users/formUser'
            }
        )
        //     console.log('Sending JSON:', jsonString);
        //
        //     // Gửi yêu cầu POST đến controller
        //     fetch('http://localhost:8080/users/add', {
        //         method: 'POST',
        //         headers: {
        //             'Content-Type': 'application/json'
        //         },
        //         body: jsonString
        //     }).then((response) => {
        //             console.log(response.data);
        //             window.location.href = '../users/formUser'
        //         }
        //     )
    }
</script>
<script>
    function updateCustomer() {
        let customerName = document.getElementById("customer_name_update").value;
        let customerPhone = document.getElementById("customer_phone_update").value;
        let customerAddress = document.getElementById("customer_address_update").value;
        let customerId = document.getElementById("customer_id").value;

        let formData = new URLSearchParams();
        formData.append('name', customerName);
        formData.append('phone', customerPhone);
        formData.append('address', customerAddress);
        formData.append('id', customerId);

        fetch('/users/edit', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
            .then(response => {
                if (response.ok) {
                    window.location.href = '/bills/show';
                } else {
                    console.error('Có lỗi xảy ra khi cập nhật thông tin khách hàng');
                }
            })
            .catch(error => {
                console.error('Lỗi mạng:', error);
            });
    }

</script>
<script>
    document.getElementById('rowAdder').addEventListener('click', function () {
        var newInputGroup = document.querySelector('.input-group').cloneNode(true);
        newInputGroup.querySelector('#name').value = '';
        newInputGroup.querySelector('#unit').value = '';
        newInputGroup.querySelector('#unitPrice').value = '';
        newInputGroup.querySelector('#quantity').value = '';
        newInputGroup.querySelector('#totalPrice').value = ''; // Reset value của ô Tổng tiền
        document.getElementById('newinput').appendChild(newInputGroup);

        // Thêm sự kiện xóa hàng cho nút Delete của hàng mới
        newInputGroup.querySelector('#DeleteRow').addEventListener('click', function () {
            this.closest('.input-group').remove();
        });

        // Thêm sự kiện tính toán tổng tiền khi nhập dữ liệu
        newInputGroup.querySelector('#quantity').addEventListener('input', calculateTotal);
        newInputGroup.querySelector('#unitPrice').addEventListener('input', calculateTotal);
    });

    function calculateTotal(event) {
        var inputGroup = event.target.closest('.input-group');
        var quantity = parseFloat(inputGroup.querySelector('#quantity').value) || 0;
        var unitPrice = parseFloat(inputGroup.querySelector('#unitPrice').value) || 0;
        var totalPrice = quantity * unitPrice;
        inputGroup.querySelector('#totalPrice').value = totalPrice;
    }

    // Gắn sự kiện xóa và tính toán cho hàng đầu tiên
    document.querySelector('#DeleteRow').addEventListener('click', function () {
        let allRows = document.querySelectorAll('#row .input-group');
        if (allRows.length > 1) {
            // Nếu không phải là hàng đầu tiên (và có nhiều hơn một hàng), thì cho phép xóa
            this.closest('.input-group').remove();
        } else {
            // Nếu là hàng đầu tiên, không làm gì cả (hoặc có thể hiện thông báo)
            alert('Không thể xóa hàng đầu tiên!');
        }
    });
    document.querySelector('#quantity').addEventListener('input', calculateTotal);
    document.querySelector('#unitPrice').addEventListener('input', calculateTotal);
</script>
<script>
    function createBill() {

        let isValid = true;
        let items = []; // Mảng chứa thông tin của các hàng

        let username = document.getElementById("customer_name").value;
        let phone = document.getElementById("customer_phone").value;
        let address = document.getElementById("customer_address").value;
        let id = document.getElementById("customer_id").value;

        let date = new Date().toISOString();

        let user = {
            id: id,
            username: username,
            address: address,
            phone: phone
        }
        document.querySelectorAll('.input-group').forEach(
            row => {
                let itemName = row.querySelector('#name').value;
                let itemQuantity = row.querySelector('#quantity').value;
                let itemUnit = row.querySelector('#unit').value;
                let itemUnitPrice = row.querySelector('#unitPrice').value;
                let itemTotalPrice = row.querySelector('#totalPrice').value;

                // Kiểm tra xem có trường nào rỗng không
                if (itemName === "" || itemQuantity === "" || itemUnitPrice === "" || itemUnit === "") {
                    isValid = false;
                    alert("Không để trống thông tin sản phẩm");
                    return;
                }

                items.push({
                    nameProduct: itemName,
                    quantity: itemQuantity,
                    unit: itemUnit,
                    price: itemUnitPrice,
                    amount: itemTotalPrice,
                    date: date,
                    user: user
                });
            });

        console.log(items);

        if (isValid) { // Gửi items đến backend
            fetch('/bills/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(items)
            })
                .then(response => response.text())
                .then(data => {
                    console.log('Success:', data);
                    window.location.href = 'showInvoice'
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
        }
    }

</script>


</body>
</html>
