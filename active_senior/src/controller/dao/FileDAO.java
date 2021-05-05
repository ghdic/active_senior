package controller.dao;

import Model.dto.FileDTO;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FileDAO {
    private Connection conn;

    public FileDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/file";
            String dbID = "root";
            String dbPassword = "root";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    public int upload(String fileName, String fileRealName) {
        String SQL = "INSERT INTO FILE VALUES (?, ?, 0)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, fileName);
            pstmt.setString(2, fileRealName);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int hit(String fileRealName){
        String SQL = "UPDATE FILE SET downloadCount = downloadCount + 1"
                + "WHERE fileRealName =?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, fileRealName);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<FileDTO> getList(){
        String SQL = "SELECT * FROM FILE";
        ArrayList<FileDTO> list = new ArrayList<FileDTO>();
        try{
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                FileDTO file = new FileDTO(rs.getString(1), rs.getString(2),rs.getInt(3));
                file.setFileName(rs.getString(1));
                file.setFileRealName(rs.getString(2));
                file.setDownloadCount(rs.getInt(3));
                list.add(file);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }


}

