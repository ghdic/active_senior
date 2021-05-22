<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="로그인 페이지"/>
</jsp:include>
<form action="/loginAction" method="post">
	<h3>로그인 화면</h3>
	<label>아이디:</label> <input type="text" placeholder="아이디" name="userID" maxlength="30"><br>
	<label>비밀번호:</label> <input type="password" placeholder="비밀번호" name="userPW" maxlength="30"><br>
	<input type="submit" value="로그인">
</form>
<jsp:include page="/view/footer"/>