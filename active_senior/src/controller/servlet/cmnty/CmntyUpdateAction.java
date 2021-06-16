package controller.servlet.cmnty;

import controller.dao.CommunityBbsDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
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

@WebServlet("/cmntyUpdateAction")
public class CmntyUpdateAction extends HttpServlet {
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
        CommunityBbs post = null;
        try {
            post = CommunityBbsDAO.getPost(bbsID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        ScriptManager.checkPost(resp, post);

        CommunityBbs cmntyBbs = PostFormManager.getPostData(req, "communityBbs", "/static/cmnty_bbs");
        if(ScriptManager.userMatchCheck(resp, userID, post.getUserID())) {
            int result = -2;

            try {
                if (ScriptManager.checkWriteCmntyBbs(resp, cmntyBbs)) {
                    cmntyBbs.setUserID(userID);
                    cmntyBbs.setBbsID(bbsID);
                    cmntyBbs.setBbsContent(ImageManager.replaceBase64toImage(cmntyBbs.getBbsContent(), "static/cmnty_bbs/content"));
                    result = CommunityBbsDAO.updateCommunityBbs(cmntyBbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
                result = -2;
            }
            ScriptManager.writeResult(resp, result, "/cmntyList", "updateCommunityBbsContentAuto");
        }
    }
}
