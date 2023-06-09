<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>Admin Page</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid ">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
				<li class="nav-item"><a class="nav-link" href="/account/${currentUser.username }">Account</a></li>
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
			Welcome to the Admin Page,
			<c:out value="${currentUser.username}"></c:out>
		</h1>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Username</th>
					<th>Permissions</th>
					<th>Delete</th>
					<th>Edit User</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${users}">
					<tr>
						<td><c:out value="${user.username}" /></td>
						<c:choose>
							<c:when test="${user.roles[0].name == 'ROLE_USER'}">
								<td>USER</td>
							</c:when>
							<c:otherwise>
								<td>ADMIN</td>
							</c:otherwise>
						</c:choose>
						<td><c:if test="${user.roles[0].name == 'ROLE_USER' }">
								<form action="/delete/user/${user.id}" method="post">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="hidden" name="_method"
										value="delete"> <input type="submit" value="Delete"
										class="button">
								</form>
							</c:if></td>
						<td><a href="/edit/user/${user.id}">Edit User</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>