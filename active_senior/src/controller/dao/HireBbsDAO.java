package controller.dao;

import controller.tool.DataBaseManager;
import Model.dto.HireBbs;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;


public class HireBbsDAO{

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
    public static ArrayList<HireBbs> getPostList(int pageNumber, int require) {
        String SQL = "select * from hireBbs where bbsAvailable = 1 order by bbsID desc limit ?, ?";
        ArrayList<HireBbs> list = new ArrayList<HireBbs>();
        try {
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
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public static boolean nextPage(int pageNumber, int require) {
        String SQL = "select bbsID from hireBbs where bbsAvailable = 1 order by bbsID desc limit ?, 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, pageNumber * require);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // bbsID 로부터 post 가져옴
    public static HireBbs getPost(int bbsID) {
        String SQL = "select * from hireBbs where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return DataBaseManager.<HireBbs>getData(rs, "hireBbs");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int deletePost(int bbsID) {
        String SQL = "update hireBbs set bbsAvailable = 0 where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static int insertHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException {
        return DataBaseManager.<HireBbs>insertData(hireBbs, "hireBbs");
    }

    public static int updateHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException {
        return DataBaseManager.<HireBbs>updateData(hireBbs, "hireBbs");
    }

}
