package controller.servlet.cmnty;
import controller.dao.CommunityBbsDAO;
import controller.dao.CommunityCommentDAO;
import controller.dao.UserDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.CommunityBbs;
import model.dto.CommunityComment;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet("/cmntyCommentAction")
public class ComntyCommentAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");
        HttpSession session = req.getSession();
        PrintWriter out = resp.getWriter();
        String userID = ScriptManager.loginCheck(session, resp, true);
        User user = null;
        try {
            user = UserDAO.getUser(userID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        String method = req.getParameter("method");
        CommunityComment comment = new CommunityComment();
        if(method.equals("create")) {
            comment.setBbsID(Integer.parseInt(req.getParameter("bbsID")));
            comment.setUserID(user.getUserID());
            comment.setUserName(user.getUserName());
            comment.setParentID(Integer.parseInt(req.getParameter("parentID")));
            comment.setComment(req.getParameter("comment"));
            try {
                CommunityCommentDAO.insertComment(comment);
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        } else if(method.equals("delete")) {
            try {
                CommunityCommentDAO.deleteComment(Integer.parseInt(req.getParameter("commentID")));
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        } else if(method.equals("update")) {
            comment.setCommentID(Integer.parseInt(req.getParameter("commentID")));
            comment.setComment(req.getParameter("comment"));
            try {
                CommunityCommentDAO.updateComment(comment);
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            out.println("<script>");
            out.println("window.opener.location.reload()");
            out.println("window.close()");
            out.println("</script>");
        }


        out.println("<script>");
        out.println("location.href = document.referrer");
        out.println("</script>");
    }
}
