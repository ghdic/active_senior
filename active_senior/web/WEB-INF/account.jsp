<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="Model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="계정정보 관리"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	User user = UserDAO.getUser(userID);
	ScriptManager.userInfoCheck(response, user);
%>
<form action="/accountAction" method="post" enctype="multipart/form-data">
	<h3>회원가입 화면</h3>
	<label for="userID">아이디:</label>
	<input type="text" placeholder="아이디" name="userID" id="userID" maxlength="30" value="<%= user.getUserID() %>" readonly><br>
	<label for="userPW">비밀번호:</label>
	<input type="password" placeholder="비밀번호" name="userPW" id="userPW" maxlength="30"><br>
	<label for="userName">닉네임:</label>
	<input type="text" placeholder="이름" name="userName" id="userName" value="<%= user.getUserName() %>" maxlength="30"><br>
	<div>
		<input type="radio" name="userGender" value="남자" <%= user.getUserGender().equals("남자") ? "checked":"" %>>남자
		<input type="radio" name="userGender" value="여자" <%= user.getUserGender().equals("여자") ? "checked":"" %>>여자
	</div>
	<label for="userEmail">이메일:</label>
	<input type="text" placeholder="이메일" name="userEmail" id="userEmail" maxlength="50" value="<%= user.getUserEmail() %>"><br>
	<label for="profile">프로필사진:</label>
	<input type="file" name="userProfile" id="profile" maxlength="50" accept="image/*"><br>
	<img src="<%= user.getUserProfilePath() %>" alt="프로필" id="profilePreview" width="100px" height="100px">

	<input type="submit" value="업데이트">
</form>
<script src="/static/profilePreview.js"></script>
<jsp:include page="/view/footer"/>