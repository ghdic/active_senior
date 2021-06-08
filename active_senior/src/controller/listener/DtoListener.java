package controller.listener;



import model.dto.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

public class DtoListener implements ServletContextListener{

    public static HashMap<String, HashMap<String, Method>> getMethod = new HashMap<String, HashMap<String, Method>>();
    public static HashMap<String, ArrayList<Method>> getMethodList = new HashMap<String, ArrayList<Method>>();
    public static HashMap<String, HashMap<String, Method>> setMethod = new HashMap<String, HashMap<String, Method>>();
    public static HashMap<String, ArrayList<Method>> setMethodList = new HashMap<String, ArrayList<Method>>();
    public static HashMap<String, Class> dtoDict = new HashMap<String, Class>() {{
        put("user", User.class);
        put("hireBbs", HireBbs.class);
        put("eduBbs", EduBbs.class);
        put("infoBbs", InfoBbs.class);
        put("hobbyBbs", HobbyBbs.class);
        put("communityBbs", CommunityBbs.class);
        put("communityComment", CommunityComment.class);
        put("recommendTable", RecommendTable.class);
    }};
    public static HashMap<String, String> primaryColumnName = new HashMap<String, String>();

    private static ArrayList<String> dtoNameList = new ArrayList<String>(
            Arrays.asList(new String[]{"user", "hireBbs", "eduBbs", "infoBbs", "hobbyBbs", "communityBbs", "communityComment", "recommendTable"})
    );
    private DataSource dataSource;
    private Connection conn;
    private ResultSet rs;

    public void contextInitialized(ServletContextEvent sce)
    {
        try {
            Context context = new InitialContext();
            context = (Context) context.lookup("java:/comp/env");
            dataSource = (DataSource) context.lookup("jdbc/mysql");
            conn = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }


        try {
            for(String dto : dtoNameList) {
                String SQL = String.format("select * from %s limit 1", dto);
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                rs = pstmt.executeQuery();
                ResultSetMetaData rsmd = rs.getMetaData();
                int colCnt = rsmd.getColumnCount();
                Class c = dtoDict.get(dto);
                HashMap<String, Method> sh = new HashMap<String, Method>();
                HashMap<String, Method> gh = new HashMap<String, Method>();
                ArrayList<Method> sa = new ArrayList<Method>();
                ArrayList<Method> ga = new ArrayList<Method>();
                for (int i = 1; i <= colCnt; i++) {
                    String colName = rsmd.getColumnName(i);
                    String sName = toSetMethodName(colName);
                    String gName = toGetMethodName(colName);
                    Method sMethod = returnMethod(c, sName);
                    Method gMethod = returnMethod(c, gName);
                    sh.put(colName, sMethod);
                    gh.put(colName, gMethod);
                    sa.add(sMethod);
                    ga.add(gMethod);
                }
                getMethod.put(dto, gh);
                setMethod.put(dto, sh);
                getMethodList.put(dto, ga);
                setMethodList.put(dto, sa);

                SQL = String.format("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = '%s' AND CONSTRAINT_NAME = 'PRIMARY'", dto);
                pstmt = conn.prepareStatement(SQL);
                rs = pstmt.executeQuery();
                if(rs.next()) {
                    primaryColumnName.put(dto, rs.getString(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void contextDestroyed(ServletContextEvent sce)
    {
        return;
    }

    public static Method returnMethod(Class<?> c, String name) {
        Method[] methods = c.getDeclaredMethods();
        for (Method method : methods)
            if (name.equals(method.getName()))
                return method;

        return null;
    }

    public static String toSetMethodName(String name) {
        return "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
    }

    public static String toGetMethodName(String name) {
        return "get" + name.substring(0, 1).toUpperCase() + name.substring(1);
    }

}
