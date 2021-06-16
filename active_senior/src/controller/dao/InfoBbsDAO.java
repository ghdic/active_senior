package controller.dao;

import controller.tool.DataBaseManager;
import model.dto.InfoBbs;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;


public class InfoBbsDAO{

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

    // start 지점으로부터 require 개의 게시글 리스트를 가져옴
    public static ArrayList<InfoBbs> getPostList(int pageNumber, int require, int category) {
        String SQL = "select * from infoBbs where bbsAvailable = 1 and bbsCategory= ? order by bbsID desc limit ?, ?";
        ArrayList<InfoBbs> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, category);
            pstmt.setInt(2, (pageNumber - 1) * require);
            pstmt.setInt(3, require);

            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                InfoBbs bbs = DataBaseManager.getData(rs, "infoBbs");
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public static boolean nextPage(int pageNumber, int require, int category) {
        String SQL = "select bbsID from infoBbs where bbsAvailable = 1 and bbsCategory = ? order by bbsID desc limit ?, 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, category);
            pstmt.setInt(2, pageNumber * require);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // bbsID 로부터 post 가져옴
    public static InfoBbs getPost(int bbsID) {
        String SQL = "select * from infoBbs where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return DataBaseManager.getData(rs, "infoBbs");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int deletePost(int bbsID) {
        String SQL = "update infoBbs set bbsAvailable = 0 where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static String getUserID(int bbsID) {
        String SQL = "select userID from infoBbs where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // DB error
    }

    public static int insertInfoBbs(InfoBbs infoBbs) throws InvocationTargetException, IllegalAccessException {
        return DataBaseManager.insertData(infoBbs, "infoBbs");
    }

    public static int updateInfoBbs(InfoBbs infoBbs) throws InvocationTargetException, IllegalAccessException {
        return DataBaseManager.updateData(infoBbs, "infoBbs");
    }

    public static void viewIncrease(int bbsID) {
        String SQL = "update infoBbs set bbsView = bbsView + 1 where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
