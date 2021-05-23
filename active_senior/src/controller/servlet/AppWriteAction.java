package controller.servlet;

import controller.dao.HireBbsDAO;
import controller.tool.ImageManager;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.HireBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;

@WebServlet("/appWriteAction")
public class AppWriteAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = ScriptManager.loginCheck(session, resp, true);
        HireBbs hireBbs = PostFormManager.<HireBbs>getPostData(req, "hireBbs", "/static/hire_bbs");
        try {
            if(!ScriptManager.checkWirteHireBbs(resp, hireBbs)) {
                hireBbs.setUserID((String) session.getAttribute("userID"));
                hireBbs.setBbsContent(ImageManager.replaceBase64toImage(hireBbs.getBbsContent(), "static/hire_bbs/content"));
                int result = HireBbsDAO.insertHireBbs(hireBbs);
                ScriptManager.writeResult(resp, result, "/appList");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
