package controller.dao;

import controller.tool.MethodManager;
import model.dto.HireBbs;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class HireBbsDAO{

    private DataSource dataSource;
    private Connection conn;

    public HireBbsDAO() {
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
    public ArrayList<HireBbs> getPostList(int pageNumber, int require) {
        String SQL = "select * from hire_bbs where bbsAvailable = 1 order by bbsID desc limit ?, ?";
        ArrayList<HireBbs> list = new ArrayList<HireBbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (pageNumber - 1) * require);
            pstmt.setInt(2, require);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                HireBbs bbs = getHireBbs(rs);
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
                return getHireBbs(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    private HireBbs getHireBbs(ResultSet rs) throws SQLException {
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
        bbs.setBbsInstitution(rs.getString(11));
        bbs.setBbsContactInformation(rs.getString(12));
        bbs.setBbsRecruitmentNumber(rs.getInt(13));
        bbs.setBbsStartDate(rs.getString(14));
        bbs.setBbsEndDate(rs.getString(15));

        return bbs;
    }

    public int insertHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException {
        ArrayList<String> insert_attr = new ArrayList<String>();
        ArrayList<String> insert_value = new ArrayList<String>();
        for (Method method : MethodManager.findGetters(HireBbs.class)) {
            if(method.getReturnType().equals(Integer.TYPE) && (int)method.invoke(hireBbs) == -1) continue;
            if(method.invoke(hireBbs) == null) continue;
            Object obj = method.invoke(hireBbs);
            if (obj instanceof Integer)
                obj = Integer.toString((int)obj);
            else
                obj = "'" + obj + "'";
            insert_attr.add(MethodManager.getParamName(method));
            insert_value.add((String)obj);
        }
        String attr = String.join(", ", insert_attr);
        String value = String.join(", ", insert_value);
        String SQL = String.format("insert into hire_bbs (%s) values (%s)", attr, value);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // db error
    }

    public int updateHireBbs(HireBbs hireBbs) throws InvocationTargetException, IllegalAccessException {
        if(hireBbs.getBbsID() == -1)
            return -1; // bbsID가 없음
        ArrayList<String> update_list = new ArrayList<String>();
        for (Method method : MethodManager.findGetters(HireBbs.class)) {
            if(method.getReturnType().equals(Integer.TYPE) && (int)method.invoke(hireBbs) == -1) continue;
            if(method.invoke(hireBbs) == null) continue;
            Object obj = method.invoke(hireBbs);
            if (obj instanceof Integer)
                    obj = Integer.toString((int)obj);
            else
                obj = "'" + obj + "'";
            update_list.add(MethodManager.getParamName(method) + "=" + obj);
        }
        String update_col = String.join(", ", update_list);
        String SQL = String.format("update hire_bbs set %s where bbsID = ?", update_col);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, hireBbs.getBbsID());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // db error
    }

}
