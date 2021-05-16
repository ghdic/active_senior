package model.dto;

import controller.dao.HireBbsDAO;
import controller.tool.DateManger;

import java.text.ParseException;
import java.util.Date;

public class HireBbs{
    private int bbsID = -1;
    private String bbsTitle;
    private String userID;
    private String bbsDate;
    private String bbsContent;
    private int bbsEventState = -1;
    private int bbsAvailable = -1;
    private int bbsView = -1;
    private int bbsRecommend = -1;
    private String bbsThumbnail;
    private String bbsInstitution;
    private String bbsContactInformation;
    private int bbsRecruitmentNumber = -1;
    private String bbsStartDate;
    private String bbsEndDate;


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

    public String getBbsInstitution() {
        return bbsInstitution;
    }

    public void setBbsInstitution(String bbsInstitution) {
        this.bbsInstitution = bbsInstitution;
    }

    public String getBbsContactInformation() {
        return bbsContactInformation;
    }

    public void setBbsContactInformation(String bbsContactInformation) {
        this.bbsContactInformation = bbsContactInformation;
    }

    public int getBbsRecruitmentNumber() {
        return bbsRecruitmentNumber;
    }

    public void setBbsRecruitmentNumber(int bbsRecruitmentNumber) {
        this.bbsRecruitmentNumber = bbsRecruitmentNumber;
    }

    public String getBbsStartDate() {
        return bbsStartDate;
    }

    public void setBbsStartDate(String bbsStartDate) {
        this.bbsStartDate = bbsStartDate;
    }

    public String getBbsEndDate() {
        return bbsEndDate;
    }

    public void setBbsEndDate(String bbsEndDate) {
        this.bbsEndDate = bbsEndDate;
    }
}
