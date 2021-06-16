<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.CommunityBbsDAO" %>
<%@ page import="model.dto.CommunityBbs" %>
<%@ page import="controller.dao.CommunityCommentDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="커뮤니티 리스트"/>
	<jsp:param name="curTab" value="6"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
%>

<table class="cmnty-view">
	<thead>
	<tr>
		<th>게시글번호</th>
		<th>제목</th>
		<th>글쓴이</th>
		<th>추천</th>
		<th>조회</th>
		<th>날짜</th>
	</tr>
	</thead>
	<tbody>
	<%
		ArrayList<CommunityBbs> list = CommunityBbsDAO.getPostList(pageNumber, 20, 0);
		for(int i = 0; i < list.size(); i++) {
	%>
	<tr>
		<td><%= list.get(i).getBbsID() %></td>
		<td><a href="/cmntyView?bbsID=<%= list.get(i).getBbsID() %>">
			<%= list.get(i).getBbsTitle() %>&nbsp;
			<% int comment = CommunityCommentDAO.getCommentCount(list.get(i).getBbsID());
			if(comment != 0) { %><span>(<%= comment %>)</span></a></td><% } %>
		<td><%= list.get(i).getUserName() %></td>
		<td><%= list.get(i).getBbsRecommend() %></td>
		<td><%= list.get(i).getBbsView() %></td>
		<td><%= list.get(i).getBbsDateSimple() %></td>
	</tr>
	<% } %>
	</tbody>
</table>
<% if(userID != null) { %>
<div class="bottom">
	<button class="write-button" type="button" onclick="location.href='/cmntyWrite'">글쓰기</button>
</div>
<% } %>
<div class="botton2">
	<% if (pageNumber > 1) { %>
	<button class="prev-button" onclick="location.href='/cmntyList?pageNumber=<%= pageNumber - 1 %>'">이전</button>
	<% } if (CommunityBbsDAO.nextPage(pageNumber, 20, 0)) { %>
	<button class="next-button" onclick="location.href='/cmntyList?pageNumber=<%= pageNumber + 1 %>'">다음</button>
	<% } %>
</div>
<jsp:include page="view/footer"/>

