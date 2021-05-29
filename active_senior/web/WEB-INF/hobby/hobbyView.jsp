<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.HobbyBbs" %>
<%@ page import="controller.dao.HobbyBbsDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
	<jsp:param name="curTab" value="5"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	HobbyBbs hobbyBbs = HobbyBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, hobbyBbs);
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
		<td><%= hobbyBbs.getBbsTitle() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%= hobbyBbs.getUserID() %></td>
	</tr>
	<tr>
		<td>작성일자</td>
		<td><%= hobbyBbs.getBbsDateSimple() %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%= hobbyBbs.getBbsView() %></td>
	</tr>
	<tr>
		<td>추천수</td>
		<td><%= hobbyBbs.getBbsRecommend() %></td>
	</tr>

	<tr>
		<td></td>
	</tr>
	<% if(userID != null && userID.equals(hobbyBbs.getUserID())) { %>
	<tr>
		<td><a href="/hobbyUpdate?bbsID=<%= bbsID %>">게시글 수정</a></td>
		<td><a href="/hobbyDeleteAction?bbsID=<%= bbsID %>" onclick="return confirm('정말로 삭제하시겠습니까?')">게시글 삭제</a></td>
	</tr>
	<% } %>
	</tbody>
</table>
<div class="bbs-main-content">
	<%
		out.print(hobbyBbs.getBbsContent());
	%>
</div>
<jsp:include page="view/footer"/>