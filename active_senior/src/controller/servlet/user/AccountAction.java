package controller.servlet.user;

import controller.dao.UserDAO;
import controller.tool.PasswordAuthentication;
import controller.tool.PostFormManager;
import controller.tool.ScriptManager;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet("/accountAction")
public class AccountAction extends HttpServlet {
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
        User user = PostFormManager.getPostData(req, "user", "/static/user");
        ScriptManager.userInfoCheck(resp, user);

        if(ScriptManager.userMatchCheck(resp, user.getUserID(), userID)) {
            int result = -2;
            try {
                if (!user.getUserPW().equals("")) {
                    user.setUserPW(PasswordAuthentication.hash(user.getUserPW()));
                }
                result = UserDAO.updateUser(user);
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            ScriptManager.userInfoUpdate(resp, result);
        }
    }
}
