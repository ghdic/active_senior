<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page import="model.dto.User" %>

<jsp:include page="/View/navbar.jsp">
	<jsp:param name="title" value="계정정보 관리"/>
</jsp:include>
<%

	String userID = null;
	out.println("<script>");
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		out.println("alert('로그인을 해주세요')");
		out.println("location.href = 'index.jsp'");
	}
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getInfo(userID);

	if (user == null) {
		out.println("alert('유저 아이디를 가져오는데 문제가 발생하였습니다!')");
		out.println("location.href = 'index.jsp'");
	}
	out.println("</script>");
%>
<form action="accountAction.jsp" enctype="multipart/form-data" method="post">
	<h3>계정관리 화면</h3>
	<label>비밀번호:</label> <input type="password" placeholder="비밀번호" name="userPW" maxlength="30"><br>
	<label>이름:</label> <input type="text" placeholder="이름" value="<%= user.getUserName() %>" name="userName" maxlength="30" autocomplete="off"><br>
	<div>
		<label class="btn btn-primary active">
			<input type="radio" name="userGender" value="남자" <% if (user.getUserGender().equals("남자")) { out.print("checked"); } %>>남자
		</label>
		<label class="btn btn-primary">
			<input type="radio" name="userGender" value="여자" <% if (user.getUserGender().equals("여자")) { out.print("checked"); } %>>여자
		</label>
	</div>
	<label>이메일:</label> <input type="text" placeholder="이메일" name="userEmail" value="<%= user.getUserEmail()%>" maxlength="50" autocomplete="off"><br>
	<label>프로필사진:</label> <input type="file" name="userProfile" maxlength="50"><br>

	<input type="submit" value="수정">
</form>
<jsp:include page="/View/footer.jsp"/>