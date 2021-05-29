package controller.servlet.hobby;

import controller.dao.HobbyBbsDAO;
import controller.tool.ScriptManager;
import model.dto.HobbyBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/hobbyDeleteAction")
public class hobbyDeleteAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");
        HttpSession session = req.getSession();
        String userID = ScriptManager.loginCheck(session, resp, true);
        int bbsID = ScriptManager.checkBbs(req, resp);
        HobbyBbs hobbyBbs = HobbyBbsDAO.getPost(bbsID);
        if(ScriptManager.userMatchCheck(resp, userID, hobbyBbs.getUserID())) {
            HobbyBbsDAO.deletePost(bbsID);
            resp.sendRedirect("/hobbyList");
        }
    }
}
