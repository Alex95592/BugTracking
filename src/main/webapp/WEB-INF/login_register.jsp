<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login and Registration</title>
</head>
<body>
<div>
	<h1>Welcome!</h1>
	
	<div>
		<h1>Please Login</h1>
		<form:form action="/loginUser" method="post" modelAttribute="newLogin">
			<div>
				<form:label path="email">Email:</form:label>
				<form:input path="email" type="email"/>
			</div>
			<div>
				<form:label path="password">Password:</form:label>
				<form:input path="password" type="password"/>
			</div>
			<input type="submit" value="Login"/>
		</form:form>
	</div>
	<hr>
	<div>
		<form:form action="/registerUser" method="post" modelAttribute="newUser">
			<div>
				<form:label path="username">User name:</form:label>
				<form:input path="username" type="text"/>
			</div>
			<div>
				<form:label path="email">Email:</form:label>
				<form:input path="email" type="text"/>
			</div>
			<div>
				<form:label path="password">Password:</form:label>
				<form:input path="password" type="password"/>
			</div>
			<div>
				<form:label path="confirmPassword">Confirm Password:</form:label>
				<form:input path="confirmPassword" type="password"/>
			</div>
			<input type="submit" value="Register"/>
		</form:form>
	</div>
</div>
</body>
</html>