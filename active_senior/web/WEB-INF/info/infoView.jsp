<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.InfoBbs" %>
<%@ page import="controller.dao.InfoBbsDAO" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.dao.RecommendTableDAO" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
	<jsp:param name="curTab" value="4"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	InfoBbs infoBbs = InfoBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, infoBbs);
	InfoBbsDAO.viewIncrease(bbsID);
	User user = UserDAO.getUser(infoBbs.getUserID());
	ArrayList<String> recommendTable = RecommendTableDAO.getRecommends(bbsID);
%>

<div class="board">
	<h3 class="bbs-view-title"><%= infoBbs.getBbsTitle() %></h3>
	<ul class="info">
		<li>
			<img src="<%= user.getUserProfilePath() %>" alt="thumbnail" width="50" height="50">
		</li>
		<li>
			<i class="fas fa-user"></i><span>작성자: <%= infoBbs.getUserName() %></span>
		</li>
		<li>
			<i class="far fa-eye"></i></li><span>조회수: <%= infoBbs.getBbsView() + 1 %></span>
		<li>
			<i class="far fa-thumbs-up"></i><span>추천수: <%= recommendTable.size() %></span>
		</li>
		<li style="float:right;">
			<i class="far fa-clock"></i><span><%= infoBbs.getBbsDateSimple() %></span>
		</li>
		<% if(userID != null && userID.equals(infoBbs.getUserID())) { %>
		<li>
			<a href="/infoUpdate?bbsID=<%= bbsID %>" class="edit-button"><span>수정</span></a>
			<a href="/infoDeleteAction?bbsID=<%= bbsID %>" class="remove-button" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		</li>
		<% } %>
	</ul>

	<div class="bbs-main-content">
		<%
			out.print(infoBbs.getBbsContent());
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

	<%
		ArrayList<String> realFileNameArrayList = infoBbs.getRealFileNameArrayList();
		ArrayList<String> originalFileNameArrayList = infoBbs.getOriginalFileNameArrayList();
		if(realFileNameArrayList.size() != 0) {
	%>
	<div class="file-downloader">
		<div class="file-uploader__message-area">첨부파일 다운로드</div>
		<ul class="file-list">
			<%
				for(int i = 0; i < realFileNameArrayList.size(); i++) {
			%>
			<li><span class="file-list__name"><%= originalFileNameArrayList.get(i) %></span><a href="<%= realFileNameArrayList.get(i) %>" class="download-button" download="<%= originalFileNameArrayList.get(i) %>"></a></li>
			<%
				}
			%>
		</ul>
	</div>
	<% } %>

	<div>
		<p class="keywords">
			키워드: <span><%= infoBbs.getKeyword() %></span>
		</p>
		<p class="tags">
			태그: <span><%= infoBbs.getTag() %></span>
		</p>
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