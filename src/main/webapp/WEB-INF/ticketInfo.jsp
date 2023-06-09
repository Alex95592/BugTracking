<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		$("#myForm").hide();

		$("#showFormButton").click(function() {
			if ($("#myForm").is(":visible")) {
				$("#myForm").hide();
			} else {
				$("#myForm").show();
			}
		});
	});
</script>
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
				<li class="nav-item"><a class="nav-link"
					href="/account/${currentUser.username }">Account</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="/newTicket">Create
						Ticket</a></li>

				<li class="nav-item"><c:if
						test="${roles[0].name == 'ROLE_ADMIN'}">
						<a class="nav-link" href="/users">Users</a>
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
	<div>
		<div class="d-grid gap-2 d-md-flex justify-content-center">
			<button id="showFormButton" class="btn btn-primary">Edit
				Ticket</button>
		</div>
		<div class="mx-auto col-10 col-md-8 col-lg-6">
			<form:form id="myForm" action="/ticket/${bugTicket.id}" method="post"
				modelAttribute="bugTicket">
				<input type="hidden" name="_method" value="put">
				<p>
					<form:label path="name" class="form-label">Name:</form:label>
					<form:errors path="name" />
					<form:input path="name" class="form-control" />
				</p>
				<p>
					<form:label path="importance" class="form-label">Importance:</form:label>
					<form:errors path="importance" />
					<form:select path="importance" class="form-select">
						<form:option value="None">None</form:option>
						<form:option value="Low">Low</form:option>
						<form:option value="Medium">Medium</form:option>
						<form:option value="High">High</form:option>
						<form:option value="Immediate">Immediate</form:option>
					</form:select>
				</p>
				<p>
					<form:label path="status" class="form-label">Status:</form:label>
					<form:errors path="status" />
					<form:select path="status" class="form-select">
						<form:option value="Open">Open</form:option>
						<form:option value="Closed">Closed</form:option>
						<form:option value="In Progress">In Progress</form:option>
					</form:select>
				</p>
				<p>
					<form:label path="description" class="form-label">Description:</form:label>
					<form:errors path="description" />
					<form:textarea path="description" class="form-control" />
				</p>
				<p>
					<form:label path="recreationSteps" class="form-label">Recreation Steps:</form:label>
					<form:errors path="recreationSteps" />
					<form:textarea path="recreationSteps" class="form-control" />
				</p>
				<p>
					<form:label path="dueDate" class="form-label">Due Date:</form:label>
					<form:errors path="dueDate" />
					<form:input path="dueDate" type="date" class="form-control" />
				</p>
				<p>
					<form:label path="assignedUser" class="form-label">Assigned User:</form:label>
					<form:errors path="assignedUser" />
					<form:select path="assignedUser" class="form-select">
						<c:forEach var="user" items="${allUsers}">
							<form:option value="${user.username}" selected="selected">
								<c:out value="${user.username}" />
							</form:option>
						</c:forEach>
					</form:select>
				</p>
				<form:input type="hidden" path="users" value="${user.id}" />
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<input type="submit" value="Update Ticket" class="btn btn-primary" />
				</div>
			</form:form>
		</div>
	</div>


</body>
</html>