<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Student List</title>
</head>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<style>
    /* Styling the search button */
    form button {
        background-color: #007bff; /* Primary color */
        color: #fff; /* Text color */
        border: none; /* Remove border */
        padding: 8px 16px; /* Adjust padding */
        border-radius: 4px; /* Add border-radius */
        cursor: pointer; /* Change cursor on hover */
        transition: background-color 0.3s; /* Smooth transition */
    }

    /* Hover effect */
    form button:hover {
        background-color: #0056b3; /* Darken color on hover */
    }

</style>
<body>


<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Add Student
</button>

<form action="/students/searchName" method="get">
    <input type="text" name="name" placeholder="Enter name">
    <button>Search</button>
</form>


<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/students/add" method="post">
                <div class="modal-body">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="name">Name</span>
                        <input type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="name">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="age">Age</span>
                        <input type="number" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="age">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="email">Email</span>
                        <input type="email" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="email">
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="inputGroup-sizing-default">Address</span>
                        <input type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" name="address">
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




<table id="studentTable" class="table">
    <thead>
    <tr>
        <th scope="col">ID</th>
        <th scope="col">Name Student</th>
        <th scope="col">Age</th>
        <th scope="col">Email</th>
        <th scope="col">Address</th>
        <th scope="col" colspan="2">Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${studentList}" var="stdL">
        <tr>
            <th>${stdL.id}</th>
            <td>${stdL.name}</td>
            <td>${stdL.age}</td>
            <td>${stdL.email}</td>
            <td>${stdL.address}</td>
            <td>
                <button type="button" class="btn btn-primary" style=""><a style="text-decoration: none;color:white"
                                                                          href="/students/edit/${stdL.id}">View
                    Detail</a></button>
            </td>
            <td>
                <button type="button" class="btn btn-danger" onclick="confirmDelete('${stdL.id}')">Delete</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    function confirmDelete(studentId) {
        var result = confirm("Do you want to delete student with ID: " + studentId + " ?");
        if (result) {
            window.location.href = "/students/delete/" + studentId;
        }
    }
</script>

</body>
</html>
