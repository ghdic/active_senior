package controller.tool;

import java.util.concurrent.ThreadLocalRandom;

public class FileManager {

    public int fileDownload(String filename) {
        return 0; // 다운로드 성공
        // return -1; // 다운로드 실패
    }

    // 랜덤한 파일이름 반환 (len길이의 해쉬 파일이름 0-9, a-z 사용) + (filename의 확장자)
    public static String getHashFileName(String fileName, int len) {
        String extension = fileName.substring(fileName.lastIndexOf("."));
        char[] randomName = new char[len];
        for(int i = 0; i < len; i++) {
            int randInt = ThreadLocalRandom.current().nextInt(0, 36);
            if(randInt < 10)
                randomName[i] = (char) ('0' + randInt);
            else
                randomName[i] = (char) ('a' + randInt - 10);
        }
        return String.valueOf(randomName) + extension;
    }
}
