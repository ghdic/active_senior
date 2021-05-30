<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.CommunityBbsDAO" %>
<%@ page import="model.dto.CommunityBbs" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="커뮤니티 리스트"/>
	<jsp:param name="curTab" value="6"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
%>
<table style="text-align: center" border="1px">
	<thead>
	<tr>
		<th>섬네일</th>
		<th>제목</th>
	</tr>
	</thead>
	<tbody>
	<%
		ArrayList<CommunityBbs> list = CommunityBbsDAO.getPostList(pageNumber, 10, 0);
		for(int i = 0; i < list.size(); i++) {
	%>

	<tr>
		<td><%= list.get(i).getBbsThumbnailPath() %></td>
		<td><a href="/cmntyView?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
		<td><%= list.get(i).getSummary() %></td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
<button type="button" onclick="location.href='/cmntyWrite'">글쓰기</button>
<br>
<% if (pageNumber > 1) { %>
<button onclick="location.href='/cmntyList?pageNumber=<%= pageNumber - 1 %>'">이전</button>
<% } if (CommunityBbsDAO.nextPage(pageNumber, 10, 0)) { %>
<button onclick="location.href='/cmntyList?pageNumber=<%= pageNumber + 1 %>'">다음</button>
<% } %>
<jsp:include page="view/footer"/>
