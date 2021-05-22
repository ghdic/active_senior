<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="회원가입 페이지"/>
</jsp:include>
<form action="/registerAction" method="post" enctype="multipart/form-data">
	<h3>회원가입 화면</h3>
	<label for="userID">아이디:</label> <input type="text" placeholder="아이디" name="userID" id="userID" maxlength="30"><br>
	<label for="userPW">비밀번호:</label> <input type="password" placeholder="비밀번호" name="userPW" id="userPW" maxlength="30"><br>
	<label for="userName">닉네임:</label> <input type="text" placeholder="이름" name="userName" id="userName" maxlength="30"><br>
	<div>
		<input type="radio" name="userGender" value="남자">남자
		<input type="radio" name="userGender" value="여자">여자
	</div>
	<label for="userEmail">이메일:</label> <input type="text" placeholder="이메일" name="userEmail" id="userEmail" maxlength="50"><br>
	<label for="userProfile">프로필사진:</label> <input type="file" name="userProfile" id="userProfile" maxlength="50"><br>

	<input type="submit" value="회원가입">
</form>
<jsp:include page="/view/footer"/>