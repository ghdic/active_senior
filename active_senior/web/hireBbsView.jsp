<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="controller.tool.DateManger" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="게시글 보기"/>
</jsp:include>
<%
	String userID = null;
	PrintWriter script = response.getWriter();
	script.println("<script>");
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
	    bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0) {
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href = 'hireBbs.jsp'");
	}
	HireBbs hireBbs = new HireBbsDAO().getPost(bbsID);
	script.println("</script>");
%>
<table border="1px">
	<thead>
	<tr>
		<th>게시판 글 보기</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>글제목</td>
		<td><%= hireBbs.getBbsTitle() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%= hireBbs.getUserID() %></td>
	</tr>
	<tr>
		<td>작성일자</td>
		<td><%= DateManger.getSimpleDate(hireBbs.getBbsDate()) %></td>
	</tr>
	<% if(userID != null && userID.equals(hireBbs.getUserID())) { %>
	<tr>
		<td>게시글 수정</td>
		<td>게시글 삭제</td>
	</tr>
	<% } %>
	</tbody>
</table>
<div class="content">
	<%
		out.print(hireBbs.getBbsContent());
	%>
</div>
<jsp:include page="View/footer.jsp"/>