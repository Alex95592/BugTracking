<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<meta charset="ISO-8859-1">
<title>Ticket Info</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid ">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
				<li class="nav-item"><a class="nav-link" href="">Account</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="http://localhost:8080/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="http://localhost:8080/newTicket">Create Ticket</a></li>

				<li class="nav-item"><c:if
						test="${roles[0].name == 'ROLE_ADMIN'}">
						<a class="nav-link" href="http://localhost:8080/users">Users</a>
					</c:if></li>
			</ul>
			<form method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input class="btn btn-primary"
					style="margin-left: 10px" type="submit" value="Logout" />
			</form>
		</div>
	</nav>
	<div class="container text-center" style="margin-top: 50px">
		<h1>
			Ticket:
			<c:out value="${bugTicket.name}" />
		</h1>
		<h2>
			Reporter:
			<c:out value="${bugTicket.users[0].username}" />
		</h2>
		<p class="fs-4">
			Current Status:
			<c:out value="${bugTicket.status}" />
		</p>
		<p class="fs-4">
			Importance:
			<c:out value="${bugTicket.importance}" />
		</p>
		<p class="fs-4">
			Description:
			<c:out value="${bugTicket.description}" />
		</p>
		<p class="fs-4">
			Assigned User:
			<c:out value="${bugTicket.assignedUser}" />
		</p>
		<p class="fs-4">
			How to recreate:
			<c:out value="${bugTicket.recreationSteps}" />
		</p>
		<p class="fs-4">
			Due date:
			<fmt:formatDate value="${bugTicket.dueDate}" />
		</p>
	</div>



</body>
</html>