package model.dto;

public class HireBbs{
    private int bbsID;
    private String bbsTitle;
    private String userID;
    private String bbsDate;
    private String bbsContent;
    private int bbsEventState;
    private int bbsAvailable;
    private int bbsView;
    private int bbsRecommend;
    private String bbsThumbnail;

    public int getBbsID() {
        return bbsID;
    }

    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }

    public String getBbsTitle() {
        return bbsTitle;
    }

    public void setBbsTitle(String bbsTitle) {
        this.bbsTitle = bbsTitle;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getBbsDate() {
        return bbsDate;
    }

    public void setBbsDate(String bbsDate) {
        this.bbsDate = bbsDate;
    }

    public String getBbsContent() {
        return bbsContent;
    }

    public void setBbsContent(String bbsContent) {
        this.bbsContent = bbsContent;
    }

    public int getBbsEventState() {
        return bbsEventState;
    }

    public void setBbsEventState(int bbsEventState) {
        this.bbsEventState = bbsEventState;
    }

    public int getBbsAvailable() {
        return bbsAvailable;
    }

    public void setBbsAvailable(int bbsAvailable) {
        this.bbsAvailable = bbsAvailable;
    }

    public int getBbsView() {
        return bbsView;
    }

    public void setBbsView(int bbsView) {
        this.bbsView = bbsView;
    }

    public int getBbsRecommend() {
        return bbsRecommend;
    }

    public void setBbsRecommend(int bbsRecommend) {
        this.bbsRecommend = bbsRecommend;
    }

    public String getBbsThumbnail() {
        return bbsThumbnail;
    }

    public void setBbsThumbnail(String bbsThumbnail) {
        this.bbsThumbnail = bbsThumbnail;
    }
}
