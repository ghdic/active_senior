package controller.dao;

import controller.tool.DataBaseManager;
import model.dto.EduBbs;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;


public class EduBbsDAO{

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

    // start 지점으로부터 require 개의 게시글 리스트를 가져옴
    public static ArrayList<EduBbs> getPostList(int pageNumber, int require, int category) throws SQLException {
        String SQL = "select * from eduBbs where bbsAvailable = 1 and bbsCategory= ? order by bbsID desc limit ?, ?";
        ArrayList<EduBbs> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, category);
            pstmt.setInt(2, (pageNumber - 1) * require);
            pstmt.setInt(3, require);

            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                EduBbs bbs = DataBaseManager.getData(rs, "eduBbs");
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public static boolean nextPage(int pageNumber, int require, int category) throws SQLException {
        String SQL = "select bbsID from eduBbs where bbsAvailable = 1 and bbsCategory = ? order by bbsID desc limit ?, 1";
        Connection conn = null;
        boolean result = false;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, category);
            pstmt.setInt(2, pageNumber * require);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next())
                result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return result;
    }

    // bbsID 로부터 post 가져옴
    public static EduBbs getPost(int bbsID) throws SQLException {
        String SQL = "select * from eduBbs where bbsID = ?";
        Connection conn = null;
        EduBbs bbs = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                bbs = DataBaseManager.getData(rs, "eduBbs");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return bbs;
    }

    public static int deletePost(int bbsID) throws SQLException {
        String SQL = "update eduBbs set bbsAvailable = 0 where bbsID = ?";
        Connection conn = null;
        int result = -1;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return result;
    }

    public static String getUserID(int bbsID) throws SQLException {
        String SQL = "select userID from eduBbs where bbsID = ?";
        String userID = null;
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            userID = rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return userID; // DB error
    }

    public static int insertEduBbs(EduBbs eduBbs) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.insertData(eduBbs, "eduBbs");
    }

    public static int updateEduBbs(EduBbs eduBbs) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.updateData(eduBbs, "eduBbs");
    }

    public static void viewIncrease(int bbsID) throws SQLException {
        String SQL = "update eduBbs set bbsView = bbsView + 1 where bbsID = ?";
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
    }
}
