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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous">
</head>
<body>
<a href="http://localhost:8080/dashboard">Dashboard</a>
<h1><c:out value="${user.username}"/></h1>
	<div>
		<form:form action="/createTicket" method="post" modelAttribute="newTicket">
			<div class="col-auto">
				<form:label path="name" class="form-label">Name:</form:label>
				<form:input path="name" type="text"  class="form-control"/>
			</div>
			<div>
				<form:label path="importance" class="form-label">Importance:</form:label>
				<form:select path="importance" class="form-select">
					<form:option value="" selected="selected"> </form:option>
					<form:option value="None">None</form:option>
					<form:option value="Low">Low</form:option>
					<form:option value="Medium">Medium</form:option>
					<form:option value="High">High</form:option>
					<form:option value="Immediate">Immediate</form:option>
				</form:select>
			</div>
			<div>
				<form:label path="status" class="form-label">Status:</form:label>
				<form:select path="status" class="form-select">
					<form:option value="" selected="selected"></form:option>
					<form:option value="Open">Open</form:option>
					<form:option value="Closed">Closed</form:option>
					<form:option value="In Progress">In Progress</form:option>
				</form:select>
			</div>
			<div>
				<form:label path="description" class="form-label">Description:</form:label>
				<form:textarea path="description"  class="form-control"/>
			</div>
			<div>
				<form:label path="dueDate" class="form-label">Due Date:</form:label>
				<form:input path="dueDate" type="datetime-local" class="form-control"/>
			</div>
			<input type="hidden" path="users" value="${user.id}"/>
			<input type="submit" value="Create Ticket"/>
		</form:form>
	</div>
</body>
</html>