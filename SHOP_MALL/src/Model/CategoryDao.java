package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class CategoryDao {

	// 카테고리 전체 조회
	// postdao 카테고리 메서드 대신 이거 쓰는 이유는 카테고리만 나열된 목록이 필요하기 때문이다
	// postdao의 getPostsByCategory는
	// [상품ID: 12, 상품명: "키링1", 가격: 5000]
	// [상품ID: 13, 상품명: "키링2", 가격: 7000]
	// 특정 카테고리의 상품 목록을 가져온다

	public List<CategoryVo> getAllCategories() {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT categoryid, categoryname FROM NEW_CATEGORIES ORDER BY categoryid";

		List<CategoryVo> categoryList = new ArrayList<>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CategoryVo vo = new CategoryVo();
				vo.setCategoryid(rs.getInt("categoryid"));
				vo.setCategoryname(rs.getString("categoryname"));
				categoryList.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return categoryList;
	}

}
