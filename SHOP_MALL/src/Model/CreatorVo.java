package Model;

public class CreatorVo {

	// 작가 테이블
	private int authorid;// NUMBER PRIMARY KEY, -- 작가 ID (기본 키)
	private String authorname;// VARCHAR2(30) NOT NULL, -- 작가 이름 (NOT NULL)
	private String authorinfo;// VARCHAR2(255) NOT NULL, -- 작가 정보 (NOT NULL)
	private String authorimg1;// VARCHAR2(255), -- 작가 이미지 1
	private String authorimg2;// VARCHAR2(255), -- 작가 이미지 2
	private String authorimg3;// VARCHAR2(255) -- 작가 이미지 3

	// 상품 테이블
	private int productid;// NUMBER PRIMARY KEY, -- 상품 ID (기본 키)
	private int categoryid; // NUMBER NOT NULL, -- 카테고리 ID (외래 키, NOT NULL)
	private String productName;// VARCHAR2(20) NOT NULL, -- 상품 이름 (NOT NULL)
	private int productPrice; // NUMBER NOT NULL, -- 상품 가격 (NOT NULL)
	private int productStock; // NUMBER NOT NULL, -- 상품 재고 (NOT NULL)
	private String productInfo; // VARCHAR2(20), -- 상품 정보
	private String productImage; // VARCHAR2(1024) NOT NULL, --상품 이미지
	private String createdAt; // TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 생성 시간 (기본값: 현재 시간, NOT NULL)
	private String updatedAt; // TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL, -- 수정 시간 (기본값: 현재 시간, NULL 허용)

	// 상품 테이블의 authorid (상품 소유 작가 ID)
	private int productAuthorid;
	//authorid는 **작가 정보(author 테이블)에서 온 값이지, 상품 테이블에서 가져온 상품의 소유 작가 ID가 아니다
	//로그인한 사람이 내가 만든 상품인지 아닌지 비교하기 위해
	//현재 CreatorVo에 상품은 있지만, 상품 만든 사람이 누구인지 정보가 없음.
	//그래서 상품 테이블의 authorid를 따로 가져와서 담아야 비교 가능

	public int getProductAuthorid() {
		return productAuthorid;
	}

	public void setProductAuthorid(int productAuthorid) {
		this.productAuthorid = productAuthorid;
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

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
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

	public int getAuthorid() {
		return authorid;
	}

	public void setAuthorid(int authorid) {
		this.authorid = authorid;
	}

	public String getAuthorname() {
		return authorname;
	}

	public void setAuthorname(String authorname) {
		this.authorname = authorname;
	}

	public String getAuthorinfo() {
		return authorinfo;
	}

	public void setAuthorinfo(String authorinfo) {
		this.authorinfo = authorinfo;
	}

	public String getAuthorimg1() {
		return authorimg1;
	}

	public void setAuthorimg1(String authorimg1) {
		this.authorimg1 = authorimg1;
	}

	public String getAuthorimg2() {
		return authorimg2;
	}

	public void setAuthorimg2(String authorimg2) {
		this.authorimg2 = authorimg2;
	}

	public String getAuthorimg3() {
		return authorimg3;
	}

	public void setAuthorimg3(String authorimg3) {
		this.authorimg3 = authorimg3;
	}

}
