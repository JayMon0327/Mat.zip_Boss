package com.mat.zip.boss.model;
import java.util.Date;
public class MemberVO {

	private int uniqueNumber;
    private String user_id;
    private String password;
    private String name;
    private String gender;
    private String ageGroup;
    private String nickName;
    private String user;
    private String mark;
    private String profile;
    private int point;
    private Date accountDate;
    
		public int getUniqueNumber() {
			return uniqueNumber;
		}
		public void setUniqueNumber(int uniqueNumber) {
			this.uniqueNumber = uniqueNumber;
		}
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getGender() {
			return gender;
		}
		public void setGender(String gender) {
			this.gender = gender;
		}
		public String getAgeGroup() {
			return ageGroup;
		}
		public void setAgeGroup(String ageGroup) {
			this.ageGroup = ageGroup;
		}
		public String getNickName() {
			return nickName;
		}
		public void setNickName(String nickName) {
			this.nickName = nickName;
		}
		public String getUser() {
			return user;
		}
		public void setUser(String user) {
			this.user = user;
		}
		public String getMark() {
			return mark;
		}
		public void setMark(String mark) {
			this.mark = mark;
		}
		public String getProfile() {
			return profile;
		}
		public void setProfile(String profile) {
			this.profile = profile;
		}
		public int getPoint() {
			return point;
		}
		public void setPoint(int point) {
			this.point = point;
		}
		public Date getAccountDate() {
			return accountDate;
		}
		public void setAccountDate(Date accountDate) {
			this.accountDate = accountDate;
		}
		@Override
		public String toString() {
			return "MemberVO [uniqueNumber=" + uniqueNumber + ", user_id=" + user_id + ", password=" + password
					+ ", name=" + name + ", gender=" + gender + ", ageGroup=" + ageGroup + ", nickName=" + nickName
					+ ", user=" + user + ", mark=" + mark + ", profile=" + profile + ", point=" + point
					+ ", accountDate=" + accountDate + "]";
		}
	    

	    // 생성자, getter, setter 생략
	

}
