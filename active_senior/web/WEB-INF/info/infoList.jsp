<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.InfoBbsDAO" %>
<%@ page import="model.dto.InfoBbs" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="공지&정보 게시판"/>
	<jsp:param name="curTab" value="4"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
	int category = ScriptManager.categoryCheck(request, response, false);
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
		ArrayList<InfoBbs> list = InfoBbsDAO.getPostList(pageNumber, 10, category);
		for(int i = 0; i < list.size(); i++) {
	%>

	<tr>
		<td><%= list.get(i).getBbsThumbnailPath() %></td>
		<td><a href="/infoView?bbsID=<%= list.get(i).getBbsID() %>&category=<%= category %>"><%= list.get(i).getBbsTitle() %></a></td>
		<td><%= list.get(i).getSummary() %></td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
<button type="button" onclick="location.href='/infoWrite'">글쓰기</button>
<br>
<% if (pageNumber > 1) { %>
<button onclick="location.href='/infoList?pageNumber=<%= pageNumber - 1 %>&category=<%= category %>'">이전</button>
<% } if (InfoBbsDAO.nextPage(pageNumber, 10, category)) { %>
<button onclick="location.href='/infoList?pageNumber=<%= pageNumber + 1 %>&category=<%= category %>'">다음</button>
<% } %>
<jsp:include page="view/footer"/>

