package controller.servlet.info;

import controller.dao.InfoBbsDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.InfoBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/infoUpdateAction")
public class InfoUpdateAction extends HttpServlet {
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
        InfoBbs post = null;
        try {
            post = InfoBbsDAO.getPost(bbsID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        ScriptManager.checkPost(resp, post);

        InfoBbs infoBbs = PostFormManager.getPostData(req, "infoBbs", "/static/info_bbs");
        if(ScriptManager.userMatchCheck(resp, userID, post.getUserID())) {
            int result = -2;

            try {
                if (ScriptManager.checkWriteInfoBbs(resp, infoBbs)) {
                    infoBbs.setUserID(userID);
                    infoBbs.setBbsID(bbsID);
                    infoBbs.setBbsContent(ImageManager.replaceBase64toImage(infoBbs.getBbsContent(), "static/info_bbs/content"));
                    result = InfoBbsDAO.updateInfoBbs  (infoBbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
                result = -2;
            }
            ScriptManager.writeResult(resp, result, "/infoList", "updateInfoBbsContentAuto");
        }
    }
}
