package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	
	public List<PostVo> getSelect() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from NEW_PRODUCTS order by productid desc";

		List<PostVo> list = new ArrayList<PostVo>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PostVo vo = new PostVo();
				vo.setProductid(rs.getInt("productid"));
				vo.setCategoryid(rs.getInt("categoryid"));
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setProductName(rs.getString("productname"));
				vo.setProductPrice(rs.getInt("productprice"));
				vo.setProductStock(rs.getInt("productstock"));
				vo.setProductInfo(rs.getString("productinfo"));
				vo.setProductImage(rs.getString("productImage"));
				vo.setCreatedAt(rs.getString("createat"));
				vo.setUpdatedAt(rs.getString("updateat"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return list;
	}// select
	
	
	//카테고리
	public List<PostVo> getPostsByCategory(int categoryid) {
	    List<PostVo> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT * FROM NEW_PRODUCTS WHERE categoryid = ? ORDER BY productid DESC";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, categoryid);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            PostVo vo = new PostVo();
	            vo.setProductid(rs.getInt("productid"));
	            vo.setCategoryid(rs.getInt("categoryid"));
	            vo.setProductName(rs.getString("productname"));
	            vo.setProductPrice(rs.getInt("productprice"));
	            vo.setProductInfo(rs.getString("productinfo"));
	            vo.setProductImage(rs.getString("productImage"));
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
