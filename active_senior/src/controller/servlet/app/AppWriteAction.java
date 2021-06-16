package controller.servlet.app;

import controller.dao.HireBbsDAO;
import controller.dao.UserDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.HireBbs;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/appWriteAction")
public class AppWriteAction extends HttpServlet {
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
        User user = null;
        try {
            user = UserDAO.getUser(userID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        HireBbs hireBbs = PostFormManager.getPostData(req, "hireBbs", "/static/hire_bbs");
        int result = -2;
        try {
            if(ScriptManager.checkWriteHireBbs(resp, hireBbs)) {
                hireBbs.setUserID(userID);
                hireBbs.setUserName(user.getUserName());
                hireBbs.setBbsContent(ImageManager.replaceBase64toImage(hireBbs.getBbsContent(), "static/hire_bbs/content"));
                result = HireBbsDAO.insertHireBbs(hireBbs);
            } else return;
        } catch (Exception e) {
            e.printStackTrace();
            result = -2;
        }
        ScriptManager.writeResult(resp, result, "/appList", "writeHireBbsContentAuto");
    }
}
