package Model.dto;

public class FileDTO {
    String fileName;
    String fileRealName;
    int downloadCount;

    public int getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }

    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public String getFileRealName() {
        return fileRealName;
    }
    public void setFileRealName(String fileRealName) {
        this.fileRealName = fileRealName;
    }

    public FileDTO(String fileName, String fileRealName, int downloadCount) {
        super();
        this.fileName = fileName;
        this.fileRealName = fileRealName;
        this.downloadCount = downloadCount;
    }


}
