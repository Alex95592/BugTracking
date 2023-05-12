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
<title>Create New Ticket</title>
<a href="http://localhost:8080/dashboard">Dashboard</a>
</head>
<body>
<h1><c:out value="${user.id}"/></h1>
	<div>
		<form:form action="/createTicket" method="post" modelAttribute="newTicket">
			<div>
				<form:label path="name">Name:</form:label>
				<form:input path="name" type="text"/>
			</div>
			<div>
				<form:label path="importance">Importance:</form:label>
				<form:input path="importance" type="text"/>
			</div>
			<div>
				<form:label path="status">Status:</form:label>
				<form:input path="status" type="text"/>
			</div>
			<div>
				<form:label path="description">Description:</form:label>
				<form:input path="description" type="text"/>
			</div>
			<div>
				<form:label path="dueDate">Due Date:</form:label>
				<form:input path="dueDate" type="date"/>
			</div>
			<input type="hidden" path="users" value="${user.id}"/>
			<input type="submit" value="Create Ticket"/>
		</form:form>
	</div>
</body>
</html>