package Model;

public class CategoryVo {

	// 카테고리 테이블
	// postdao에 만들려다가 다른사람이 수정하고 있어서 여기다 만듦
	// 나중에 postdao로 옮겨도 무방함
	private int categoryid;// NUMBER PRIMARY KEY, -- 카테고리 ID (기본 키)
	private String categoryname;// VARCHAR2(20) NOT NULL -- 카테고리 이름 (NOT NULL)

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public String getCategoryname() {
		return categoryname;
	}

	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}

}
