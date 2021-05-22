package controller.tool;

import controller.listener.PathListener;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletContext;
import javax.xml.bind.DatatypeConverter;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ImageManager {

    // src 에 있는 이미지를 읽어들여, width, height 크기로 크기를 조절한후 dest 위치에 저장
    public static void imageResize(String path, String fileName, int width, int height) throws IOException {
        // 이 클래스에 변환할 이미지를 담습니다. ( 이미지는 ParameterBlock 통해서만 담을 수 있습니다. )
        ParameterBlock pd = new ParameterBlock();
        pd.add(path + File.separator + fileName);
        RenderedOp rOp = JAI.create("fileload", pd);

        BufferedImage bi = rOp.getAsBufferedImage(); // 불러올 이미지를 BufferedImage에 담습니다.
        // thumb라는 이미지 버퍼를 생성합니다. 이미지 버퍼 사이즈는 100 * 100 으로 설정합니다.
        BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // thumb라는 이미지 버퍼에 원본 이미지를 정해진 버퍼 사이즈인 100 * 100 사이즈에 담아 그립니다.
        Graphics2D g = thumb.createGraphics();
        g.drawImage(bi, 0, 0, width, height, null);

        // 출력할 위치와 파일 이름을 설정한 후 썸네일 이미지를 생성합니다. ( 확장자는 jpg입니다. )
        File file = new File(path + File.separator + fileName);
        ImageIO.write(thumb, fileName.substring(fileName.lastIndexOf(".") + 1), file);
    }

    private static String base64toImage(String data, String path) throws IOException {
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
        String filename = FileManager.getHashFileName(extension, 30);
        File file = new File(realPath + "/" + filename);
        try (OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(file))) {
            outputStream.write(imageBytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "/" + path + "/" + filename;
    }

    public static String replaceBase64toImage(String html, String path) throws IOException {
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
