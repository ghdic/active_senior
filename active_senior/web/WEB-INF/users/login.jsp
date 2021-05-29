<%@ page import="controller.tool.ScriptManager" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="로그인 페이지"/>
</jsp:include>
<%
	ScriptManager.alreadyLogin(session, response);
%>
<form action="/loginAction" method="post">
	<div class="login-form">
		<img src="/static/image/active_senior.png" alt="logo">
		<h1>로그인</h1>
		<span></span>
		<input type="text" placeholder="UserID" name="userID" maxlength="30" autocomplete="off"/>
		<input type="password" name="userPW" placeholder="Password" maxlength="30"/>
		<input type="submit" name="userPW" value="Sing in">
		<p>
			<a href="/register">회원가입</a>/<a href="/forgotPassword">Forgot Password?</a>
		</p>
	</div>
</form>
<jsp:include page="/view/footer"/>