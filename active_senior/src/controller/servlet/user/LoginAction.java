package controller.servlet.user;

import controller.dao.UserDAO;
import controller.tool.ScriptManager;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

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
        int result = 0;
        try {
            result = UserDAO.login(user.getUserID(), user.getUserPW());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        ScriptManager.loginResult(session, resp, user, result);
    }
}
