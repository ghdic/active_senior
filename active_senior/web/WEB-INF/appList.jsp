<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="Model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.DateManger" %>
<%@ page import="controller.tool.ScriptManager" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="일자리 지원"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<table style="border: 1px solid #dddddd; text-align: center">
	<thead>
	<tr>
		<th>섬네일</th>
		<th>제목</th>
		<th>운영기관</th>
		<th>모집인원</th>
		<th>모집기간</th>
		<th>공고모집상태</th>
	</tr>
	</thead>
	<tbody>
	<%
		ArrayList<HireBbs> list = HireBbsDAO.getPostList(pageNumber, 10);
		for(int i = 0; i < list.size(); i++) {
	%>

	<tr>
		<td><%= list.get(i).getBbsThumbnailPath() %></td>
		<td><a href="/appView?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
		<td><%= list.get(i).getAgency() %></td>
		<% if(list.get(i).getRecruitNum() == -1) { %>
		<td></td>
		<% } else { %>
		<td><%= list.get(i).getRecruitNum() %></td>
		<% } %>
		<td><%= list.get(i).getRecruitStartSimple() + " ~ " + list.get(i).getRecruitEndSimple() %></td>
		<td><%= list.get(i).getBbsState() %></td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
<button type="button" onclick="location.href='/appWrite'">글쓰기</button>
<br>
<% if (pageNumber > 1) { %>
<button onclick="location.href='/appList?pageNumber=<%= pageNumber - 1 %>'">이전</button>
<% } if (HireBbsDAO.nextPage(pageNumber, 10)) { %>
<button onclick="location.href='/appList?pageNumber=<%= pageNumber + 1 %>'">다음</button>
<% } %>
<jsp:include page="view/footer"/>