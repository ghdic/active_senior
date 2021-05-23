package Model.dto;


public class User {
    private String userID = "";
    private String userPW = "";
    private String userName = "";
    private String userGender = "";
    private String userEmail = "";
    private String userProfile = "";
    private int userAuthority = -1;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPW() {
        return userPW;
    }

    public void setUserPW(String userPW) {
        this.userPW = userPW;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserProfile() {
        return userProfile;
    }

    public String getUserProfilePath() {
        if(userProfile.equals("")) {
            return "/static/image/default/default-profile.png";
        } else {
            return "/static/user/profile_pic/" + userProfile;
        }
    }

    public void setUserProfile(String userProfile) {
        this.userProfile = userProfile;
    }

    public int getUserAuthority() {
        return userAuthority;
    }

    public void setUserAuthority(int userAuthority) {
        this.userAuthority = userAuthority;
    }
}
