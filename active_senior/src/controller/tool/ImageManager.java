package controller.tool;

public class ImageManager {

    // src 에 있는 이미지를 읽어들여, width, height 크기로 크기를 조절한후 dest 위치에 저장, deleteSrc=True 일 때 원본 삭제
    public int imageResize(String src, String dest, int width, int height, boolean deleteSrc) {

        return 0; // 제대로 수행

        // return -1; // 수행 실패
    }

    public int imageResize(String src, String dest, int width, int height) {
        return imageResize(src, dest, width, height, false);
    }
}
