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
import java.util.HashMap;
import java.util.Iterator;

public class CommunityCommentDAO {
    private static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int getCommentCount(int bbsID) throws SQLException {
        String SQL = "select count(*) from communityComment where bbsID = ?";
        Connection conn = null;
        int result = -2;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);

            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt(1);
            } else {
                result = -1;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        conn.close();
        return result;
    }

    private static int getPos(ArrayList<CommunityComment> comments, int pid) {
        for(int i = 0; i < comments.size(); i++) {
            if (comments.get(i).getCommentID() == pid) {
                return i;
            }
        }
        return -1;
    }

    public static ArrayList<CommunityComment> getComments(int bbsID) throws SQLException {
        String SQL = "select * from communityComment where bbsID = ? order by commentID";
        ArrayList<CommunityComment> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
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
        conn.close();
        HashMap<Integer, ArrayList<CommunityComment>> ordered_dict = new HashMap<Integer, ArrayList<CommunityComment>>();
        ArrayList<CommunityComment> ordered_list = new ArrayList<>();

        for(int i = 0; i < list.size(); i++) {
            if(list.get(i).getParentID() == 0) {
                ordered_list.add(list.get(i));
            } else {
                int pos = getPos(ordered_list, list.get(i).getParentID());
                if(pos != -1) {
                    if(!ordered_dict.containsKey(list.get(i).getParentID())) {
                        ArrayList<CommunityComment> arrayList = new ArrayList<CommunityComment>();
                        arrayList.add(list.get(i));
                        ordered_dict.put(list.get(i).getParentID(), arrayList);
                    } else {
                        ordered_dict.get(list.get(i).getParentID()).add(list.get(i));
                    }
                }
            }
        }
        Iterator<Integer> keys = ordered_dict.keySet().iterator();
        while(keys.hasNext()) {
            Integer key = keys.next();
            ArrayList<CommunityComment> arrayList = ordered_dict.get(key);
            for(int i = 0; i < arrayList.size(); i++) {
                int pos = getPos(ordered_list, arrayList.get(i).getParentID());
                ordered_list.add(pos + i + 1, arrayList.get(i));
            }
        }
        return ordered_list;
    }


    public static int insertComment(CommunityComment comment) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.insertData(comment, "communityComment");
    }

    public static int updateComment(CommunityComment comment) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.updateData(comment, "communityComment");
    }

    public static int deleteComment(int commentID) throws SQLException {
        String SQL = "delete from communityComment where commentID = ?";
        Connection conn = null;
        int result = -1;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commentID);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return result;
    }

}
