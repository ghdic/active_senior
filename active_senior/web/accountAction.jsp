<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="controller.tool.FileManager" %>
<%@ page import="controller.dao.UserDAO" %>
<jsp:useBean id="user" class="model.dto.User" scope="page" />
<jsp:setProperty name="user" property="userPW" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userProfile" />

<%
    out.println("<script>");
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        out.println("alert('로그인이 필요합니다')");
        out.println("location.href = 'index.jsp'");
    }
    FileManager fileManager = new FileManager();
    int result = fileManager.fileUpload(request);
    if (result == -1) {
        out.println("alert('오류가 발생하였습니다..')");
        out.println("history.back()");
    }

    UserDAO userDAO = new UserDAO();
    user.setUserID(userID);
    result = userDAO.update_info(user);

    if (result == -1) {
        out.println("alert('오류가 발생하였습니다..')");
        out.println("history.back()");
    } else {
        out.println("location.href = 'account.jsp'");
    }
    out.println("</script>");
%>
