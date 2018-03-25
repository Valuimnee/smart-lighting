<%--
 Created by IntelliJ IDEA.
 User: Drapegnik
 Date: 5/11/17
 Time: 12:20
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Students table</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script type="text/javascript">
        //alert("Sensor 14 road M3_5 sent no data!");
        function validate() {
            var name = document.getElementById("name");
            var group = document.getElementById("group");
            var sub1 = document.getElementById("1");
            var sub2 = document.getElementById("2");
            var sub3 = document.getElementById("3");
            var sub4 = document.getElementById("4");
            var sub5 = document.getElementById("5");
            if (name.value.length <= 0) {
                alert("Name field can't be empty!");
                return false;
            }
            if (parseInt(group.value, 10) &&
                parseInt(sub1.value, 10) &&
                parseInt(sub2.value, 10) &&
                parseInt(sub3.value, 10) &&
                parseInt(sub4.value, 10) &&
                parseInt(sub5.value, 10)) {
                return true;
            }
            alert("Group and subjects fields must be numbers!");
            return false;
        }
    </script>
</head>
<body>
<div class="jumbotron p-3 p-md-3 mb-0">
    <div class="container-fluid pl-5">
        <h1 class="display-1">Smart city lightning</h1>
        <%--<p class="display-4"></p>--%>
    </div>
</div>
<div class="container mt-4">
    <div class="row col-md-12">
        <c:if test="${true}">
            <div class="col-md-4 alert alert-danger alert-dismissible error-block" role="alert">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>Alert!</strong><br>
                <code><c:out value="Sensor 14 road M3_5 sent no data!"/></code>
            </div>
        </c:if>
    </div>

    <!--<div class="col-md-4">
        <h2>Add Student:</h2>
        <form method="POST" action="/controller?action=addStudent" onsubmit="return validate();">
            <div class="form-group">
                <label for="name">name: </label>
                <input class="form-control" id="name" type="text" name="name">
                <label for="group">group: </label>
                <input class="form-control" id="group" type="text" name="group">
            </div>
            <div class="form-group">
                <label for="1">algebra: </label>
                <input class="form-control" id="1" type="text" name="ALGEBRA">
                <label for="2">geometry: </label>
                <input class="form-control" id="2" type="text" name="GEOMETRY">
                <label for="3">java: </label>
                <input class="form-control" id="3" type="text" name="JAVA">
                <label for="4">cpp: </label>
                <input class="form-control" id="4" type="text" name="CPP">
                <label for="5">history: </label>
                <input class="form-control" id="5" type="text" name="HISTORY">
            </div>
            <div class="form-group pull-right">
                <button class="btn btn-default" type="submit">Add Student</button>
            </div>
            <div class="form-group">
                <a class="btn btn-default" href="/controller?action=getStudents">Load Students!</a>
                <a class="btn btn-default" href="/controller?action=getBadStudents">Get Bad Students!</a>
            </div>
        </form>
    </div>-->

    <div class="col-md-6">
            <div class="form-group">
                <button class="btn btn-default" type="submit" ><a href="/controller?action=get-roads" >View Roads</a></button>
                <button class="btn btn-default"><a href="/controller?action=get-stats">Load statistics</a></button>
                <button class="btn btn-default"><a href="/controller?action=get-sensors">Check sensors</a></button>
            </div>
    </div>

    <div class="col-md-6">
        <c:if test="${not empty requestScope.roads}">
            <h2>Roads:</h2>
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Traffic</th>
                    <th>Date</th>
                </tr>
                <c:forEach items="${requestScope.roads}" var="student">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.roadName}</td>
                        <td>${student.trafficInfo}</td>
                        <td>${student.date.toString()}
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>

    <div class="col-md-6">
        <c:if test="${not empty requestScope.stats}">
            <h2>Statistics by road:</h2>
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Number of cars</th>

                </tr>
                <c:forEach items="${requestScope.stats}" var="student">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.roadName}</td>
                        <td>${student.trafficInfo}</td>

                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>

    <div class="col-md-6">
        <c:if test="${not empty requestScope.noRoads}">
            <h2>Roads:</h2>
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Last access date</th>
                </tr>
                <c:forEach items="${requestScope.noRoads}" var="student">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.roadName}</td>
                        <td>${student.date?student.date:"Never"}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
    <div class="col-md-4">
        <c:if test="${not empty requestScope.badIds}">
            <h2>Bad Students:</h2>
            <table class="table">
                <tr>
                    <th>name</th>
                    <th>group</th>
                    <th>marks</th>
                    <th>delete!</th>
                </tr>
                <c:forEach items="${requestScope.students}" var="student">
                    <c:if test="${requestScope.badIds.contains(student.id)}">
                        <tr>
                            <td><c:out value="${student.name}"/></td>
                            <td><c:out value="${student.group}"/></td>
                            <td>
                                <c:forEach items="${student.marks}" var="mark">
                                    <c:out value="${mark.formatted()}"/>
                                </c:forEach>
                            </td>
                            <td><a href="/controller?action=deleteStudent&id=${student.id}">x</a></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </c:if>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
</html>
