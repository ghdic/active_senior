package controller.tool;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Enumeration;

public class FileManager {
    public int fileUpload(HttpServletRequest request) throws IOException {
        String temp_dir = "/";
        int maxSize = 1024 * 1024 * 100;
        String encoding = "UTF-8";
        try {
            MultipartRequest multipartRequest
                    = new MultipartRequest((HttpServletRequest) request, temp_dir, maxSize, encoding,
                    new DefaultFileRenamePolicy());
            Enumeration<String> e = multipartRequest.getFileNames();
            while (e.hasMoreElements()) {
                String fileName = e.nextElement();
                System.out.println(fileName);
            }
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;


//        if(!fileName.endsWith(".doc") && !fileName.endsWith(".hwp") && !fileName.endsWith(".pdf") &&
//                !fileName.endsWith(".xls")){
//            File file = new File(directory + fileRealName);
//            file.delete();
//            out.write("업로드할 수 없는 확장자입니다.");
//        }
//        else{
//            new FileDAO().upload(fileName, fileRealName);
//            out.write("파일명 : " + fileName + "<br>");
//            out.write("실제 파일명 : " + fileRealName + "<br>");
//        }

    }


    public int fileDownload(String filename) {
        return 0; // 다운로드 성공
        // return -1; // 다운로드 실패
    }

    // 랜덤한 파일이름 반환 (len길이의 해쉬 파일이름 0-9, a-z 사용) + (filename의 확장자)
    public String getHashFileName(String filename, int len) {

        return "";
    }
}
