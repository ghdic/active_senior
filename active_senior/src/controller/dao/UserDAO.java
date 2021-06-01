package controller.dao;


import controller.tool.DataBaseManager;
import model.dto.HireBbs;
import model.dto.User;
import controller.tool.PasswordAuthentication;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
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

    public static int login(String userID, String userPW) {
        String SQL = "select userPW from user where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
                System.out.println(userPW + " " + rs.getString(1));
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

    public static int register(User user) throws InvocationTargetException, IllegalAccessException {
        user.setUserPW(PasswordAuthentication.hash(user.getUserPW()));
        return DataBaseManager.<User>insertData(user, "user");
    }

    public static int resetPassword(String userID, String password) {
        password = PasswordAuthentication.hash(password);
        String SQL = "update user set userPW = ? where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, password);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return -2;
    }

    public static int updateUser(User user) throws InvocationTargetException, IllegalAccessException {
        return DataBaseManager.<User>updateData(user, "user");
    }

    public static User getUser(String userID) {
        String SQL = "select * from user where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return DataBaseManager.<User>getData(rs, "user");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // error
    }

    public static int getUserAuthority(String userID) {
        String SQL = "select userAuthority from user where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB Error
    }

    public static ArrayList<User> getUserList(int pageNumber, int require) {
        String SQL = "select * from user limit ?, ?";
        ArrayList<User> list = new ArrayList<User>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, (pageNumber - 1) * require);
            pstmt.setInt(2, require);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                User user = DataBaseManager.<User>getData(rs, "user");
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; // 리스트가 비어있을 경우 더이상 조회 x
    }

    // 다음 페이지 존재하는지 확인
    public static boolean nextPage(int pageNumber, int require) {
        String SQL = "select userID from user limit ?, 1";
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


    public static int deleteUser(String userID) {
        String SQL = "delete from user where userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
