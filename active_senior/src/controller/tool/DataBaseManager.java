package controller.tool;

import controller.listener.DtoListener;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;

public class DataBaseManager {

    private static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static <T> T getData(ResultSet rs, String tableName) throws SQLException, InvocationTargetException, IllegalAccessException, InstantiationException {
        T data = (T) DtoListener.dtoDict.get(tableName).newInstance();
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

    public static <T> int updateData(T dto, String tableName) throws InvocationTargetException, IllegalAccessException, SQLException {
        String primaryKey = DtoListener.primaryColumnName.get(tableName);
        String gName = DtoListener.toGetMethodName(primaryKey);
        Method gMethod = DtoListener.returnMethod(DtoListener.dtoDict.get(tableName), gName);
        ArrayList<String> update_list = new ArrayList<>();
        for (Method method : DtoListener.getMethodList.get(tableName)) {
            if(method.getReturnType().equals(Integer.TYPE)) {
                if((int)method.invoke(dto) == -1) continue;
            } else {
                if (method.invoke(dto).equals("")) continue;
            }
            Object obj = method.invoke(dto);
            if (obj instanceof Integer)
                obj = Integer.toString((int)obj);
            else {
                if(method.getName().equals("getBbsContent"))
                    obj = "'" + htmlSpecialCharacterToCodeContent(obj.toString()) + "'";
                else
                    obj = "'" + htmlSpecialCharacterToCode(obj.toString()) + "'";
            }

            update_list.add(MethodManager.getParamName(method) + "=" + obj);
        }
        String update_col = String.join(", ", update_list);
        String SQL = String.format("update %s set %s where %s = ?", tableName, update_col, primaryKey);
        Connection conn = null;
        int result = -2;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setObject(1, gMethod.invoke(dto));
            result =  pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return result;
    }


    public static <T> int insertData(T dto, String tableName) throws InvocationTargetException, IllegalAccessException, SQLException {
        ArrayList<String> insert_attr = new ArrayList<String>();
        ArrayList<String> insert_value = new ArrayList<String>();
        for (Method method : DtoListener.getMethodList.get(tableName)) {
            if(method.getReturnType().equals(Integer.TYPE)) {
                if((int)method.invoke(dto) == -1) continue;
            } else {
                if (method.invoke(dto).equals("")) continue;
            }
            Object obj = method.invoke(dto);
            if (obj instanceof Integer)
                obj = Integer.toString((int)obj);
            else {
                if(method.getName().equals("getBbsContent"))
                    obj = "'" + htmlSpecialCharacterToCodeContent(obj.toString()) + "'";
                else
                    obj = "'" + htmlSpecialCharacterToCode(obj.toString()) + "'";
            }
            insert_attr.add(MethodManager.getParamName(method));
            insert_value.add((String)obj);
        }
        String attr = String.join(", ", insert_attr);
        String value = String.join(", ", insert_value);
        String SQL = String.format("insert into %s (%s) values (%s)", tableName, attr, value);
        Connection conn = null;
        int result = -2;
        try {
            conn = dataSource.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        conn.close();
        return result;
    }

    public static String htmlSpecialCharacterToCode(String html) {
        return html.replace("'", "\"")
                .replace("\\", "&#92;")
                .replace("/", "&#47;")
                .replace("<", "&#60;")
                .replace(">", "&#62;");
    }

    public static String htmlSpecialCharacterToCodeContent(String html) {
        return html.replace("'", "\"")
                .replace("\\", "&#92;")
                .replace("<script>", "<block>")
                .replace("</script>", "</block>");
    }
}
