<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="관리자 페이지"/>
	<jsp:param name="curTab" value="0"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(request.getSession(), response, false);
%>
<div id="tab-menu">
	<div id="tab-btn">
		<ul>
			<li class="tab-active"><a href="#user">user</a></li>
			<li><a href="#hireBbs">hireBbs</a></li>
			<li><a href="#eduBbs">eduBbs</a></li>
			<li><a href="#infoBBs">infoBbs</a></li>
			<li><a href="#hobbyBbs">hobbyBbs</a></li>
			<li><a href="#communityBbs">communityBbs</a></li>
			<li><a href="#communityComment">communityComment</a></li>
			<li><a href="#">미정</a></li>
		</ul>
	</div>
</div>
<div id="tab-cont">
	<%--User--%>
	<div class="resource">
		<div class="search-container" id="searchForm-left">
			<input type="text" id="search-bar" name="query" autocomplete="off" />
			<a href="#"><img class="search-icon" src="/static/image/search-icon.png" /></a>
		</div>
		<table class="cmnty-view">
			<thead>
			<tr>
				<th style="text-decoration: underline;">userID</th>
				<th>userPW</th>
				<th>userName</th>
				<th>userGender</th>
				<th>userEmail</th>
				<th>userProfile</th>
				<th>userAuthority</th>
			</tr>
			</thead>
			<tbody>
			<%
				ArrayList<User> userList = UserDAO.getUserList(1, 20);
				for(int i = 0; i < userList.size(); i++) {
			%>
			<tr>
				<td><%= userList.get(i).getUserID() %></td>
				<td><%= userList.get(i).getUserPW() %></td>
				<td><%= userList.get(i).getUserName() %></td>
				<td><%= userList.get(i).getUserGender() %></td>
				<td><%= userList.get(i).getUserEmail() %></td>
				<td><%= userList.get(i).getUserProfile() %></td>
				<td><%= userList.get(i).getUserAuthority() %></td>
			</tr>
			<% } %>
			</tbody>
		</table>
	</div>
	<div class="resource">
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
			<tr>
				<td>1</td>
				<td><a href="#1">나도제목이야3</a></td>
				<td>난 유저명</td>
				<td>난 추천수</td>
				<td>난 조회수</td>
				<td>2021-11-11</td>
			</tr>
			<tr>
				<td>1</td>
				<td><a href="#1">나도제목이야4</a></td>
				<td>난 유저명</td>
				<td>난 추천수</td>
				<td>난 조회수</td>
				<td>2021-11-11</td>
			</tr>
			</tbody>
		</table>
	</div>
	<div class="resource">
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
			<tr>
				<td>1</td>
				<td><a href="#1">나도제목이야5</a></td>
				<td>난 유저명</td>
				<td>난 추천수</td>
				<td>난 조회수</td>
				<td>2021-11-11</td>
			</tr>
			<tr>
				<td>1</td>
				<td><a href="#1">나도제목이야6</a></td>
				<td>난 유저명</td>
				<td>난 추천수</td>
				<td>난 조회수</td>
				<td>2021-11-11</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>

<script>
    var tabBtn = $('#tab-btn > ul > li');
    var tabCont = $('#tab-cont > div.resource');

    //컨텐츠 내용을 숨겨주세요!
    tabCont.hide().eq(0).show();

    tabBtn.click(function () {
        var target = $(this); //버튼의 타겟(순서)을 변수에 저장
        var index = target.index(); //버튼의 순서를 변수에 저장
        //alert(index);
        tabBtn.removeClass('tab-active'); //버튼의 클래스를 삭제
        target.addClass('tab-active'); //타겟의 클래스를 추가
        tabCont.css('display', 'none');
        tabCont.eq(index).css('display', 'block');
    });
</script>
<jsp:include page="/view/footer"/>