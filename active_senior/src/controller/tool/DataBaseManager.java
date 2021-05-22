package controller.tool;

import controller.listener.DtoListener;
import model.dto.HireBbs;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;

public class DataBaseManager {

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

    public static <T> T getData(ResultSet rs, String tableName, Class<T> c) throws SQLException, InvocationTargetException, IllegalAccessException, InstantiationException {
        T data = c.newInstance();
        ResultSetMetaData rsmd = rs.getMetaData();
        int colCnt = rsmd.getColumnCount();
        for (int i = 1; i <= colCnt; i++) {
            Method method = DtoListener.setMethod.get(tableName).get(rsmd.getColumnName(i));
            if(rs.getObject(i) != null) {
                if(rsmd.getColumnTypeName(i).equals("INT")) {
                    method.invoke(data, rs.getInt(i));
                } else {
                    method.invoke(data, rs.getString(i));
                }
            }
        }
        return data;
    }


    public static <T> int insertData(T dto, String tableName) throws InvocationTargetException, IllegalAccessException {
        ArrayList<String> insert_attr = new ArrayList<String>();
        ArrayList<String> insert_value = new ArrayList<String>();
        for (Method method : DtoListener.getMethodList.get(tableName)) {
            if(method.getReturnType().equals(Integer.TYPE) && (int)method.invoke(dto) == -1) continue;
            if(method.invoke(dto) == "") continue;
            Object obj = method.invoke(dto);
            if (obj instanceof Integer)
                obj = Integer.toString((int)obj);
            else
                obj = "'" + obj + "'";
            insert_attr.add(MethodManager.getParamName(method));
            insert_value.add((String)obj);
        }
        String attr = String.join(", ", insert_attr);
        String value = String.join(", ", insert_value);
        String SQL = String.format("insert into %s (%s) values (%s)", tableName, attr, value);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // db error
    }
}
