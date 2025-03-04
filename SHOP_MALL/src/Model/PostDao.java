package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DBManager;

public class PostDao {

	// 글 작성 (INSERT)
	public void postInsert(PostVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO NEW_PRODUCTS(productid, categoryid, authorid, productName, productPrice, productStock, productInfo, productImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getProductid());
			pstmt.setInt(2, vo.getCategoryid());
			pstmt.setInt(3, vo.getAuthorid());
			pstmt.setString(4, vo.getProductName());
			pstmt.setInt(5, vo.getProductPrice());
			pstmt.setInt(6, vo.getProductStock());
			pstmt.setString(7, vo.getProductInfo());
			pstmt.setString(8, vo.getProductImage()); 
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
	}// insert

}// dao
