package controller.dao;

import model.dto.HireBbs;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class HireBbsDAO{

    private DataSource dataSource;
    private Connection conn;

    public HireBbsDAO() {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
            System.out.println(dataSource);
            conn = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // start 지점으로부터 require 개의 게시글 리스트를 가져옴
    public ArrayList<HireBbs> getPostList(int pageNumber, int require) {
        String SQL = "select bbsID, bbsTitle, userID, bbsDate, bbsEventState, bbsView, bbsRecommend, bbsThumbnail from hire_bbs where bbsAvailable = 1 order by bbsID desc limit ?, ?";
        ArrayList<HireBbs> list = new ArrayList<HireBbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (pageNumber - 1) * require);
            pstmt.setInt(2, require);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                HireBbs bbs = new HireBbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsEventState(rs.getInt(5));
                bbs.setBbsView(rs.getInt(6));
                bbs.setBbsRecommend(rs.getInt(7));
                bbs.setBbsThumbnail(rs.getString(8));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public boolean nextPage(int pageNumber, int require) {
        String SQL = "select bbsID from hire_bbs where bbsAvailable = 1 order by bbsID desc limit ?, 1";
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
    public HireBbs getPost(int bbsID) {
        String SQL = "select * from hire_bbs where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                HireBbs bbs = new HireBbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsEventState(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsView(rs.getInt(8));
                bbs.setBbsRecommend(rs.getInt(9));
                bbs.setBbsThumbnail(rs.getString(10));
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int writePost(String bbsTitle, String userID, String bbsContent) {
        String SQL = "insert into hire_bbs (bbsTitle, userID, bbsContent) values (?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, userID);
            pstmt.setString(3, bbsContent);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int updatePost(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "update hire_bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setInt(3, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deletePost(int bbsID) {
        String SQL = "update hire_bbs set bbsAvailable = 0 where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
