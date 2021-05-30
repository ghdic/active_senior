<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.EduBbsDAO" %>
<%@ page import="model.dto.EduBbs" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="교육 게시판"/>
	<jsp:param name="curTab" value="3"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
	int category = ScriptManager.categoryCheck(request, response, false);
%>

<section class="edu-card-section">
	<%
		ArrayList<EduBbs> list = EduBbsDAO.getPostList(pageNumber, 20, category);
		for(int i = 0; i < list.size(); i++) {
	%>
	<div class="edu-card" onclick="javascript:location.href = '/eduView?bbsID=<%= list.get(i).getBbsID() %>&category=<%= category %>'" style="background-image: url('<%= list.get(i).getBbsThumbnailPath() %>');">
		<div class="content-mask">
			<%
				ArrayList<String> tags = list.get(i).getTagArrayList();
				int sz = tags.size() > 3 ? 3 : tags.size();
				for(int j = 0; j < sz; j++) {
			%>
			<span class="category"><%= tags.get(j) %></span>
			<% } %>
			<h1><%= list.get(i).getBbsTitle() %></h1>
			<p><%= list.get(i).getSummary() %></p>
			<div class="post-detail">
				<span class="icon"><i class="far fa-calendar-alt">&nbsp;</i></span><span class="date"><%= list.get(i).getBbsDateSimple() %></span>
			</div>
		</div>
		<div class="horizontal"></div>
	</div>
	<% } %>
</section>

<button type="button" onclick="location.href='/eduWrite'">글쓰기</button>
<br>
<% if (pageNumber > 1) { %>
<button onclick="location.href='/eduList?pageNumber=<%= pageNumber - 1 %>&category=<%= category %>'">이전</button>
<% } if (EduBbsDAO.nextPage(pageNumber, 10, category)) { %>
<button onclick="location.href='/eduList?pageNumber=<%= pageNumber + 1 %>&category=<%= category %>'">다음</button>
<% } %>
<jsp:include page="view/footer"/>

