package servlet;

import controller.dao.UserDAO;
import model.dto.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userID = request.getParameter("userID");
        String userName = request.getParameter("userName");
        String userGender = request.getParameter("userGender");
        String userEmail = request.getParameter("userEmail");
        response.getWriter().write(register(userID, userName, userGender, userEmail) + "");
    }

    public int register(String userID, String userName, String userGender, String userEmail) {
        User user = new User();
        try {
            user.setUserID(userID);
            user.setUserName(userName);
            user.setUserGender(userGender);
            user.setUserEmail(userEmail);
        }catch(Exception e) {
            return 0; // 오류 발생
        }
        return new UserDAO().register(user); //1이 출력 되면 정상
    }
}
