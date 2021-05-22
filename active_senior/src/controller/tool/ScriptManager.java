package controller.tool;

import model.dto.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class ScriptManager {

    public static String alreadyLogin(HttpSession session, HttpServletResponse response) throws IOException {
        String userID = null;
        PrintWriter out = response.getWriter();

        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID != null) {
            out.println("<script>");
            out.println("alert('이미 로그인이 되어있습니다!')");
            out.println("location.href = '/'");
            out.println("</script>");
        }

        return userID;
    }

    public static String loginCheck(HttpSession session, HttpServletResponse response) throws IOException {
        String userID = null;
        PrintWriter out = response.getWriter();

        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            out.println("<script>");
            out.println("alert('로그인을 해주세요!')");
            out.println("location.href = '/login'");
            out.println("</script>");
        }

        return userID;
    }

    public static void loginResult(HttpSession session, HttpServletResponse resp, User user, int result) throws IOException {
//        resp.setContentType("text/html; charset=UTF-8");
//        resp.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();

        if (result == 1) {
            session.setAttribute("userID", user.getUserID());
            out.println("<script>");
            out.println("location.href = '/'");
            out.println("</script>");
        } else if (result == 0) {
            out.println("<script>");
            out.println("alert('비밀번호가 틀립니다')");
            out.println("history.back()");
            out.println("<script>");
        } else if (result == -1) {
            out.println("<script>");
            out.println("alert('존재하지 않는 아이디입니다.')");
            out.println("history.back()");
            out.println("</script>");
        } else if (result == -2) {
            out.println("<script>");
            out.println("alert('데이터 베이스 오류가 발생했습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
        out.println("</script>");
    }
}
