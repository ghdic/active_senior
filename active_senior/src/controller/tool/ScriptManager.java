package controller.tool;

import model.dto.HireBbs;
import model.dto.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;

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

    public static String loginCheck(HttpSession session, HttpServletResponse response, boolean message) throws IOException {
        String userID = null;
        PrintWriter out = response.getWriter();

        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null && message) {
            out.println("<script>");
            out.println("alert('로그인을 해주세요!')");
            out.println("location.href = '/login'");
            out.println("</script>");
        }

        return userID;
    }

    public static void loginResult(HttpSession session, HttpServletResponse resp, User user, int result) throws IOException {
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
            out.println("</script>");
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
        } else {
            out.println("<script>");
            out.println("alert('알수 없는 오류가 발생했습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static void checkResetForm(HttpServletResponse resp, String userID, String userEmail) throws IOException {
        PrintWriter out = resp.getWriter();
        if (userID == null || userEmail == null || userID.equals("") || userEmail.equals("")) {
            out.println("<script>");
            out.println("alert('입력되지 않은 값이 있습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static void resetCheck(HttpServletResponse resp, int result) throws IOException {
        PrintWriter out = resp.getWriter();
        if(result == -2) {
            out.println("<script>");
            out.println("alert('비밀번호 변경에 실패하였습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static void emailCheck(HttpServletResponse resp, String email1, String email2) throws IOException {
        PrintWriter out = resp.getWriter();
        if(email1.equals(email2)) {
            out.println("<script>");
            out.println("alert('유저 정보와 이메일이 일치하지 않습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static void checkSendEmail(HttpServletResponse resp, int result) throws IOException {
        PrintWriter out = resp.getWriter();
        if (result == -1) {
            out.println("<script>");
            out.println("alert('이메일을 전송하는데 실패하였습니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static void userInfoCheck(HttpServletResponse resp, User user) throws IOException {
        PrintWriter out = resp.getWriter();
        if(user == null) {
            out.println("<script>");
            out.println("alert('유저 정보를 가져오는데 에러가 발생하였습니다. 다시 로그인 해주세요.')");
            out.println("location.href = '/logoutAction'");
            out.println("</script>");
        }
    }

    public static void userInfoUpdate(HttpServletResponse resp, int result) throws IOException {
        PrintWriter out = resp.getWriter();
        if(result == -2) {
            out.println("<script>");
            out.println("alert('유저 정보 업데이트를 실패하였습니다..')");
            out.println("history.back()");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('유저 정보 업데이트를 성공하였습니다..')");
            out.println("location.href = '/account'");
            out.println("</script>");
        }
    }

    public static Boolean userMatchCheck(HttpServletResponse resp, String curUserID, String userID) throws IOException {
        PrintWriter out = resp.getWriter();

        if(!curUserID.equals(userID)) {
            out.println("<script>");
            out.println("alert('접근 권한이 없습니다.')");
            out.println("history.back()");
            out.println("</script>");
            return false;
        }
        return true;
    }

    public static Boolean registerCheck(HttpServletResponse resp, User user) throws IOException {
        PrintWriter out = resp.getWriter();
        if(user.getUserID().equals("") || user.getUserPW().equals("") || user.getUserName().equals("")
                || user.getUserGender().equals("") || user.getUserEmail().equals("") || user.getUserProfile().equals("")) {
            out.println("<script>");
            out.println("alert('입력되지 않은 사항이 있습니다.')");
            out.println("history.back()");
            out.println("</script>");
            return false;
        }
        return true;
    }

    public static void registerResult(HttpServletResponse resp, int result) throws IOException {
        PrintWriter out = resp.getWriter();
        if(result == -2) {
            out.println("<script>");
            out.println("alert('회원가입에 실패하셨습니다.')");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('회원가입에 성공하셨습니다.')");
            out.println("location.href = '/'");
            out.println("</script>");
        }
    }

    public static int checkBbs(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();
        int bbsID = -1;
        if (req.getParameter("bbsID") != null) {
            bbsID = Integer.parseInt(req.getParameter("bbsID"));
        }
        if(bbsID == -1) {
            out.println("<script>");
            out.println("alert('유효하지 않은 글입니다')");
            out.println("history.back()");
            out.println("</script>");
        }
        return bbsID;
    }

    public static <T> void checkPost(HttpServletResponse resp, T post) throws IOException {
        PrintWriter out = resp.getWriter();

        if (post == null) {
            out.println("<script>");
            out.println("alert('삭제되었거나 유효하지 않은 글입니다')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    public static boolean checkWirteHireBbs(HttpServletResponse resp, HireBbs hireBbs) throws IOException, ParseException {
        PrintWriter out = resp.getWriter();
        if (hireBbs.getBbsTitle().equals("") || hireBbs.getBbsContent().equals("") || hireBbs.getBbsState().equals("") ||
                hireBbs.getRecruitNum() == -1 || hireBbs.getAgency().equals("") ||
                hireBbs.getDepartment().equals("") || hireBbs.getRecruitStart().equals("") || hireBbs.getRecruitEnd().equals("") ||
                hireBbs.getEduStart().equals("") || hireBbs.getEduEnd().equals("") || hireBbs.getActiveStart().equals("") ||
                hireBbs.getActiveEnd().equals("")) {
            out.println("<script>");
            out.println("alert('입력이 안 된 사항이 있거나 잘못 입력된 데이터가 있습니다!!')");
            out.println("history.back()");
            out.println("</script>");
            return false;
        } else if (DateManger.compareDate(hireBbs.getRecruitStart(), hireBbs.getRecruitEnd()) > 0 ||
                DateManger.compareDate(hireBbs.getEduStart(), hireBbs.getEduEnd()) > 0 ||
                DateManger.compareDate(hireBbs.getActiveStart(), hireBbs.getActiveEnd()) > 0){
            out.println("<script>");
            out.println("alert('시작 날짜가 끝나는 날짜보다 큽니다')");
            out.println("history.back()");
            out.println("</script>");
            return false;
        }

        return true;
    }

    public static void writeResult(HttpServletResponse resp, int result, String href, String name) throws IOException {
        PrintWriter out = resp.getWriter();
        if (result == -2) {
            out.println("<script>");
            out.println("alert('글쓰기에 오류가 발생하였습니다.')");
            out.println("history.back()");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println(String.format("localStorage.removeItem('%s')", name));
            out.println(String.format("location.href = '%s'", href));
            out.println("</script>");
        }
    }

    public static int pageNumberCheck(HttpServletRequest req) {
        int pageNumber = 1;
        if (req.getParameter("pageNumber") != null) {
            try {
                pageNumber = Integer.parseInt(req.getParameter("pageNumber"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return pageNumber;
    }

    public static int categoryCheck(HttpServletRequest req, HttpServletResponse resp, boolean message) throws IOException {
        int category = 0;
        PrintWriter out = resp.getWriter();

        if (req.getParameter("category") != null) {
            try {
                category = Integer.parseInt(req.getParameter("category"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (message) {
            out.println("<script>");
            out.println("alert('옳지 않은 접근 방식입니다.')");
            out.println("history.back()");
            out.println("</script>");
        }
        return category;
    }
}
