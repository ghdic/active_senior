package controller.servlet.edu;

import controller.dao.EduBbsDAO;
import controller.tool.ScriptManager;
import model.dto.EduBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/eduDeleteAction")
public class EduDeleteAction extends HttpServlet {
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
        EduBbs eduBbs = null;
        try {
            eduBbs = EduBbsDAO.getPost(bbsID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if(ScriptManager.userMatchCheck(resp, userID, eduBbs.getUserID())) {
            try {
                EduBbsDAO.deletePost(bbsID);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            resp.sendRedirect("/eduList");
        }
    }
}
