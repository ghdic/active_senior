<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="회원가입 페이지"/>
	<jsp:param name="curTab" value="0"/>
</jsp:include>
<form action="/registerAction" onsubmit="return registerSubmit()" method="post" enctype="multipart/form-data">
	<div class="register-form">
		<h1>회원가입</h1>
		<input type="text" placeholder="아이디" name="userID" id="userID" maxlength="30" />
		<input type="password" placeholder="비밀번호" name="userPW" id="userPW" maxlength="30" />
		<input type="password" placeholder="비밀번호 확인" id="verifyPW" maxlength="30">
		<input type="text" placeholder="닉네임" name="userName" id="userName" maxlength="30" />
		<div><input type="radio" name="userGender" id="boy" value="남자" checked/><label for="boy">남자</label><input type="radio" name="userGender" id="girl" value="여자"/><label for="girl">여자</label></div>
		<input type="email" placeholder="이메일" name="userEmail" id="userEmail" maxlength="50" />
		<p>프로필사진</p><input type="file" name="userProfile" id="profile" maxlength="50" accept="image/*" />
		<img src="/static/image/default/default-profile.png" alt="프로필" id="profilePreview" />
		<input type="submit" value="회원가입" />
	</div>
</form>
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
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/profilePreview.js"></script>
<jsp:include page="/view/footer"/>