package controller.servlet.hobby;

import controller.dao.HobbyBbsDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.HobbyBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/hobbyUpdateAction")
public class HobbyUpdateAction extends HttpServlet {
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
        HobbyBbs post = HobbyBbsDAO.getPost(bbsID);
        ScriptManager.checkPost(resp, post);

        HobbyBbs hobbyBbs = PostFormManager.getPostData(req, "hobbyBbs", "/static/hobby_bbs");
        if(ScriptManager.userMatchCheck(resp, userID, post.getUserID())) {
            int result = -2;

            try {
                if (ScriptManager.checkWriteHobbyBbs(resp, hobbyBbs)) {
                    hobbyBbs.setUserID(userID);
                    hobbyBbs.setBbsID(bbsID);
                    hobbyBbs.setBbsContent(ImageManager.replaceBase64toImage(hobbyBbs.getBbsContent(), "static/hobby_bbs/content"));
                    result = HobbyBbsDAO.updateHobbyBbs(hobbyBbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
                result = -2;
            }
            ScriptManager.writeResult(resp, result, "/hobbyList", "updateHobbyBbsContentAuto");
        }
    }
}
