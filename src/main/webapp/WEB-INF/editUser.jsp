<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty errors}">
		<div class="error-messages">
			<ul>
				<c:forEach items="${errors}" var="error">
					<li>${error}</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<h1>
		Edit
		<c:out value="${user.username}" />
	</h1>
	<form:form action="/edit/user/${user.id}" method="post"
		modelAttribute="user">
		<form:errors path="username" />
		<form:errors path="password" />
		<form:errors path="email" />
		<form:errors path="confirmPassword" />
		<div>
			<form:label path="username">Change User Name</form:label>
			<form:input path="username" />
		</div>
		<div>
			<form:label path="email">Change Email</form:label>
			<form:input path="email" />
		</div>
		<div>
			<form:label path="password">Change Password </form:label>
			<form:input path="password" type="password" />
		</div>
		<div>
			<form:label path="confirmPassword">Confirm Password </form:label>
			<form:input path="confirmPassword" type="password" />
		</div>
		<input type="submit" value="Update User" />
	</form:form>

</body>
</html>