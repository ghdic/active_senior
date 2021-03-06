package controller.tool;

import controller.listener.DtoListener;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

public class PostFormManager {

    public static <T> T getPostData(HttpServletRequest req, String dto, String savePath) throws UnsupportedEncodingException {
        String type = "utf-8";
        int maxSize = 20*1024*1024; // 20mb
        ServletContext context = req.getServletContext();
        String realPath = context.getRealPath(savePath);
        ArrayList<String> realFileNames = new ArrayList<String>();
        ArrayList<String> originalFileNames = new ArrayList<String>();

        try {
            DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
            diskFileItemFactory.setRepository(new File(realPath));
            diskFileItemFactory.setSizeThreshold(maxSize);
            diskFileItemFactory.setDefaultCharset(type);
            ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);

            List<FileItem> items = fileUpload.parseRequest(req);
            Class<T> c = DtoListener.dtoDict.get(dto);
            T data = c.newInstance();
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if(item.getString().equals(""))continue;
                    String sName = DtoListener.toSetMethodName(item.getFieldName());
                    Method sMethod = DtoListener.returnMethod(c, sName);
                    if(sMethod.getParameterTypes()[0].getTypeName().equals("int")) {
                        int value;
                        try {
                            value = Integer.parseInt(item.getString());
                        } catch (Exception e) {
                            value = -1;
                        }
                        sMethod.invoke(data, value);
                    } else {
                        sMethod.invoke(data, item.getString());
                    }
                } else {
                    if (item.getSize() > 0) {
                        String separator = File.separator;
                        String fileName = FileManager.getHashFileName(item.getName(), 30);
                        File uploadFile = null;
                        if (item.getFieldName().equals("bbsThumbnail")) {
                            uploadFile = new File(realPath + separator + "thumbnail" + separator + fileName);
                            while (uploadFile.exists()) {
                                fileName = FileManager.getHashFileName(item.getName(), 30);
                                uploadFile = new File(realPath + separator + "thumbnail" + separator + fileName);
                            }
                            String sName = DtoListener.toSetMethodName(item.getFieldName());
                            Method sMethod = DtoListener.returnMethod(c, sName);
                            sMethod.invoke(data, fileName);
                        } else if (item.getFieldName().equals("userProfile")) {
                            uploadFile = new File(realPath + separator + "profile_pic" + separator + fileName);
                            while (uploadFile.exists()) {
                                fileName = FileManager.getHashFileName(item.getName(), 30);
                                uploadFile = new File(realPath + separator + "profile_pic" + separator + fileName);
                            }
                            item.write(uploadFile);
                            if(!item.getName().substring(item.getName().lastIndexOf(".")).equals(".gif")) {
                                ImageManager.imageResize(realPath + separator + "profile_pic", fileName, 200, 200);
                            }
                            String sName = DtoListener.toSetMethodName("userProfile");
                            Method sMethod = DtoListener.returnMethod(c, sName);
                            sMethod.invoke(data, fileName);
                        } else if (item.getFieldName().equals("files")) {
                            uploadFile = new File(realPath + separator + "upload" + separator + fileName);
                            while (uploadFile.exists()) {
                                fileName = FileManager.getHashFileName(item.getName(), 30);
                                uploadFile = new File(realPath + separator + "upload" + separator + fileName);
                            }
                            realFileNames.add(fileName);
                            originalFileNames.add(item.getName());
                        }
                        if (uploadFile != null && !item.getFieldName().equals("userProfile"))
                            item.write(uploadFile);

                    }
                }
            }
            if(realFileNames.size() != 0) {
                String sName = DtoListener.toSetMethodName("realFileName");
                Method sMethod = DtoListener.returnMethod(c, sName);
                if (sMethod != null) {
                    sMethod.invoke(data, String.join(",", realFileNames));
                    sName = DtoListener.toSetMethodName("originalFileName");
                    sMethod = DtoListener.returnMethod(c, sName);
                    sMethod.invoke(data, String.join(",", originalFileNames));
                }
            }

            return data;
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
