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
<title>Registration</title>
</head>
<body>
	<h1>Welcome!</h1>
	<ul class="nav justify-content-end">
		<li class="nav-item"><a class="nav-link active" href="/login"><button>Login</button></a></li>

		<li class="nav-item"><a class="nav-link active"
			href="/registration"><button>Register User</button></a></li>
		<li class="nav-item"><a class="nav-link active"
			href="/adminRegistration"><button>Admin Register</button></a></li>
	</ul>
	<div class="row " style="height: 100vh;">
		<div class="mx-auto col-10 col-md-8 col-lg-6">
			<p class="text-center fs-2">Register Admin</p>
			<form:form action="/adminRegistration" method="POST"
				modelAttribute="user">
				<p>
					<form:errors path="username" />
				</p>
				<p>
					<form:errors path="email" />
				</p>
				<p>
					<form:errors path="password" />
				</p>
				<p>
					<form:errors path="confirmPassword" />
				</p>
				<div>
					<form:label class="col-sm-2 col-form-label fs-6" path="username">User name:</form:label>
					<form:input class="form-control" path="username" type="text" />
				</div>
				<div>
					<form:label class="col-sm-2 col-form-label fs-6" path="email">Email:</form:label>
					<form:input class="form-control" path="email" type="text" />
				</div>
				<div>
					<form:label class="col-sm-2 col-form-label fs-6" path="password">Password:</form:label>
					<form:input class="form-control" path="password" type="password" />
				</div>
				<div>
					<form:label class="col-sm-2 col-form-label fs-6"
						path="confirmPassword">Confirm Password:</form:label>
					<form:input class="form-control" path="confirmPassword"
						type="password" />
				</div>
				<div class="d-grid justify-content-md-end" style="margin-top: 10px">
					<input class="btn btn-primary" type="submit" value="Register" />
				</div>
			</form:form>
		</div>
	</div>

</body>
</html>