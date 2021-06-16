package controller.dao;

import controller.tool.DataBaseManager;
import model.dto.HireBbs;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;


public class HireBbsDAO{

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
    public static ArrayList<HireBbs> getPostList(int pageNumber, int require) throws SQLException {
        String SQL = "select * from hireBbs where bbsAvailable = 1 order by bbsID desc limit ?, ?";
        ArrayList<HireBbs> list = new ArrayList<HireBbs>();
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (pageNumber - 1) * require);
            pstmt.setInt(2, require);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                HireBbs bbs = DataBaseManager.<HireBbs>getData(rs, "hireBbs");
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public static boolean nextPage(int pageNumber, int require) throws SQLException {
        String SQL = "select bbsID from hireBbs where bbsAvailable = 1 order by bbsID desc limit ?, 1";
        Connection conn = null;
        boolean result = false;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, pageNumber * require);
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
    public static HireBbs getPost(int bbsID) throws SQLException {
        String SQL = "select * from hireBbs where bbsID = ?";
        Connection conn = null;
        HireBbs bbs = null;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                bbs = DataBaseManager.getData(rs, "hireBbs");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return bbs;
    }

    public static int deletePost(int bbsID) throws SQLException {
        String SQL = "update hireBbs set bbsAvailable = 0 where bbsID = ?";
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
        String SQL = "select userID from hireBbs where bbsID = ?";
        Connection conn = null;
        String userID = null;
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

    public static int insertHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.insertData(hireBbs, "hireBbs");
    }

    public static int updateHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException, SQLException {
        return DataBaseManager.updateData(hireBbs, "hireBbs");
    }

    public static void viewIncrease(int bbsID) throws SQLException {
        String SQL = "update hireBbs set bbsView = bbsView + 1 where bbsID = ?";
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
