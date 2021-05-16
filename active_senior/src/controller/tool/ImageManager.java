package controller.tool;

import controller.listener.PathListener;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.xml.bind.DatatypeConverter;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ImageManager {

    // src 에 있는 이미지를 읽어들여, width, height 크기로 크기를 조절한후 dest 위치에 저장, deleteSrc=True 일 때 원본 삭제
    public int imageResize(String src, String dest, int width, int height, boolean deleteSrc) {

        return 0; // 제대로 수행

        // return -1; // 수행 실패
    }

    public int imageResize(String src, String dest, int width, int height) {
        return imageResize(src, dest, width, height, false);
    }

    public String base64toImage(String data, String path) throws IOException {
        String []split = data.split(",");
        String extension = split[0];
        switch (extension) {
            case "data:image/jpeg;base64":
                extension = ".jpeg";
                break;
            case "data:image/png;base64":
                extension = ".png";
                break;
            case "data:image/gif;base64":
                extension = ".gif";
                break;
            default:
                extension = ".jpg";
                break;
        }
        String base64Image = split[1];
        byte[] imageBytes = DatatypeConverter.parseBase64Binary(base64Image);
        ServletContext context = PathListener.context;
        String realPath = context.getRealPath(path);
        String filename = "firstimage" + extension;
        File file = new File(realPath + "/" + filename);
        try (OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(file))) {
            outputStream.write(imageBytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "/" + path + "/" + filename;
    }

    public String replaceBase64toImage(String html, String path) throws IOException {
        Pattern pattern = Pattern.compile("src=(\"data:image/[^;]*;base64,[^\"]*\")");
        Matcher matcher = pattern.matcher(html);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            String url = base64toImage(matcher.group(1), path);
            matcher.appendReplacement(sb, "src=\"" +url + "\"");
        }
        matcher.appendTail(sb);
        return sb.toString();
    }
}
