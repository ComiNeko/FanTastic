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
	
	// 본인이 등록한 상품만 조회
	public List<PostVo> getMyProductList(String userId) {
	    List<PostVo> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT * FROM NEW_PRODUCTS p "
	               + "JOIN NEW_AUTHOR a ON p.authorid = a.authorid "
	               + "WHERE a.userid = ? "
	               + "ORDER BY p.productid DESC";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            PostVo vo = new PostVo();
	            vo.setProductid(rs.getInt("productid"));
	            vo.setProductName(rs.getString("productName"));
	            vo.setProductPrice(rs.getInt("productPrice"));
	            vo.setProductStock(rs.getInt("productStock"));
	            vo.setProductInfo(rs.getString("productInfo"));
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
	}

	//전체상품조회
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
	
	
	//본인이 등록한 상품만 조회가능한 메서드
	public boolean isUserProductOwner(int productId, String userId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    boolean isOwner = false;

	    String sql = "SELECT COUNT(*) FROM NEW_PRODUCTS p "
	               + "JOIN NEW_AUTHOR a ON p.authorid = a.authorid "
	               + "WHERE p.productid = ? AND a.userid = ?";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, productId);
	        pstmt.setString(2, userId);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            isOwner = rs.getInt(1) > 0;  // 결과값이 0보다 크면 본인 상품
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return isOwner;
	}

	
	
	
	 // 상품 삭제 (관련 데이터 삭제 포함)
    public boolean deleteMyProduct(int productId, String userId) {
        if (!isUserProductOwner(productId, userId)) {
            return false;
        }
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isDeleted = false;

        try {
            conn = DBManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            // 장바구니에서 삭제
            String deleteCartSql = "DELETE FROM NEW_CARTS WHERE productid = ?";
            pstmt = conn.prepareStatement(deleteCartSql);
            pstmt.setInt(1, productId);
            pstmt.executeUpdate();
            pstmt.close();

            // 찜 목록에서 삭제
            String deleteFavoriteSql = "DELETE FROM NEW_FAVORITES WHERE productid = ?";
            pstmt = conn.prepareStatement(deleteFavoriteSql);
            pstmt.setInt(1, productId);
            pstmt.executeUpdate();
            pstmt.close();

            // 최종 상품 삭제
            String deleteSql = "DELETE FROM NEW_PRODUCTS WHERE productid = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, productId);
            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                isDeleted = true;
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            DBManager.getInstance().close(pstmt, conn);
        }
        return isDeleted;
    }

    // 상품 수정
    public boolean updateMyProduct(PostVo vo, String userId) {
        if (!isUserProductOwner(vo.getProductid(), userId)) {
            return false;
        }
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isUpdated = false;

        try {
            conn = DBManager.getInstance().getConnection();

            String updateSql = "UPDATE NEW_PRODUCTS SET productName=?, productPrice=?, productStock=?, productInfo=?, productImage=?, updatedAt=CURRENT_TIMESTAMP WHERE productid=?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, vo.getProductName());
            pstmt.setInt(2, vo.getProductPrice());
            pstmt.setInt(3, vo.getProductStock());
            pstmt.setString(4, vo.getProductInfo());
            pstmt.setString(5, vo.getProductImage());
            pstmt.setInt(6, vo.getProductid());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                isUpdated = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.getInstance().close(pstmt, conn);
        }

        return isUpdated;
    }

	
	
	
	
	
	
//-------------------------------------------------------------//
	
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
	
	//-------------------------------------------------//
				//여기서부터 장바구니//
	
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
	
	 // [1] 카테고리별 찜 목록 조회 (페이징 적용)
    public List<PostVo> getFavoriteListByCategory(String userId, int categoryId, int page, int pageSize) {
        List<PostVo> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int offset = (page - 1) * pageSize;

        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * FROM ( ");
        sb.append(" SELECT a.*, ROWNUM rnum FROM ( ");
        sb.append("  SELECT f.favoriteid, p.productid, p.productname, p.productimage, p.productprice ");
        sb.append("  FROM NEW_FAVORITES f ");
        sb.append("  JOIN NEW_PRODUCTS p ON f.productid = p.productid ");
        sb.append("  WHERE f.userid = ? ");
        if (categoryId > 0) {
            sb.append(" AND p.categoryid = ? ");
        }
        sb.append("  ORDER BY f.favoriteid DESC ");
        sb.append(" ) a ");
        sb.append(" WHERE ROWNUM <= ? ");
        sb.append(") WHERE rnum > ?");

        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sb.toString());
            int idx = 1;
            pstmt.setString(idx++, userId);
            if (categoryId > 0) {
                pstmt.setInt(idx++, categoryId);
            }
            pstmt.setInt(idx++, offset + pageSize);
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

    // [2] 찜 개수 조회 (페이징 계산용)
    public int getFavoriteCount(String userId, int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT COUNT(*) AS cnt ");
        sb.append("FROM NEW_FAVORITES f ");
        sb.append("JOIN NEW_PRODUCTS p ON f.productid = p.productid ");
        sb.append("WHERE f.userid = ? ");
        if (categoryId > 0) {
            sb.append(" AND p.categoryid = ? ");
        }
        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sb.toString());
            int idx = 1;
            pstmt.setString(idx++, userId);
            if (categoryId > 0) {
                pstmt.setInt(idx++, categoryId);
            }
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("cnt");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBManager.getInstance().close(rs, pstmt, conn);
        }
        return count;
    }

    // [3] 찜 추가
    public boolean addToFavorite(String userId, int productId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        // favoriteid에 시퀀스 값 추가!
        String sql = "INSERT INTO NEW_FAVORITES (FAVORITEID, USERID, PRODUCTID) VALUES (NEW_FAVORITES_SEQ.NEXTVAL, ?, ?)";
        
        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, productId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBManager.getInstance().close(pstmt, conn);
        }
    }

    // [4] 찜 삭제 (단일 또는 다중 삭제 지원)
    public void removeFromFavorite(String userId, int productId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM NEW_FAVORITES WHERE userid = ? AND productid = ?";
        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
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
