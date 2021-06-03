package controller.servlet.edu;

import controller.dao.EduBbsDAO;
import controller.dao.UserDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.EduBbs;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/eduWriteAction")
public class EduWriteAction extends HttpServlet {
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
        User user = UserDAO.getUser(userID);
        EduBbs eduBbs = PostFormManager.getPostData(req, "eduBbs", "/static/edu_bbs");
        int result = -2;
        try {
            if(ScriptManager.checkWriteEduBbs(resp, eduBbs)) {
                eduBbs.setUserID(userID);
                eduBbs.setUserName(user.getUserName());
                eduBbs.setBbsContent(ImageManager.replaceBase64toImage(eduBbs.getBbsContent(), "static/edu_bbs/content"));
                result = EduBbsDAO.insertEduBbs(eduBbs);
            } else return;
        } catch (Exception e) {
            e.printStackTrace();
            result = -2;
        }
        ScriptManager.writeResult(resp, result, "/eduList", "writeEduBbsContentAuto");
    }
}
