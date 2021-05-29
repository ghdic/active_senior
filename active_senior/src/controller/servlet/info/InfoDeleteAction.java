package controller.servlet.info;

import controller.dao.InfoBbsDAO;
import controller.tool.ScriptManager;
import model.dto.InfoBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/infoDeleteAction")
class InfoDeleteAction extends HttpServlet {
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
        InfoBbs infoBbs = InfoBbsDAO.getPost(bbsID);
        if(ScriptManager.userMatchCheck(resp, userID, infoBbs.getUserID())) {
            InfoBbsDAO.deletePost(bbsID);
            resp.sendRedirect("/infoList");
        }
    }
}
