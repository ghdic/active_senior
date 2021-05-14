<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="controller.tool.ImageManager" %>
<jsp:useBean id="hirebbs" class="model.dto.HireBbs" scope="page"/>
<jsp:setProperty name="hirebbs" property="bbsTitle"/>
<jsp:setProperty name="hirebbs" property="bbsContent"/>
<jsp:setProperty name="hirebbs" property="bbsEventState"/>
<jsp:setProperty name="hirebbs" property="bbsThumbnail"/>
<jsp:setProperty name="hirebbs" property="bbsRecruitmentNumber"/>
<jsp:setProperty name="hirebbs" property="bbsStartDate"/>
<jsp:setProperty name="hirebbs" property="bbsEndDate"/>

<%
	PrintWriter script = response.getWriter();
	script.println("<script>");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		script.println("alert('글을 쓰려면 로그인을 해주세요!')");
		script.println("location.href = 'login.jsp'");
	}
	System.out.println(hirebbs.getBbsEventState());
	System.out.println(hirebbs.getBbsEndDate().equals(null));

	if (hirebbs.getBbsTitle() == null || hirebbs.getBbsContent() == null || hirebbs.getBbsEventState() == 0 ||
		hirebbs.getBbsThumbnail() == null || hirebbs.getBbsRecruitmentNumber() == 0 || hirebbs.getBbsStartDate().equals(null) ||
		hirebbs.getBbsEndDate().equals(null)) {
		script.println("alert('입력이 안 된 사항이 있습니다')");
		script.println("history.back()");
	} else {
		HireBbsDAO hireBbsDAO = new HireBbsDAO();
		ImageManager imageManager = new ImageManager();
		hirebbs.setUserID((String) session.getAttribute("userID"));
		hirebbs.setBbsContent(imageManager.replaceBase64toImage(hirebbs.getBbsContent(), "hirebbs/content"));
		int result = hireBbsDAO.insertHireBbs(hirebbs);
		if (result == -2) {
			script.println("alert('글쓰기에 오류가 발생하였습니다.')");
			script.println("history.back()");
		} else {
			script.println("location.href = 'hireBbs.jsp'");
		}
	}
	script.println("</script>");
%>