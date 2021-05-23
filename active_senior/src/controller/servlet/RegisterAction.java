package controller.servlet;

import controller.dao.UserDAO;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import Model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet("/registerAction")
public class RegisterAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");
        User user = PostFormManager.<User>getPostData(req, "user", "/static/user");
        if(ScriptManager.registerCheck(resp, user)) {
            UserDAO userDAO = new UserDAO();
            int result = -2;
            try {
                result = userDAO.register(user);
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
            ScriptManager.registerResult(resp, result);
        }
    }
}
