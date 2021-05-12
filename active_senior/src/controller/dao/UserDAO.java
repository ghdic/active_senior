package controller.dao;


import model.dto.User;
import controller.tool.PasswordAuthentication;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
    private DataSource dataSource;
    private Connection conn;
    private PasswordAuthentication pwAuth;

    public UserDAO() {
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

    public int login(String userID, String userPW) {
        String SQL = "select userPW from user where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
                if(pwAuth.authenticate(userPW, rs.getString(1))) {
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
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, pwAuth.hash(user.getUserPW()));
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

    public int update_info(User user) {
        String SQL = "update user set ";
        if (user.getUserPW() != null) {
            SQL += String.format("userPW='%s', ", pwAuth.hash(user.getUserPW()));
        }
        if (user.getUserName() != null) {
            SQL += String.format("userName='%s', ", user.getUserName());
        }
        if (user.getUserGender() != null) {
            SQL += String.format("userGender='%s', ", user.getUserGender());
        }
        if (user.getUserEmail() != null) {
            SQL += String.format("userEmail='%s', ", user.getUserEmail());
        }
        if (user.getUserProfile() != null) {
            SQL += String.format("userProfile='%s'", user.getUserProfile());
        }
        if (SQL.substring(SQL.length()-2, SQL.length()).equals(", ")) {
            SQL = SQL.substring(0, SQL.length() - 2);
        }

        SQL += String.format(" where userID='%s'", user.getUserID());
        System.out.println(SQL);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public User getInfo(String userID) {
        String SQL = "select * from user where userID=?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUserID(rs.getString(1));
                user.setUserPW(rs.getString(2));
                user.setUserName(rs.getString(3));
                user.setUserGender(rs.getString(4));
                user.setUserEmail(rs.getString(5));
                user.setUserProfile(rs.getString(6));
                user.setUserAuthority(rs.getInt(7));
                return user;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public ArrayList<User> search(String userID){					//검색 기능
        String SQL = "select * from user where userName LIKE ?";
        ArrayList<User> userList = new ArrayList<User>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + userID + "%");
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                User user = new User();
                user.setUserID(rs.getString(1));
                user.setUserName(rs.getString(2));
                user.setUserGender(rs.getString(3));
                user.setUserEmail(rs.getString(4));
                userList.add(user);
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public int Adminregister(User user) {								//등록 기능
        String SQL = "insert into user values (?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserName());
            pstmt.setString(3, user.getUserGender());
            pstmt.setString(4, user.getUserEmail());
            return pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
}
