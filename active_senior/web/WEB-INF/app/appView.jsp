<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="controller.tool.DateManger" %>
<%@ page import="controller.tool.ScriptManager" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	HireBbs hireBbs = HireBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, hireBbs);
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
		<td><%= hireBbs.getBbsDateSimple() %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%= hireBbs.getBbsView() %></td>
	</tr>
	<tr>
		<td>추천수</td>
		<td><%= hireBbs.getBbsRecommend() %></td>
	</tr>
	<tr>
		<td>상태</td>
		<td><%= hireBbs.getBbsState() %></td>
	</tr>
	<tr>
		<td>모집인원</td>
		<% if(hireBbs.getRecruitNum() == -1) { %>
		<td></td>
		<% } else { %>
		<td><%= hireBbs.getRecruitNum() %></td>
		<% } %>
	</tr>
	<tr>
		<td>기관</td>
		<td><%= hireBbs.getAgency()%></td>
	</tr>
	<tr>
		<td>모집부서</td>
		<td><%= hireBbs.getDepartment() %></td>
	</tr>
	<tr>
		<td>모집기간</td>
		<td><%= hireBbs.getRecruitStartSimple() %> ~ <%= hireBbs.getRecruitEndSimple() %></td>
	</tr>
	<tr>
		<td>교육기간</td>
		<td><%= hireBbs.getEduStartSimple() %> ~ <%= hireBbs.getEduEndSimple() %></td>
	</tr>
	<tr>
		<td>수행기간</td>
		<td><%= hireBbs.getActiveStartSimple() %> ~ <%= hireBbs.getActiveEndSimple() %></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<% if(userID != null && userID.equals(hireBbs.getUserID())) { %>
	<tr>
		<td><a href="/appUpdate?bbsID=<%= bbsID %>">게시글 수정</a></td>
		<td><a href="/appDeleteAction?bbsID=<%= bbsID %>" onclick="return confirm('정말로 삭제하시겠습니까?')">게시글 삭제</a></td>
	</tr>
	<% } %>
	</tbody>
</table>
<div class="bbs-main-content">
	<%
		out.print(hireBbs.getBbsContent());
	%>
</div>
<jsp:include page="view/footer"/>