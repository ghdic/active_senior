package controller.servlet.cmnty;

import controller.dao.CommunityBbsDAO;
import controller.tool.ScriptManager;
import model.dto.CommunityBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cmntyDeleteAction")
public class CmntyDeleteAction extends HttpServlet {
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
        CommunityBbs communityBbs = null;
        try {
            communityBbs = CommunityBbsDAO.getPost(bbsID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if(ScriptManager.userMatchCheck(resp, userID, communityBbs.getUserID())) {
            try {
                CommunityBbsDAO.deletePost(bbsID);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            resp.sendRedirect("/cmntyList");
        }
    }
}
