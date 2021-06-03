package controller.servlet.edu;

import controller.dao.EduBbsDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.EduBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/eduUpdateAction")
public class EduUpdateAction extends HttpServlet {
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
        EduBbs post = EduBbsDAO.getPost(bbsID);
        ScriptManager.checkPost(resp, post);

        EduBbs eduBbs = PostFormManager.getPostData(req, "eduBbs", "/static/edu_bbs");
        if(ScriptManager.userMatchCheck(resp, userID, post.getUserID())) {
            int result = -2;

            try {
                if (ScriptManager.checkWriteEduBbs(resp, eduBbs)) {
                    eduBbs.setUserID(userID);
                    eduBbs.setBbsID(bbsID);
                    eduBbs.setBbsContent(ImageManager.replaceBase64toImage(eduBbs.getBbsContent(), "static/edu_bbs/content"));
                    result = EduBbsDAO.updateEduBbs(eduBbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
                result = -2;
            }
            ScriptManager.writeResult(resp, result, "/eduList", "updateEduBbsContentAuto");
        }
    }
}
