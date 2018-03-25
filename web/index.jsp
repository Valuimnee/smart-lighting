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

</head>
<body>
<div class="jumbotron p-3 p-md-3 mb-0">
    <div class="container-fluid pl-5">
        <h1 class="display-1">Smart city lighting</h1>
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
    <div class="col-md-6">
            <div class="form-group">
                <button class="btn btn-default" type="submit" ><a href="/controller?action=get-roads" >View Roads</a></button>
                <button class="btn btn-default"><a href="/controller?action=get-stats">Load statistics</a></button>
                <button class="btn btn-default"><a href="/controller?action=get-sensors">Check sensors</a></button>
            </div>
    </div>
 <div class="row">
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
                <c:forEach items="${requestScope.roads}" var="road">
                    <tr>
                        <td>${road.id}</td>
                        <td>${road.roadName}</td>
                        <td>${road.trafficInfo}</td>
                        <td>${road.date.toString()}
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${not empty requestScope.stats}">
            <h2>Statistics by road:</h2>
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Number of cars</th>
                </tr>
                <c:forEach items="${requestScope.stats}" var="stat">
                    <tr>
                        <td>${stat.id}</td>
                        <td>${stat.roadName}</td>
                        <td>${stat.trafficInfo}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${not empty requestScope.noRoads}">
            <h2>Roads:</h2>
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Last access date</th>
                </tr>
                <c:forEach items="${requestScope.noRoads}" var="road">
                    <tr>
                        <td>${road.id}</td>
                        <td>${road.roadName}</td>
                        <td>${road.date?road.date:"Never"}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
    <div class="col-md-6">
        <img src="output_UfffZO.gif"/>
    </div>
 </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"
        integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4"
        crossorigin="anonymous"></script>
</body>
</html>
