package Model;

public class PostVo {

	private int productid;// NUMBER PRIMARY KEY, -- 상품 ID (기본 키)
	private int categoryid; // NUMBER NOT NULL, -- 카테고리 ID (외래 키, NOT NULL)
	private int authorid; // NUMBER NOT NULL, -- 작가 ID (외래 키, NOT NULL)
	private String productName;// VARCHAR2(20) NOT NULL, -- 상품 이름 (NOT NULL)
	private int productPrice; // NUMBER NOT NULL, -- 상품 가격 (NOT NULL)
	private int productStock; // NUMBER NOT NULL, -- 상품 재고 (NOT NULL)
	private String productInfo; // VARCHAR2(20), -- 상품 정보
	private String productImage; // VARCHAR2(1024) NOT NULL, --상품 이미지
	private String createdAt; // TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 생성 시간 (기본값: 현재 시간, NOT NULL)
	private String updatedAt; // TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, -- 수정 시간 (기본값: 현재 시간, NULL 허용)

	// 추가 필드 (가격, 수량) - 결제 관련
	private int price; // 상품 가격
	private int quantity; // 상품 개수

	// 장바구니
	private int cartid; // NUMBER PRIMARY KEY, -- 장바구니 ID (기본 키)
	private String userid; // VARCHAR2(20) NOT NULL, -- 사용자 ID (외래 키, NOT NULL)
	
	//찜하기
	 private int favoriteid;
	 

	public int getCartid() {
		return cartid;
	}

	public void setCartid(int cartid) {
		this.cartid = cartid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public int getProductid() {
		return productid;
	}

	public void setProductid(int productid) {
		this.productid = productid;
	}

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public int getAuthorid() {
		return authorid;
	}

	public void setAuthorid(int authorid) {
		this.authorid = authorid;
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

	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}

	public String getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getFavoriteid() {
		return favoriteid;
	}

	public void setFavoriteid(int favoriteid) {
		this.favoriteid = favoriteid;
	}


}