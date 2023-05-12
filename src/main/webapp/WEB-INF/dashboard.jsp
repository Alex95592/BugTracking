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
<title>Dashboard</title>
</head>
<body>
	<h1>Dashboard</h1>
	<a href="http://localhost:8080/newTicket">Create Ticket</a>
	<a href="http://localhost:8080/logout">Logout</a>
	<h1><c:out value="${user.username}"></c:out></h1>
	
	<table>
		<thead>
			<tr>Bug</tr>
			<tr>Importance</tr>
			<tr>Status</tr>
			<tr>Due Date</tr>
			<tr>Reporter</tr>
		</thead>
		<tbody>
		<c:forEach var="ticket" items="${bugTickets}">
			<tr>
				<td><c:out value="${ticket.name}"/></td>
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