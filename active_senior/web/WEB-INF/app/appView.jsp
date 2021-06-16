<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="controller.tool.DateManger" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.dao.RecommendTableDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
	<jsp:param name="curTab" value="2"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	HireBbs hireBbs = HireBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, hireBbs);
	HireBbsDAO.viewIncrease(bbsID);
	User user = UserDAO.getUser(hireBbs.getUserID());
	ArrayList<String> recommendTable = RecommendTableDAO.getRecommends(bbsID);
%>

<div class="board">
	<h3 class="bbs-view-title"><%= hireBbs.getBbsTitle() %></h3>
	<ul class="info">
		<li>
			<img src="<%= user.getUserProfilePath() %>" alt="thumbnail" width="50" height="50">
		</li>
		<li>
			<i class="fas fa-user"></i><span>작성자: <%= hireBbs.getUserName() %></span>
		</li>
		<li>
			<i class="far fa-eye"></i></li><span>조회수: <%= hireBbs.getBbsView() + 1 %></span>
		<li>
			<i class="far fa-thumbs-up"></i><span>추천수: <%= recommendTable.size() %></span>
		</li>
		<li style="float:right;">
			<i class="far fa-clock"></i><span><%= hireBbs.getBbsDateSimple() %></span>
		</li>
		<% if(userID != null && userID.equals(hireBbs.getUserID())) { %>
		<li>
			<a href="/appUpdate?bbsID=<%= bbsID %>" class="edit-button"><span>수정</span></a>
			<a href="/appDeleteAction?bbsID=<%= bbsID %>" class="remove-button" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		</li>
		<% } %>
	</ul>

	<table class="tb-row">
		<tbody>
		<tr>
			<th>상태</th>
			<td><%= hireBbs.getBbsState() %></td>
		</tr>
		<tr>
			<th>모집인원</th>
			<td><%= hireBbs.getRecruitNum() %></td>
		</tr>
		<tr>
			<th>기관</th>
			<td><%= hireBbs.getAgency() %></td>
		</tr>
		<tr>
			<th>모집부서</th>
			<td><%= hireBbs.getDepartment() %></td>
		</tr>
		<tr>
			<th>모집기간</th>
			<td><%= hireBbs.getRecruitStartSimple() %> ~ <%= hireBbs.getRecruitEndSimple()%></td>
		</tr>
		<tr>
			<th>교육기간</th>
			<td><%= hireBbs.getEduStartSimple() %> ~ <%= hireBbs.getEduEndSimple() %></td>
		</tr>
		<tr>
			<th>수행기간</th>
			<td><%= hireBbs.getActiveStartSimple() %> ~ <%= hireBbs.getActiveEndSimple() %></td>
		</tr>
		</tbody>
	</table>

	<div class="bbs-main-content">
		<%
			out.print(hireBbs.getBbsContent());
		%>
	</div>
	<div class="recommend-section">
		<% if (userID == null) { %>
		<a href="javascript:location.href = '/login'" onclick="return confirm('추천을 하시려면 로그인을 먼저해주세요!')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } else if (recommendTable.contains(userID)) {  %>
		<a href="javascript:recommend(false)" style="box-shadow: 10px 5px 5px cornflowerblue" onclick="return confirm('추천을 취소하시겠습니까??')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } else { %>
		<a href="javascript:recommend(true)" onclick="return confirm('이 게시글을 추천하시겠습니까?')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } %>
	</div>
</div>

<script>
    function recommend(check) {
        let form = document.createElement("form")
        form.method = "post"
        if (check === true) {
            form.action = '/setRecommend'
        } else {
            form.action = '/cancelRecommend'
        }

        let input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "bbsID")
        input.setAttribute("value", "<%= bbsID %>")
        form.appendChild(input)

        input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "userID")
        input.setAttribute("value", "<%= userID %>")
        form.appendChild(input)

        document.body.appendChild(form)
        form.submit()
    }
</script>
<jsp:include page="view/footer"/>