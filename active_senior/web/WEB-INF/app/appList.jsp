<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.DateManger" %>
<%@ page import="controller.tool.ScriptManager" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="일자리 지원"/>
	<jsp:param name="curTab" value="2"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
%>
<%
	ArrayList<HireBbs> list = HireBbsDAO.getPostList(pageNumber, 10);
	for(int i = 0; i < list.size(); i++) {
%>
<div class="table-container">
	<div class="table-header">
		<div class="publish-date">
			<%= list.get(i).getBbsDateSimple()%>
		</div>
	</div>
	<img src="<%= list.get(i).getBbsThumbnailPath() %>" class="table-image">
	<div class="table-body">
		<div class="table-title">
			<h1><a href="/appView?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></h1>
		</div>
		<p>운영기관:&nbsp; <%= list.get(i).getAgency() %></p>
		<p>담당부서:&nbsp;<%= list.get(i).getDepartment() %></p>
		<p>모집인원:&nbsp;<%= list.get(i).getRecruitNum() %>명</p>
		<p>모집기간:&nbsp;<%= list.get(i).getRecruitStartSimple() %>~<%= list.get(i).getRecruitEndSimple() %></p>
		<div class="table-tags">
			<div class="explain">
				<p>공고모집상태:&nbsp;</p>
				<ul class="tag">
					<li><span><%= list.get(i).getBbsState() %></span></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<% } %>

<% if(userID != null) { %>
<div class="bottom">
	<button class="write-button" type="button" onclick="location.href='/appWrite'">글쓰기</button>
</div>
<% } %>
<div class="botton2">
	<% if (pageNumber > 1) { %>
	<button class="prev-button" onclick="location.href='/appList?pageNumber=<%= pageNumber - 1 %>'">이전</button>
	<% } if (HireBbsDAO.nextPage(pageNumber, 10)) { %>
	<button class="next-button" onclick="location.href='/appList?pageNumber=<%= pageNumber + 1 %>'">다음</button>
	<% } %>
</div>
<jsp:include page="view/footer"/>