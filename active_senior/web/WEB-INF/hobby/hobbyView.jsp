<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.HobbyBbs" %>
<%@ page import="controller.dao.HobbyBbsDAO" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
	<jsp:param name="curTab" value="5"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	HobbyBbs hobbyBbs = HobbyBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, hobbyBbs);
	User user = UserDAO.getUser(hobbyBbs.getUserID());
%>

<div class="board">
	<h3 class="bbs-view-title"><%= hobbyBbs.getBbsTitle() %></h3>
	<ul class="info">
		<li>
			<img src="<%= user.getUserProfilePath() %>" alt="thumbnail" width="50" height="50">
		</li>
		<li>
			<i class="fas fa-user"></i><span>작성자: <%= hobbyBbs.getUserName() %></span>
		</li>
		<li>
			<i class="far fa-eye"></i></li><span>조회수: <%= hobbyBbs.getBbsView() %></span>
		<li>
			<i class="far fa-thumbs-up"></i><span>추천수: <%= hobbyBbs.getBbsRecommend() %></span>
		</li>
		<li style="float:right;">
			<i class="far fa-clock"></i><span><%= hobbyBbs.getBbsDateSimple() %></span>
		</li>
		<% if(userID != null && userID.equals(hobbyBbs.getUserID())) { %>
		<li>
			<a href="/hobbyUpdate?bbsID=<%= bbsID %>" class="edit-button"><span>수정</span></a>
			<a href="/hobbyDeleteAction?bbsID=<%= bbsID %>" class="remove-button" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		</li>
		<% } %>
	</ul>

	<div class="bbs-main-content">
		<%
			out.print(hobbyBbs.getBbsContent());
		%>
	</div>
	<div class="recommend-section">
		<a href="/hobbyDeleteAction?bbsID=<%= bbsID %>" onclick="return confirm('이 게시글을 추천하시겠습니까?')"><span><%= hobbyBbs.getBbsRecommend() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
	</div>
	<div>
		<p class="keywords">
			키워드: <span><%= hobbyBbs.getKeyword() %></span>
		</p>
		<p class="tags">
			태그: <span><%= hobbyBbs.getTag() %></span>
		</p>
	</div>
</div>

<jsp:include page="view/footer"/>