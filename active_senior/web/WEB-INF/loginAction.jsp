<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="controller.dao.UserDAO" %>
<jsp:useBean id="user" class="model.dto.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />

<%
	out.println("<script>");
	String userID = null;
	if(session.getAttribute("userID") != null) {
	    userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		out.println("alert('이미 로그인이 되었습니다')");
		out.println("location.href = 'index.jsp'");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPW());

	if (result == 1) {
		session.setAttribute("userID", user.getUserID());
		out.println("location.href = 'index.jsp'");
	} else if (result == 0) {
		out.println("alert('비밀번호가 틀립니다')");
		out.println("history.back()");
	} else if (result == -1) {
		out.println("alert('존재하지 않는 아이디입니다.')");
		out.println("history.back()");
	} else if (result == -2) {
		out.println("alert('데이터 베이스 오류가 발생했습니다.')");
		out.println("history.back()");
	}
	out.println("</script>");
%>
