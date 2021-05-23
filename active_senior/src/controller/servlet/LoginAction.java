package controller.servlet;

import controller.dao.UserDAO;
import controller.tool.ScriptManager;
import Model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/loginAction")
public class LoginAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");
        HttpSession session = req.getSession();
        User user = new User();
        user.setUserID((String)req.getParameter("userID"));
        user.setUserPW((String)req.getParameter("userPW"));

        ScriptManager.alreadyLogin(session, resp);
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPW());
        ScriptManager.loginResult(session, resp, user, result);
    }
}
