<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<title>Login</title>
</head>
<body>


	<h1>Welcome!</h1>
	<ul class="nav justify-content-end">
		<li class="nav-item"><a class="nav-link active"
			href="http://localhost:8080/registration"><button>Register
					User</button></a></li>
		<li class="nav-item"><a class="nav-link active"
			href="http://localhost:8080/adminRegistration"><button>Admin
					Register</button></a></li>
	</ul>


	<c:if test="${logoutMessage != null}">
		<c:out value="${logoutMessage}"></c:out>
	</c:if>
	<div>
		<c:if test="${errorMessage != null}">
			<c:out value="${errorMessage}"></c:out>
		</c:if>
		<div class="row " style="height: 100vh;">
			<div class="mx-auto col-10 col-md-8 col-lg-6">
				<p class="text-center fs-2">Login</p>
				<form method="POST" action="/login">
					<label class="col-sm-2 col-form-label fs-6" for="username">User
						Name</label> <input class="form-control" type="text" id="username"
						name="username" /> <label class="col-sm-2 col-form-label"
						for="password">Password</label> <input class="form-control"
						type="password" id="password" name="password" /> <input
						type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="d-grid justify-content-md-end">
						<input type="submit" class="btn btn-primary"
							style="margin-top: 10px;" value="Login!" />
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>