package controller.servlet.recommend;

import controller.dao.RecommendTableDAO;
import controller.tool.ScriptManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/setRecommend")
public class SetRecommend extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");
        HttpSession session = req.getSession();
        String userID = ScriptManager.loginCheck(session, resp, true);
        String pUserID = ScriptManager.checkUser(req, resp);
        int bbsID = ScriptManager.checkBbs(req, resp);
        int result = -2;
        if(ScriptManager.userMatchCheck(resp, userID, pUserID)) {
            try {
                result = RecommendTableDAO.insertRecommend(bbsID, userID);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }

        ScriptManager.recommendCheck(resp, result);
        PrintWriter out = resp.getWriter();
        out.println("<script>");
        out.println("location.href = document.referrer");
        out.println("</script>");
    }
}
