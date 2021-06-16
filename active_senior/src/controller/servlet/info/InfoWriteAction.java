package controller.servlet.info;

import controller.dao.InfoBbsDAO;
import controller.dao.UserDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.InfoBbs;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/infoWriteAction")
public class InfoWriteAction extends HttpServlet {
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
        InfoBbs infoBbs = PostFormManager.getPostData(req, "infoBbs", "/static/info_bbs");
        int result = -2;
        try {
            if(ScriptManager.checkWriteInfoBbs(resp, infoBbs)) {
                infoBbs.setUserID(userID);
                infoBbs.setUserName(user.getUserName());
                infoBbs.setBbsContent(ImageManager.replaceBase64toImage(infoBbs.getBbsContent(), "static/info_bbs/content"));
                result = InfoBbsDAO.insertInfoBbs(infoBbs);
            } else return;
        } catch (Exception e) {
            e.printStackTrace();
            result = -2;
        }
        ScriptManager.writeResult(resp, result, "/infoList", "writeInfoBbsContentAuto");
    }
}
