package controller.servlet.cmnty;

import controller.dao.CommunityBbsDAO;
import controller.dao.UserDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.CommunityBbs;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cmntyWriteAction")
public class CmntyWriteAction extends HttpServlet {
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
        CommunityBbs communityBbs = PostFormManager.getPostData(req, "communityBbs", "/static/cmnty_bbs");
        int result = -2;
        try {
            if(ScriptManager.checkWriteCmntyBbs(resp, communityBbs)) {
                communityBbs.setUserID(userID);
                communityBbs.setUserName(user.getUserName());
                communityBbs.setBbsContent(ImageManager.replaceBase64toImage(communityBbs.getBbsContent(), "static/cmnty_bbs/content"));
                result = CommunityBbsDAO.insertCommunityBbs(communityBbs);
            } else return;
        } catch (Exception e) {
            e.printStackTrace();
            result = -2;
        }
        ScriptManager.writeResult(resp, result, "/cmntyList", "writeCommunityBbsContentAuto");
    }
}
