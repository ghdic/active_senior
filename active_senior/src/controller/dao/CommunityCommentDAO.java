package controller.dao;

import controller.tool.DataBaseManager;
import model.dto.CommunityBbs;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CommunityCommentDAO {
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

    public static int getCommentCount(int bbsID) {
        String SQL = "select count(*) from communityComment where bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);

            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return -2;
    }

}
