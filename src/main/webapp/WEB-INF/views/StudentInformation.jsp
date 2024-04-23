<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Student Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <style>
        .form-border {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            width: 500px;

        }

        .container-all {
            position: fixed;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

    </style>
</head>
<body>




<div class="container-all" >
    <h1 style="margin-left: 30px">Information Of Student</h1>
    <div class="form-border" >
        <form action="/students/edit" method="POST">
            <input type="hidden" name="id" id="id" value="${student.id}">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" aria-describedby="name" name="name" value="${student.name}">
            </div>

            <div class="mb-3">
                <label for="age" class="form-label">Age</label>
                <input type="number" class="form-control" id="age" aria-describedby="age" name="age" value="${student.age}">
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${student.email}" >
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" value="${student.address}">
            </div>

            <button type="submit" class="btn btn-primary" >Update</button>
        </form>
    </div>
    <div class="back-to-list">
        <b><a href="/students/show" style="text-decoration: none">Back</a></b>
    </div>
</div>


</body>
</html>
