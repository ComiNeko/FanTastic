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

		String sql = "INSERT INTO NEW_PRODUCTS(productid, categoryid, authorid, productName, productPrice, productStock, productInfo, productImage, createdAt, updatedAt) "
		           + "VALUES (NEW_PRODUCTS_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			
			System.out.println(vo.getCategoryid());
			System.out.println(vo.getAuthorid());
			System.out.println(vo.getProductName());
			System.out.println(vo.getProductPrice());
			System.out.println(vo.getProductStock());
			System.out.println(vo.getProductInfo());
			System.out.println(vo.getProductImage());
			
			pstmt.setInt(1, vo.getCategoryid());
			pstmt.setInt(2, vo.getAuthorid());
			pstmt.setString(3, vo.getProductName());
			pstmt.setInt(4, vo.getProductPrice());
			pstmt.setInt(5, vo.getProductStock());
			pstmt.setString(6, vo.getProductInfo());
			System.out.println("이미지: " + vo.getProductImage());
			pstmt.setString(7, vo.getProductImage()); 
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
				vo.setCreatedAt(rs.getString("createdAt"));
				vo.setUpdatedAt(rs.getString("updatedAt"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return list;
	}// select

	// 카테고리
	public List<PostVo> getPostsByCategory(int categoryid) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM NEW_PRODUCTS WHERE categoryid = ? ORDER BY productid DESC";
		
		List<PostVo> list = new ArrayList<PostVo>();
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

	// 장바구니에 상품 추가 (중복이면 수량 증가)
	public void addToCart(String userId, int productId, int quantity) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "MERGE INTO NEW_CARTS c " +
	                 "USING (SELECT ? AS userid, ? AS productid FROM dual) temp " +
	                 "ON (c.userid = temp.userid AND c.productid = temp.productid) " +
	                 "WHEN MATCHED THEN " +
	                 "    UPDATE SET c.quantity = c.quantity + ? " + // 수량 누적
	                 "WHEN NOT MATCHED THEN " +
	                 "    INSERT (cartid, userid, productid, quantity) " +
	                 "    VALUES (NEW_CARTS_SEQ.NEXTVAL, ?, ?, ?)";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, productId);
	        pstmt.setInt(3, quantity); // 누적할 수량
	        pstmt.setString(4, userId); 
	        pstmt.setInt(5, productId); 
	        pstmt.setInt(6, quantity); 
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}


	// 장바구니 목록 조회 (중복 상품 묶기 + 수량 합산)
	public List<PostVo> getCartList(String userId) {
	    List<PostVo> cartList = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT " +
	                 "c.productid, " +
	                 "p.productname, " +
	                 "p.productimage, " +
	                 "p.productprice, " +
	                 "SUM(c.quantity) AS quantity " + // 장바구니 수량 합산
	                 "FROM NEW_CARTS c " +
	                 "JOIN NEW_PRODUCTS p ON c.productid = p.productid " +
	                 "WHERE c.userid = ? " +
	                 "GROUP BY c.productid, p.productname, p.productimage, p.productprice";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            PostVo post = new PostVo();
	            post.setProductid(rs.getInt("productid"));
	            post.setProductName(rs.getString("productname"));
	            post.setProductImage(rs.getString("productimage"));
	            post.setProductPrice(rs.getInt("productprice"));
	            post.setQuantity(rs.getInt("quantity")); // 합산된 수량
	            cartList.add(post);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return cartList;
	}


	// 장바구니에서 상품 삭제 (특정 상품 전체 삭제)
	public void removeFromCart(String userId, int productId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "DELETE FROM NEW_CARTS WHERE userid = ? AND productid = ?";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, productId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}



}// dao
