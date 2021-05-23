package Model.dto;

public class EduBbs {
    private int bbsID = -1;
    private String userID = "";
    private String userName = "";
    private String bbsDate = "";
    private String bbsTitle = "";
    private String bbsContent = "";
    private String bbsSummary ="";
    private int bbsAvailable = -1;
    private int bbsView = -1;
    private int bbsRecommend = -1;
    private String bbsThumbnail = "";
    private int bbsCategory = -1;
    private String tag = "";
    private String keyword = "";
    private String campus = "";

    public int getBbsID() {
        return bbsID;
    }

    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBbsDate() {
        return bbsDate;
    }

    public void setBbsDate(String bbsDate) {
        this.bbsDate = bbsDate;
    }

    public String getBbsTitle() {
        return bbsTitle;
    }

    public void setBbsTitle(String bbsTitle) {
        this.bbsTitle = bbsTitle;
    }

    public String getBbsContent() {
        return bbsContent;
    }

    public void setBbsContent(String bbsContent) {
        this.bbsContent = bbsContent;
    }

    public String getBbsSummary() {
        return bbsSummary;
    }

    public void setBbsSummary(String bbsSummary) {
        this.bbsSummary = bbsSummary;
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

    public int getBbsCategory() {
        return bbsCategory;
    }

    public void setBbsCategory(int bbsCategory) {
        this.bbsCategory = bbsCategory;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getCampus() {
        return campus;
    }

    public void setCampus(String campus) {
        this.campus = campus;
    }
}
