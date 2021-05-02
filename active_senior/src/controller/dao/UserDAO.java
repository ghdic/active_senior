package controller.dao;


import model.dto.User;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private DataSource dataSource;
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            System.out.println(context);
            dataSource = (DataSource) context.lookup("jdbc/mysql");
            System.out.println(dataSource);
            conn = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPW) {
        String SQL = "select userPW from user where userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                if(rs.getString(1).equals(userPW)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return -1; // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    public int register(User user) {
        String SQL = "insert into user values (?, ?, ?, ?, ?, ?, Default)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPW());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            pstmt.setString(6, user.getUserProfile());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
