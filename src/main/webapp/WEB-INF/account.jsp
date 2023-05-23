<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>Insert title here</title>
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
			<form method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input class="btn btn-primary"
					style="margin-left: 10px" type="submit" value="Logout" />
			</form>
		</div>
	</nav>
	<h2>Reported Tickets</h2>
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
			<c:forEach var="ticket" items="${reportedTickets}">
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