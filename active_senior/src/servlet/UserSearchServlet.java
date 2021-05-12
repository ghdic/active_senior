package servlet;

import java.io.IOException;
import java.util.ArrayList;
import controller.dao.UserDAO;
import model.dto.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userID = request.getParameter("userID");
        response.getWriter().write(getJSON(userID));
    }

    public String getJSON(String userID) {
        if(userID == null) userID ="";
        StringBuffer result = new StringBuffer("");
        result.append("{\"result\":[");
        UserDAO userDAO = new UserDAO();
        ArrayList<User> userList = userDAO.search(userID);
        for(int i=0; i<userList.size();i++) {
            result.append("[{\"value\": \"" + userList.get(i).getUserID() + "\"},");
            result.append("{\"value\": \"" + userList.get(i).getUserName() + "\"},");
            result.append("{\"value\": \"" + userList.get(i).getUserGender() + "\"},");
            result.append("{\"value\": \"" + userList.get(i).getUserEmail() + "\"}],");
        }
        result.append("]}");
        return result.toString();
    }
}
