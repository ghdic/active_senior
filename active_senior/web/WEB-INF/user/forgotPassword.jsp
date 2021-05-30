<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="비밀번호 초기화 페이지"/>
	<jsp:param name="curTab" value="0"/>
</jsp:include>
<%
	request.setCharacterEncoding("utf-8");
%>
<form action="/sendPassword" method="post">
	<div class="password-reset-form">
		<h1>비밀번호를 잊어버리셨습니까?</h1>
		<p>가입하실때 적은 ID와 이메일을 적어주세요.</p>
		<input type="text" placeholder="아이디" name="userID" id="userID" maxlength="30" />
		<input type="email" placeholder="이메일" name="userEmail" id="userEmail" maxlength="50" />
		<input type="submit" value="패스워드 초기화하기" />
	</div>
</form>
</body>
</html>
