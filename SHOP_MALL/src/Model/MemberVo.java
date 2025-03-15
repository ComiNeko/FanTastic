package Model;

import java.util.List;

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
		
		// 최근 본 상품 목록 (추가)
	    private List<RecentView> recentViews;
	    
	    // 내부 클래스: 최근 본 상품 정보
	    public static class RecentView {
	        private int productId;      // 상품 ID
	        private String viewDate;    // 조회 시각 (String 형식)
	        
	        // 추가: 상품 관련 정보 (NEW_PRODUCTS 테이블의 정보)
	        private String productName; // 상품 이름
	        private int productPrice;   // 상품 가격
	        private String productImage; // 상품 이미지 URL

	        public int getProductId() {
	            return productId;
	        }
	        public void setProductId(int productId) {
	            this.productId = productId;
	        }
	        public String getViewDate() {
	            return viewDate;
	        }
	        public void setViewDate(String viewDate) {
	            this.viewDate = viewDate;
	        }
	        public String getProductName() {
	            return productName;
	        }
	        public void setProductName(String productName) {
	            this.productName = productName;
	        }
	        public int getProductPrice() {
	            return productPrice;
	        }
	        public void setProductPrice(int productPrice) {
	            this.productPrice = productPrice;
	        }
	        public String getProductImage() {
	            return productImage;
	        }
	        public void setProductImage(String productImage) {
	            this.productImage = productImage;
	        }
	    }
		
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
		
		// 최근 본 상품 목록
		 public List<RecentView> getRecentViews() {
		        return recentViews;
		    }
		    public void setRecentViews(List<RecentView> recentViews) {
		        this.recentViews = recentViews;
		    }
		
}
