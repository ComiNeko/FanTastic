package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class ReviewDao {

	// 리뷰 등록 메서드
	public int insertReview(ReviewVo vo) {

		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO NEW_REVIEWS (reviewid, userid, productid, rating, reviewText, createdAt) "
				+ "VALUES (NEW_REVIEWS_SEQ.NEXTVAL, ?, ?, ?, ?, DEFAULT)";

		int result = 0;

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getUserid());
			pstmt.setInt(2, vo.getProductid());
			pstmt.setInt(3, vo.getRating());
			pstmt.setString(4, vo.getReviewText());

			result = pstmt.executeUpdate(); // 실행 결과

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}

		return result; // 성공: 1, 실패: 0
	}

	// 리뷰 댓글 조회 기능

	public List<ReviewVo> getReviews(int productid) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM NEW_REVIEWS WHERE productid = ? ORDER BY createdAt DESC";

		List<ReviewVo> list = new ArrayList<ReviewVo>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewVo vo = new ReviewVo();
				vo.setReviewid(rs.getInt("reviewid"));
				vo.setUserid(rs.getString("userid"));
				vo.setProductid(rs.getInt("productid"));
				vo.setRating(rs.getInt("rating"));
				vo.setReviewText(rs.getString("reviewText"));
				vo.setCreatedAt(rs.getString("createdAt"));
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return list;
	}

}// dao
