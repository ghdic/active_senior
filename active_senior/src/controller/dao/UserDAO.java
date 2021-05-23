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
        return DataBaseManager.<User>insertData(user, "user");
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
            } else {
                System.out.println("hi");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // error

    }
}
