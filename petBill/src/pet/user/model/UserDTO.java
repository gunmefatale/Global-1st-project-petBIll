package pet.user.model;

import java.sql.Timestamp;

public class UserDTO {
	
	private String userId;					//아이디
	private String userPw;					//비밀번호
	private String userName;				//이름
	private String userMobile;				//핸드폰
	private String userNick;				//닉네임
	private String userSiAddress;			//거주 '시'
	private String userSelectAddress;		//거주 '구' 주소
	private String userDetailAddress;		//상세주소
	private Timestamp userReg;				//가입날짜
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserMobile() {
		return userMobile;
	}
	public void setUserMobile(String userMobile) {
		this.userMobile = userMobile;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String getUserSiAddress() {
		return userSiAddress;
	}
	public void setUserSiAddress(String userSiAddress) {
		this.userSiAddress = userSiAddress;
	}
	public String getUserSelectAddress() {
		return userSelectAddress;
	}
	public void setUserSelectAddress(String userSelectAddress) {
		this.userSelectAddress = userSelectAddress;
	}
	public String getUserDetailAddress() {
		return userDetailAddress;
	}
	public void setUserDetailAddress(String userDetailAddress) {
		this.userDetailAddress = userDetailAddress;
	}
	public Timestamp getUserReg() {
		return userReg;
	}
	public void setUserReg(Timestamp userReg) {
		this.userReg = userReg;
	}
	
	
	
	
	

}
