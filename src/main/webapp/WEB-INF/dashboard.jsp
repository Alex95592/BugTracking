<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous">
<title>Dashboard</title>
</head>
<body>
	<nav  class="navbar" style="background-color: #e3f2fd;">
		<h1>Dashboard</h1>
		<button  type="button" class="btn btn-light" ><a href="http://localhost:8080/newTicket">Create Ticket</a></button>
		<button  type="button" class="btn btn-light"><a href="http://localhost:8080/logout">Logout</a></button>
		<h1><c:out value="${user.username}"></c:out></h1>
	</nav>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Bug</th>
				<th>Importance</th>
				<th>Status</th>
				<th>Due Date</th>
				<th>Reporter</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="ticket" items="${bugTickets}">
			<tr>
				<td><a href="http://localhost:8080/ticket/${ticket.id}"><c:out value="${ticket.name}"/></a></td>
				<td><c:out value="${ticket.importance}"/></td>
				<td><c:out value="${ticket.status}"/></td>
				<td><c:out value="${ticket.dueDate}"/></td>
				<td><c:out value="${ticket.users[0].username}"/></td>
			</tr>

		</c:forEach>
		</tbody>
	</table>
</body>
</html>