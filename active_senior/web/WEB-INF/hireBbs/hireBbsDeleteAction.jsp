<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.dto.HireBbs" %>
<%
	String userID = null;
	PrintWriter script = response.getWriter();

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		script.println("<script>");
		script.println("alert('글을 삭제하려면 로그인을 해주세요!')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'hireBbs.jsp ");
		script.println("</script>");
	}
	HireBbsDAO hireBbsDAO = new HireBbsDAO();
	HireBbs hireBbs = hireBbsDAO.getPost(bbsID);

	if (hireBbs.getUserID().equals(userID)) {
	    hireBbsDAO.deletePost(bbsID);
	    response.sendRedirect("hireBbs.jsp");
	} else {
		script.println("<script>");
		script.println("alert('삭제할 권한이 없습니다.')");
		script.println("location.href = 'hireBbs.jsp ");
		script.println("</script>");
	}
%>