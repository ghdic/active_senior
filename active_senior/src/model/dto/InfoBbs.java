package model.dto;

import controller.tool.DateManger;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;

public class InfoBbs {
    private int bbsID = -1;
    private String userID = "";
    private String userName = "";
    private String bbsDate = "";
    private String bbsTitle = "";
    private String bbsContent = "";
    private String summary ="";
    private int bbsAvailable = -1;
    private int bbsView = -1;
    private int bbsRecommend = -1;
    private String bbsThumbnail = "";
    private int bbsCategory = -1;
    private String tag = "";
    private String keyword = "";
    private String realFileName = "";
    private String originalFileName = "";

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

    public String getBbsDateSimple() throws ParseException { return DateManger.getSimpleDate(bbsDate); }

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

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
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

    public String getBbsThumbnailPath() {
        if(bbsThumbnail.equals(""))
            return "/static/image/default/default-image.png";
        else
            return "/static/info_bbs/thumbnail/" + bbsThumbnail;
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

    public ArrayList<String> getTagArrayList() {
        ArrayList<String> list = new ArrayList<String>(Arrays.asList(tag.trim().split(",")));
        if(list.size() == 1 && list.get(0).equals(""))
            list.remove(0);
        return list;
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

    public String getRealFileName() {
        return realFileName;
    }

    public ArrayList<String> getRealFileNameArrayList() {
        ArrayList<String> list = new ArrayList<String>(Arrays.asList(realFileName.trim().split(",")));
        if(list.size() == 1 && list.get(0).equals(""))
            list.remove(0);
        for(int i = 0; i < list.size(); i++) {
            list.set(i, "downloadAction?filepath=/static/info_bbs/upload/" + list.get(i));
        }
        return list;
    }

    public void setRealFileName(String realFileName) {
        this.realFileName = realFileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public ArrayList<String> getOriginalFileNameArrayList() {
        ArrayList<String> list = new ArrayList<String>(Arrays.asList(originalFileName.trim().split(",")));
        if(list.size() == 1 && list.get(0).equals(""))
            list.remove(0);
        return list;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
}
