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

		String sql = "MERGE INTO NEW_CARTS c " + "USING (SELECT ? AS userid, ? AS productid FROM dual) temp "
				+ "ON (c.userid = temp.userid AND c.productid = temp.productid) " + "WHEN MATCHED THEN "
				+ "    UPDATE SET c.quantity = c.quantity + ? " + // 수량 누적
				"WHEN NOT MATCHED THEN " + "    INSERT (cartid, userid, productid, quantity) "
				+ "    VALUES (NEW_CARTS_SEQ.NEXTVAL, ?, ?, ?)";

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

		String sql = "SELECT " + "c.productid, " + "p.productname, " + "p.productimage, " + "p.productprice, "
				+ "SUM(c.quantity) AS quantity " + // 장바구니 수량 합산
				"FROM NEW_CARTS c " + "JOIN NEW_PRODUCTS p ON c.productid = p.productid " + "WHERE c.userid = ? "
				+ "GROUP BY c.productid, p.productname, p.productimage, p.productprice";

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

	// 장바구니에서 특정 상품 전체 삭제 (productid 기준)
	public void removeFromCart(String userId, int productId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "DELETE FROM NEW_CARTS WHERE productid = ? AND userid = ?";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, productId); // 상품 ID
	        pstmt.setString(2, userId); // 유저 ID
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}
											// -----------------------------------------------------------------
																		//LTR_찜하기
											// -----------------------------------------------------------------	
	
	// [1] 카테고리별 찜 목록 조회 (folderId 무관, 전체 찜 목록에서 카테고리 필터 적용)
	public List<PostVo> getFavoriteListByCategory(String userId, int categoryId, int page, int pageSize) {
	    List<PostVo> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int offset = (page - 1) * pageSize;
	    
	    StringBuilder sb = new StringBuilder();
	    sb.append("SELECT * FROM ( ");
	    sb.append(" SELECT a.*, ROWNUM rnum FROM ( ");
	    sb.append(" SELECT f.favoriteid, p.productid, p.productname, p.productimage, p.productprice ");
	    sb.append(" FROM NEW_FAVORITES f ");
	    sb.append(" JOIN NEW_PRODUCTS p ON f.productid = p.productid ");
	    sb.append(" WHERE f.userid = ? ");

	    if (categoryId != 0) {
	        sb.append(" AND p.categoryid = ? ");
	    }

	    sb.append(" ORDER BY f.favoriteid DESC ");
	    sb.append(" ) a ");
	    sb.append(" WHERE ROWNUM <= ? ");  // offset + pageSize
	    sb.append(" ) ");
	    sb.append(" WHERE rnum > ? ");     // offset

	    System.out.println("SQL : " + sb.toString());

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sb.toString());
	        int idx = 1;
	        pstmt.setString(idx++, userId);
	        if (categoryId != 0) {
	            pstmt.setInt(idx++, categoryId);
	        }
	        pstmt.setInt(idx++, offset + pageSize); // max rownum
	        pstmt.setInt(idx++, offset);   
	        
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            PostVo vo = new PostVo();
	            vo.setFavoriteid(rs.getInt("favoriteid"));
	            vo.setProductid(rs.getInt("productid"));
	            vo.setProductName(rs.getString("productname"));
	            vo.setProductImage(rs.getString("productimage"));
	            vo.setProductPrice(rs.getInt("productprice"));
	            list.add(vo);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return list;
	}
	
	// [1-2] 폴더별 찜 목록 조회 (categoryId 무관, 특정 폴더의 찜한 상품만 조회)
	public List<PostVo> getFavoriteListByFolder(String userId, int folderId, int page, int pageSize) {
	    List<PostVo> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int offset = (page - 1) * pageSize;
	    
	    StringBuilder sb = new StringBuilder();
	    sb.append("SELECT f.favoriteid, p.productid, p.productname, p.productimage, p.productprice ")
	      .append("FROM NEW_FAVORITES f ")
	      .append("JOIN NEW_PRODUCTS p ON f.productid = p.productid ")
	      .append("WHERE f.userid = ? ");
	    
	    // 폴더 필터: folderId가 0이면 전체 조회
	    if (folderId != 0) {
	        sb.append("AND f.folderid = ? ");
	    }
	    sb.append("ORDER BY f.favoriteid DESC ");
	    sb.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sb.toString());
	        pstmt.setString(1, userId);
	        int idx = 2;
	        if (folderId != 0) {
	            pstmt.setInt(idx++, folderId);
	        }
	        pstmt.setInt(idx++, offset);
	        pstmt.setInt(idx++, pageSize);
	        
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            PostVo vo = new PostVo();
	            vo.setFavoriteid(rs.getInt("favoriteid"));
	            vo.setProductid(rs.getInt("productid"));
	            vo.setProductName(rs.getString("productname"));
	            vo.setProductImage(rs.getString("productimage"));
	            vo.setProductPrice(rs.getInt("productprice"));
	            list.add(vo);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return list;
	}


	public boolean addToFavorite(String userId, int productId, Integer folderId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "INSERT INTO NEW_FAVORITES (favoriteid, userid, productid, folderid, createdAt) "
	               + "VALUES (NEW_FAVORITES_SEQ.NEXTVAL, ?, ?, ?, CURRENT_TIMESTAMP)";
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, userId);
	        pstmt.setInt(2, productId);

	        if (folderId == null || folderId == 0) {
	            pstmt.setNull(3, java.sql.Types.INTEGER);
	        } else {
	            pstmt.setInt(3, folderId);
	        }

	        int result = pstmt.executeUpdate();
	        
	        if (result > 0) {
	            System.out.println("찜 추가 성공: userId=" + userId + ", productId=" + productId + ", folderId=" + folderId);
	        } else {
	            System.out.println("찜 추가 실패: userId=" + userId + ", productId=" + productId + ", folderId=" + folderId);
	        }
	        
	        
	        return result > 0;

	    } catch (SQLException e) {
	        e.printStackTrace(); 
	        return false;

	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}


	// [3] 찜 삭제: folderId가 NULL인 경우에도 삭제 처리
	public void removeFromFavorite(String userId, int productId, Integer folderId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql;
	    if (folderId == null || folderId == 0) {
	        sql = "DELETE FROM NEW_FAVORITES WHERE userid = ? AND productid = ? AND folderid IS NULL";
	    } else {
	        sql = "DELETE FROM NEW_FAVORITES WHERE userid = ? AND productid = ? AND folderid = ?";
	    }
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, productId);
	        if (folderId != null && folderId != 0) {
	            pstmt.setInt(3, folderId);
	        }
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}

	// [4] 폴더 생성: 사용자가 새 폴더를 만들면 해당 폴더가 추가됨
	public void createFavoriteFolder(String userId, String folderName) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = "INSERT INTO NEW_FAVORITE_FOLDERS (folderid, userid, foldername, createdAt) "
	               + "VALUES (NEW_FAVORITE_FOLDERS_SEQ.NEXTVAL, ?, ?, CURRENT_TIMESTAMP)";
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        pstmt.setString(2, folderName);
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}

	// [5] 폴더 목록 조회 (사용자가 생성한 폴더 목록)
	public List<PostVo> getFolderList(String userId) {
	    List<PostVo> folderList = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT folderid, foldername, createdAt FROM NEW_FAVORITE_FOLDERS WHERE userid = ? ORDER BY folderid DESC";
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();
	        while(rs.next()){
	            PostVo vo = new PostVo();
	            vo.setFolderid(rs.getInt("folderid"));
	            vo.setFoldername(rs.getString("foldername"));
	            folderList.add(vo);
	        }
	    } catch(SQLException e){
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return folderList;
	}

	// [6] 폴더 이름 수정
	public boolean updateFavoriteFolderName(String userId, int folderId, String folderName) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE NEW_FAVORITE_FOLDERS SET foldername = ? WHERE folderid = ? AND userid = ?";
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, folderName);
	        pstmt.setInt(2, folderId);
	        pstmt.setString(3, userId);
	        int rows = pstmt.executeUpdate();
	        return (rows > 0);
	    } catch(SQLException e){
	        e.printStackTrace();
	        return false;
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}

	// [7] 폴더 삭제  
	// 삭제 시 해당 폴더에 속한 찜 상품은 기본 폴더(NULL)로 업데이트 후 폴더 삭제
	public boolean deleteFavoriteFolder(String userId, int folderId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	        conn = DBManager.getInstance().getConnection();
	        conn.setAutoCommit(false);
	        String updateSql = "UPDATE NEW_FAVORITES SET folderid = NULL WHERE userid = ? AND folderid = ?";
	        pstmt = conn.prepareStatement(updateSql);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, folderId);
	        pstmt.executeUpdate();
	        pstmt.close();
	        String deleteSql = "DELETE FROM NEW_FAVORITE_FOLDERS WHERE userid = ? AND folderid = ?";
	        pstmt = conn.prepareStatement(deleteSql);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, folderId);
	        int rows = pstmt.executeUpdate();
	        conn.commit();
	        return (rows > 0);
	    } catch(SQLException e){
	        e.printStackTrace();
	        try { if(conn != null) conn.rollback(); } catch(SQLException ex){ ex.printStackTrace(); }
	        return false;
	    } finally {
	        try { if(conn != null) { conn.setAutoCommit(true); conn.close(); } } catch(SQLException e){ e.printStackTrace(); }
	    }
	}
	    
	// [8] 찜 항목 이동 (선택 항목을 특정 폴더로 이동)
	// targetFolderId가 null이면 기본 폴더로 이동
	public void moveFavoritesToFolder(String userId, String[] productIds, Integer targetFolderId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE NEW_FAVORITES SET folderid = ? WHERE userid = ? AND productid = ?";
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        for(String pidStr : productIds) {
	            int pid = Integer.parseInt(pidStr);
	            // targetFolderId가 null이면 기본 폴더 (folderid=NULL)
	            if (targetFolderId == null || targetFolderId == 0) {
	                pstmt.setNull(1, java.sql.Types.INTEGER);
	            } else {
	                pstmt.setInt(1, targetFolderId);
	            }
	            pstmt.setString(2, userId);
	            pstmt.setInt(3, pid);
	            pstmt.addBatch();
	        }
	        pstmt.executeBatch();
	    } catch(SQLException e){
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}






	// 상품 클릭시, 상세정보 페이지 넘어가는 기능
	public PostVo getPostDetail(int productid) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PostVo vo = null;
		// 메서드 안에서 조회한 결과를 담을 객체를 먼저 선언
		// 조건에 따라 (결과가 있을 때만) 객체를 생성해서 반환하기 위해 필요
		// 만약 조회된 결과가 없다면 null 그대로 반환해서 "해당 상품 없음"을 처리할 수 있음

		String sql = "SELECT * FROM NEW_PRODUCTS WHERE productid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				vo = new PostVo();
				vo.setProductid(rs.getInt("productid"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setProductImage(rs.getString("productImage"));
				vo.setProductInfo(rs.getString("productInfo"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return vo;
	}

}// dao
