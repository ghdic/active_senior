<%@ page import="controller.tool.EmailManager" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="비밀번호가 재발급 되었습니다"/>
</jsp:include>
<%
	request.setCharacterEncoding("utf-8");
	ScriptManager.checkResetForm(response, request.getParameter("userID"), request.getParameter("userEmail"));
	User user = UserDAO.getUser(request.getParameter("userID"));
	System.out.println(user.getUserEmail() + " " + request.getParameter("userEmail"));
	ScriptManager.emailCheck(response, user.getUserEmail(), request.getParameter("userEmail"));
	String newPassword = EmailManager.getRandomPassword(20);
	int result = UserDAO.resetPassword(user.getUserID(), newPassword);
	if(ScriptManager.resetCheck(response, result)) {
		result = EmailManager.sendMail(user.getUserEmail(), "Active Senior에서 요청하신 Password Reset 메일입니다.",
				"<body style=\"background-color: #f2f3f8;\">\n" +
						"    <div class=\"reset-password\" style=\"max-width: 670px;\n" +
						"    width: 90%;\n" +
						"    background: #fff;\n" +
						"    border-radius: 3px;\n" +
						"    text-align: center;\n" +
						"    box-shadow: 0 6px 18px 0 rgba(0, 0, 0, 0.06);\n" +
						"    padding: 2rem 1rem;\n" +
						"    margin: 0 auto;\">\n" +
						"        <h1 style=\"color: #1e1e2d;\n" +
						"        font-weight: 500;\n" +
						"        margin: 0;\n" +
						"        font-size: 32px;\n" +
						"        font-family: 'Rubik', sans-serif;\">패스워드가 초기화 되었습니다</h1>\n" +
						"        <span style=\"display: inline-block;\n" +
						"        vertical-align: middle;\n" +
						"        margin: 29px 0 26px;\n" +
						"        border-bottom: 1px solid #cecece;\n" +
						"        width: 100px;\"></span>\n" +
						"        <p style=\"color: #455056;\n" +
						"        font-size: 15px;\n" +
						"        line-height: 24px;\n" +
						"        margin: 0;\">\n" +
						"            임시 패스워드가 당신의 이메일 " + user.getUserEmail() + "에 전송 되었습니다.<br><span style=\"font-size: 20px;line-height: 3rem;\">Password : " + newPassword + "</span><br>임시패스워드를 통해 로그인을 진행해주세요.\n" +
						"        </p>\n" +
						"        <a style=\"background: #20e277;\n" +
						"        text-decoration: none !important;\n" +
						"        font-weight: 500;\n" +
						"        margin-top: 35px;\n" +
						"        color: #fff;\n" +
						"        text-transform: uppercase;\n" +
						"        font-size: 14px;\n" +
						"        padding: 10px 24px;\n" +
						"        display: inline-block;\n" +
						"        border-radius: 50px;\" href=\"javascript:location.href = '/';\">확인 </a>\n" +
						"    </div>\n" +
						"</body>"
		);
		ScriptManager.checkSendEmail(response, result);
	}
%>

<div class="reset-password">
	<h1>패스워드가 초기화 되었습니다</h1>
	<span></span>
	<p>
		임시 패스워드가 당신의 이메일 <%= user.getUserEmail() %>에 전송 되었습니다.<br>임시패스워드를 통해 로그인을 진행해주세요.
	</p>
	<a href="javascript:location.href = '/login';">확인</a>
</div>

<jsp:include page="/view/footer"/>
