package Model;

public class ReviewVo {
	
    private int reviewid;// NUMBER PRIMARY KEY, -- 리뷰 ID (기본 키)
    private String userid;// VARCHAR2(20) NOT NULL, -- 사용자 ID (외래 키, NOT NULL)
    private int productid;// NUMBER, -- 상품 ID (외래 키)
    private int rating;// NUMBER(1) CHECK (rating BETWEEN 1 AND 5) NOT NULL, -- 평점 (1~5점, NOT NULL)
    private String reviewText;// VARCHAR2(500), -- 리뷰 내용
    private String createdAt;// TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 생성 시간 (기본값: 현재 시간, NOT NULL)
	public int getReviewid() {
		return reviewid;
	}
	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
    
    

}
