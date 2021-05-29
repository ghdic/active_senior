<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.CommunityBbs" %>
<%@ page import="controller.dao.CommunityBbsDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	CommunityBbs cmntyBbs = CommunityBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, cmntyBbs);
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
		<td><%= cmntyBbs.getBbsTitle() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%= cmntyBbs.getUserID() %></td>
	</tr>
	<tr>
		<td>작성일자</td>
		<td><%= cmntyBbs.getBbsDateSimple() %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%= cmntyBbs.getBbsView() %></td>
	</tr>
	<tr>
		<td>추천수</td>
		<td><%= cmntyBbs.getBbsRecommend() %></td>
	</tr>

	<tr>
		<td></td>
	</tr>
	<% if(userID != null && userID.equals(cmntyBbs.getUserID())) { %>
	<tr>
		<td><a href="/cmntyUpdate?bbsID=<%= bbsID %>">게시글 수정</a></td>
		<td><a href="/cmntyDeleteAction?bbsID=<%= bbsID %>" onclick="return confirm('정말로 삭제하시겠습니까?')">게시글 삭제</a></td>
	</tr>
	<% } %>
	</tbody>
</table>
<div class="bbs-main-content">
	<%
		out.print(cmntyBbs.getBbsContent());
	%>
</div>
<jsp:include page="view/footer"/>