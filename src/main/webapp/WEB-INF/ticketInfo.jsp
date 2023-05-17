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
<title>Ticket Info</title>
</head>
<body>
<h1><c:out value="${bugTicket.name}"/></h1>
<h1> Reporter:<c:out value="${bugTicket.users[0].username}"/></h1>
<p><c:out value="${bugTicket.status}"/></p>
</body>
</html>