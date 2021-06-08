package controller.dao;

import controller.tool.DataBaseManager;
import controller.tool.PasswordAuthentication;
import model.dto.EduBbs;
import model.dto.RecommendTable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RecommendTableDAO {
    private static DataSource dataSource;
    private static Connection conn;
    private static PasswordAuthentication pwAuth;

    static {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
            conn = dataSource.getConnection();
            pwAuth = new PasswordAuthentication();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<String> getRecommends(int bbsID) {
        String SQL = "select userID from recommendTable where bbsID = ?";
        ArrayList<String> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                RecommendTable table = DataBaseManager.getData(rs, "recommendTable");
                list.add(table.getUserID());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    public static int cancelRecommend(int bbsID, String userID) {
        String SQL = "delete from recommendTable where bbsID = ? and userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;
    }

    public static int insertRecommend(int bbsID, String userID) {
        String SQL = "insert into recommendTable (bbsID, userID) values (?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;
    }
}
