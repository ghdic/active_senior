<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="계정정보 관리"/>
	<jsp:param name="curTab" value="0"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	User user = UserDAO.getUser(userID);
	ScriptManager.userInfoCheck(response, user);
%>
<form action="/accountAction" onsubmit="return registerSubmit()" method="post" enctype="multipart/form-data">
	<div class="register-form">
		<h1>회원정보수정</h1>
		<input type="text" placeholder="아이디" name="userID" id="userID" maxlength="30" value="<%= user.getUserID() %>" readonly />
		<input type="password" placeholder="비밀번호" name="userPW" id="userPW" maxlength="30" />
		<input type="password" placeholder="비밀번호 확인" id="verifyPW" maxlength="30">
		<input type="text" placeholder="닉네임" name="userName" id="userName" value="<%= user.getUserName() %>" maxlength="30" />
		<div>
			<input type="radio" name="userGender" id="boy" value="남자" <%= user.getUserGender().equals("남자") ? "checked":"" %>/>
			<label for="boy">남자</label>
			<input type="radio" name="userGender" id="girl" value="여자" <%= user.getUserGender().equals("여자") ? "checked":"" %>/>
			<label for="girl">여자</label>
		</div>
		<input type="email" placeholder="이메일" name="userEmail" id="userEmail" value="<%= user.getUserEmail() %>" maxlength="50" />
		<p>프로필사진</p><input type="file" name="userProfile" id="profile" maxlength="50" accept="image/*" />
		<img src="<%= user.getUserProfilePath() %>" alt="프로필" id="profilePreview" />
		<input type="submit" value="수정" />
	</div>
</form>
<script src="/static/js/profilePreview.js"></script>
<script>
    function registerSubmit() {
        let userPW = document.getElementById('userPW').value
        let verifyPW = document.getElementById('verifyPW').value

        if (userPW === verifyPW) {
            return true
        } else {
            alert('비밀번호가 일치하지 않습니다!')
            return false;
        }
    }
</script>
<jsp:include page="/view/footer"/>