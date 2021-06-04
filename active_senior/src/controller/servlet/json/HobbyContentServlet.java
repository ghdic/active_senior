package controller.servlet.json;

import com.google.gson.Gson;
import controller.dao.HobbyBbsDAO;
import model.dto.HobbyBbs;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/hobbyContent")
public class HobbyContentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        int pageNumber = 1;
        if(req.getParameter("pageNumber") != null)
            pageNumber = Integer.parseInt(req.getParameter("pageNumber"));
        int category = 0;
        if(req.getParameter("category") != null)
            category = Integer.parseInt(req.getParameter("category"));
        resp.getWriter().write(getJSON(pageNumber, 20, category));
    }

    public String getJSON(int pageNumber, int require, int category) {
        ArrayList<HobbyBbs> list = HobbyBbsDAO.getPostList(pageNumber, require, category);
        for(int i = 0; i < list.size(); i++) {
            list.get(i).setSummary(list.get(i).getSummarySlice(50));
            list.get(i).setBbsThumbnail(list.get(i).getBbsThumbnailPath());
        }
        Gson gson = new Gson();
        String result = gson.toJson(list);
        return result;
    }

}
