<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="회원가입 페이지"/>
</jsp:include>
<form action="registerAction.jsp" method="post">
	<h3>회원가입 화면</h3>
	<label>아이디:</label> <input type="text" placeholder="아이디" name="userID" maxlength="30"><br>
	<label>비밀번호:</label> <input type="password" placeholder="비밀번호" name="userPW" maxlength="30"><br>
	<label>이름:</label> <input type="text" placeholder="이름" name="userName" maxlength="30"><br>
	<div>
		<label class="btn btn-primary active">
			<input type="radio" name="userGender" value="남자" checked>남자
		</label>
		<label class="btn btn-primary">
			<input type="radio" name="userGender" value="여자">여자
		</label>
	</div>
	<label>이메일:</label> <input type="text" placeholder="이메일" name="userEmail" maxlength="50"><br>
	<label>프로필사진:</label> <input type="file" name="userProfile" maxlength="50"><br>

	<input type="submit" value="로그인">
</form>
<jsp:include page="View/footer.jsp"/>