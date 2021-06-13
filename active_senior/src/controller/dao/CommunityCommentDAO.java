package controller.dao;

import controller.tool.DataBaseManager;
import model.dto.CommunityBbs;
import model.dto.CommunityComment;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommunityCommentDAO {
    private static DataSource dataSource;
    private static Connection conn;

    static {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
            conn = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int getCommentCount(int bbsID) {
        String SQL = "select count(*) from communityComment where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);

            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return -2;
    }

    private static int getPos(ArrayList<CommunityComment> comments, int pid) {
        for(int i = 0; i < comments.size(); i++) {
            if (comments.get(i).getCommentID() == pid) {
                return i;
            }
        }
        return -1;
    }

    public static ArrayList<CommunityComment> getComments(int bbsID) {
        String SQL = "select * from communityComment where bbsID = ?";
        ArrayList<CommunityComment> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);

            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                CommunityComment comment = DataBaseManager.getData(rs, "communityComment");
                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        ArrayList<CommunityComment> ordered_list = new ArrayList<>();
        for(int i = 0; i < list.size(); i++) {
            if(list.get(i).getParentID() == 0) {
                ordered_list.add(list.get(i));
            } else {
                int pos = getPos(ordered_list, list.get(i).getParentID());
                if(pos != -1) {
                    ordered_list.add(pos + 1, list.get(i));
                }
            }
        }
        return ordered_list;
    }

}
