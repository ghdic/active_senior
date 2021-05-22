<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="Error"/>
</jsp:include>
<%
	String msg = exception.getMessage();
	int status = response.getStatus();
%>

<h1>페이지에서 에러가 발생하였습니다. Error <%= status %></h1>
<h1> error message : <%= msg %> </h1>
<jsp:include page="View/footer.jsp"/>