<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid ">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
				<li class="nav-item"><a class="nav-link" href="">Account</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="http://localhost:8080/">Home</a></li>

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
	<div>
		<div class="row " style="height: 100vh;">
			<div class="mx-auto col-10 col-md-8 col-lg-6">
				<h1>Create Ticket</h1>
				<form:form action="/newTicket" method="POST"
					modelAttribute="newTicket">
					<div>
						<p>
							<form:errors path="name" />
						</p>
						<p>
							<form:errors path="importance" />
						</p>
						<p>
							<form:errors path="status" />
						</p>
						<p>
							<form:errors path="description" />
						</p>
						<p>
							<form:errors path="dueDate" />
						</p>
						<p>
							<form:errors path="recreationSteps" />
						</p>
					</div>
					<div class="col-auto">
						<form:label path="name" class="form-label">Name:</form:label>
						<form:input path="name" type="text" class="form-control" />
					</div>
					<div>
						<form:label path="importance" class="form-label">Importance:</form:label>
						<form:select path="importance" class="form-select">
							<form:option value="" selected="selected">
							</form:option>
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
						<form:textarea path="description" rows="5" class="form-control" />
					</div>
					<div>
						<form:label path="recreationSteps" class="form-label">Recreation Steps:</form:label>
						<form:textarea path="recreationSteps" rows="5"
							class="form-control" />
					</div>
					<div>
						<form:label path="dueDate" class="form-label">Due Date:</form:label>
						<form:input path="dueDate" type="datetime-local"
							class="form-control" />
					</div>
					<div>
						<form:label path="assignedUser" class="form_label">Assigned User:</form:label>
						<form:select path="assignedUser" class="form-select">
							<form:option value="" selected="selected"></form:option>
							<c:forEach var="user" items="${allUsers}">
								<form:option value="${user.username}" selected="selected">
									<c:out value="${user.username}" />
								</form:option>
							</c:forEach>
						</form:select>
					</div>
					<form:input type="hidden" path="users" value="${user.id}" />
					<div class="d-grid justify-content-md-end">

						<input type="submit" type="submit" class="btn btn-primary"
							style="margin-top: 10px;" value="Create Ticket" />
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>