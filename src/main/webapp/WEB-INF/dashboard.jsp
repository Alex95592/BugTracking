<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@taglib
	prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>Dashboard</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid ">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
				<li class="nav-item"><a class="nav-link"
					href="http://localhost:8080/account">Account</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="http://localhost:8080/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="http://localhost:8080/newTicket">Create Ticket</a></li>

				<li class="nav-item"><c:if
						test="${roles[0].name == 'ROLE_ADMIN'}">
						<a class="nav-link" href="http://localhost:8080/users">Users</a>
					</c:if></li>
			</ul>
			<form action="" method="GET" class="d-flex">
				<select class="form-select" name="searchOption">
					<option class="dropdown-item" value=""></option>
					<option value="createdBy">Created At Up</option>
					<option value="reverseCreatedBy">Created At Down</option>
					<option value="name">Name A-Z</option>
					<option value="reverseName">Name Z-A</option>
					<option value="importance">Importance(Immediate-None)</option>
					<option value="reporter">Reporter</option>
					<option value="status">Status</option>
					<option value="reverseStatus">Status Up</option>
					<option value="dueDate">Due date Up</option>
					<option value="reverseDueDate">Due date Down</option>

				</select>
				<button style="margin-left: 10px" class="btn btn-outline-success"
					type="submit">Search</button>
			</form>
			<form action="" method="get" class="d-flex" role="search"
				style="margin-left: 10px">
				<input class="form-control me-2" type="text" name="query"
					placeholder="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
			<form method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input class="btn btn-primary"
					style="margin-left: 10px" type="submit" value="Logout" />
			</form>
		</div>
	</nav>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Bug</th>
				<th>Assigned User</th>
				<th>Importance</th>
				<th>Status</th>
				<th>Due Date</th>
				<th>Reporter</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="ticket" items="${bugTickets}">
				<tr>
					<td><a href="http://localhost:8080/ticket/${ticket.id}"><c:out
								value="${ticket.name}" /></a></td>
					<c:choose>
						<c:when test="${ticket.assignedUser == null }">
							<td>None</td>
						</c:when>
						<c:otherwise>
							<td><c:out value="${ticket.assignedUser}" /></td>
						</c:otherwise>
					</c:choose>

					<td><c:out value="${ticket.importance}" /></td>
					<td><c:out value="${ticket.status}" /></td>
					<td><fmt:formatDate value="${ticket.dueDate}" /></td>
					<td><c:out value="${ticket.users[0].username}" /></td>
					<td><form action="/delete/ticket/${ticket.id}" method="post">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="_method"
								value="delete"> <input type="submit" value="Delete"
								class="button">
						</form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>