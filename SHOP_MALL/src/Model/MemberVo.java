package Model;

public class MemberVo {

	//------NEW_USERS------//
		private String name; //사용자 이름
		private String userid; //사용자 ID
		private String password; //비밀번호  
	    private String phonenumber; // 전화번호
		private String email;  //이메일 (고유)
		  
		  
		private String addressid; //주소 ID (기본 키)
		private String address; //주소 
		

		private String token;
		//private String userid;
		private long expiryTime;
		//밀리초 단위로 경과 시간을 반환하는데, 값이 매우 크기 때문에 int가 아닌 long으로 설정!
		
		

		private String role;

		
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getUserid() {
			return userid;
		}
		public void setUserid(String userid) {
			this.userid = userid;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getPhonenumber() {
			return phonenumber;
		}
		public void setPhonenumber(String phonenumber) {
			this.phonenumber = phonenumber;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getAddressid() {
			return addressid;
		}
		public void setAddressid(String addressid) {
			this.addressid = addressid;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}

		public String getToken() {
			return token;
		}
		public void setToken(String token) {
			this.token = token;
		}
		public long getExpiryTime() {
			return expiryTime;
		}
		public void setExpiryTime(long expiryTime) {
			this.expiryTime = expiryTime;
		}	

		public String getRole() {
			return role;
		}
		public void setRole(String role) {
			this.role = role;

		}
		
	
		
}
