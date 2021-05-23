package model.dto;


import controller.tool.DateManger;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;

public class HireBbs{
    private int bbsID = -1;
    private String userID = "";
    private String userName = "";
    private String bbsDate = "";
    private String bbsTitle = "";
    private String bbsContent = "";
    private int bbsAvailable = -1;
    private int bbsView = -1;
    private int bbsRecommend = -1;
    private String bbsThumbnail = "";
    private String bbsState = "";
    private int recruitNum = -1;
    private String agency = "";
    private String department = "";
    private String recruitStart = "";
    private String recruitEnd = "";
    private String eduStart = "";
    private String eduEnd = "";
    private String activeStart = "";
    private String activeEnd = "";
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
            return "/static/hire_bbs/thumbnail/" + bbsThumbnail;
    }

    public void setBbsThumbnail(String bbsThumbnail) {
        this.bbsThumbnail = bbsThumbnail;
    }

    public String getBbsState() { return bbsState; }

    public void setBbsState(String bbsState) {
        this.bbsState = bbsState;
    }

    public int getRecruitNum() {
        return recruitNum;
    }

    public void setRecruitNum(int recruitNum) {
        this.recruitNum = recruitNum;
    }

    public String getAgency() {
        return agency;
    }

    public void setAgency(String agency) {
        this.agency = agency;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRecruitStart() { return recruitStart; }

    public String getRecruitStartSimple() throws ParseException { return DateManger.getSimpleDate(recruitStart); }

    public void setRecruitStart(String recruitStart) {
        this.recruitStart = recruitStart;
    }

    public String getRecruitEnd() {
        return recruitEnd;
    }

    public String getRecruitEndSimple() throws ParseException { return DateManger.getSimpleDate(recruitEnd); }

    public void setRecruitEnd(String recruitEnd) {
        this.recruitEnd = recruitEnd;
    }

    public String getEduStart() {
        return eduStart;
    }

    public String getEduStartSimple() throws ParseException { return DateManger.getSimpleDate(eduStart); }

    public void setEduStart(String eduStart) {
        this.eduStart = eduStart;
    }

    public String getEduEndSimple() throws ParseException { return DateManger.getSimpleDate(eduEnd); }

    public String getEduEnd() {
        return eduEnd;
    }

    public void setEduEnd(String eduEnd) {
        this.eduEnd = eduEnd;
    }

    public String getActiveStartSimple() throws ParseException { return DateManger.getSimpleDate(activeStart); }

    public String getActiveStart() {
        return activeStart;
    }

    public void setActiveStart(String activeStart) {
        this.activeStart = activeStart;
    }

    public String getActiveEndSimple() throws ParseException { return DateManger.getSimpleDate(activeEnd); }

    public String getActiveEnd() {
        return activeEnd;
    }

    public void setActiveEnd(String activeEnd) {
        this.activeEnd = activeEnd;
    }

    public String getRealFileName() {
        return realFileName;
    }

    public ArrayList<String> getRealFileNameArrayList() {
        ArrayList<String> list = (ArrayList<String>) Arrays.asList(realFileName.split(","));
        return list;
    }

    public void setRealFileName(String realFileName) {
        this.realFileName = realFileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public ArrayList<String> getOriginalFileNameArrayList() {
        ArrayList<String> list = (ArrayList<String>) Arrays.asList(originalFileName.split(","));
        return list;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
}
