<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product List</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>
<style>
    label {
        display: block;
        font: 1rem 'Fira Sans',
        sans-serif;
    }

    input.search,
    label {
        margin: 0.4rem 0;
    }

</style>

<body>
<h1>Product List</h1>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Add Product
</button>

<form action="/products/searchName" method="get">
    <input style="width: 300px" type="text" placeholder="Enter product name..."  class="search" id="search" name="name"/>
    <button>Search</button>
</form>

<form action="/products/searchPrice" method="get">
    <select  style="width: 300px" name="priceSelect">
        <option value="0" selected >Search Price...</option>
        <option  value="1">From 1000 to 2000</option>
        <option  value="2">From 2000 to 3000</option>
        <option value="3">More than 3000</option>
    </select>
    <button>Search</button>
</form>




<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/products/add" method="post">
                <div class="modal-body">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="name">Name</span>
                        <input type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="name">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="price">Price</span>
                        <input type="number" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="price">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="quantity">Quantity</span>
                        <input type="number" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="quantity">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="image">Image</span>
                        <input type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="image">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>

        </div>
    </div>
</div>


<table id="productTable" class="table">
    <thead>
    <tr>
        <th scope="col">ID</th>
        <th scope="col">Name Product</th>
        <th scope="col">Price</th>
        <th scope="col">Quantity</th>
        <th scope="col">Image</th>
        <th scope="col" colspan="2">Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${productList}" var="prdL">
        <tr>
            <th>${prdL.id}</th>
            <td>${prdL.name}</td>
            <td>${prdL.price}</td>
            <td>${prdL.quantity}</td>
            <td><img style="width:60px;height: 60px" src="${prdL.image}" alt=""></td>
            <td>
                <button type="button" class="btn btn-primary" style=""><a style="text-decoration: none;color:white"
                                                                          href="/products/edit/${prdL.id}">View
                    Detail</a></button>
            </td>
            <td>
                <button type="button" class="btn btn-danger" onclick="confirmDelete('${prdL.id}')">Delete</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    function confirmDelete(productId) {
        var result = confirm("Do you want to delete product with ID: " + productId + " ?");
        if (result) {
            window.location.href = "/products/delete/" + productId;
        }
    }
</script>
</body>
</html>
