package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class CreatorDao {

	// 전체 작가 조회
	public List<CreatorVo> getSelect() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from NEW_AUTHOR order by authorid desc";

		List<CreatorVo> list = new ArrayList<CreatorVo>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CreatorVo vo = new CreatorVo();
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setAuthorname(rs.getString("authorname"));
				vo.setAuthorinfo(rs.getString("authorinfo"));
				vo.setAuthorimg1(rs.getString("authorimg1"));
				vo.setAuthorimg2(rs.getString("authorimg2"));
				vo.setAuthorimg3(rs.getString("authorimg3"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return list;
	}// select

	// 특정 작가 정보 조회 (프로필 수정용)
	public CreatorVo getAuthorProfile(String userid) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CreatorVo vo = null;

		String sql = "SELECT * FROM NEW_AUTHOR WHERE userid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new CreatorVo();
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setAuthorname(rs.getString("authorname"));
				vo.setAuthorinfo(rs.getString("authorinfo"));
				vo.setAuthorimg1(rs.getString("authorimg1"));
				vo.setAuthorimg2(rs.getString("authorimg2"));
				vo.setAuthorimg3(rs.getString("authorimg3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return vo;
	}

	// 작가 프로필 업데이트
	public void updateAuthor(String authorid, String authorname, String authorinfo, String img1, String img2,
			String img3) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "UPDATE NEW_AUTHOR SET authorname=?, authorinfo=?, authorimg1=?, authorimg2=?, authorimg3=? WHERE authorid=?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, authorname);
			pstmt.setString(2, authorinfo);
			pstmt.setString(3, img1);
			pstmt.setString(4, img2);
			pstmt.setString(5, img3);
			pstmt.setString(6, authorid);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
	}

	// 특정 작가 조회
	public List<CreatorVo> getSearch(int authorid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT " + "A.authorid, A.authorname, A.authorinfo, A.authorimg1, A.authorimg2, A.authorimg3, "
				+ "P.productid, P.productname, P.productprice, P.productstock, P.productinfo, "
				+ "P.categoryid, P.productimage, P.createdAt, P.updatedAt, " + "P.authorid AS product_authorid "
				+ "FROM NEW_AUTHOR A " + "LEFT JOIN NEW_PRODUCTS P ON A.authorid = P.authorid "
				+ "WHERE A.authorid = ? " + "ORDER BY P.createdAt DESC"; // 상품 최신순 정렬

		List<CreatorVo> list = new ArrayList<CreatorVo>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, authorid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CreatorVo vo = new CreatorVo();
				// 작가 정보
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setAuthorname(rs.getString("authorname"));
				vo.setAuthorinfo(rs.getString("authorinfo"));
				vo.setAuthorimg1(rs.getString("authorimg1"));
				vo.setAuthorimg2(rs.getString("authorimg2"));
				vo.setAuthorimg3(rs.getString("authorimg3"));
				vo.setProductAuthorid(rs.getInt("product_authorid"));

				// 상품 정보 (있을 때만)
				vo.setProductid(rs.getInt("productid")); // 상품이 없으면 0
				vo.setCategoryid(rs.getInt("categoryid"));
				vo.setProductName(rs.getString("productname"));
				vo.setProductPrice(rs.getInt("productprice"));
				vo.setProductStock(rs.getInt("productstock"));
				vo.setProductInfo(rs.getString("productinfo"));
				vo.setProductImage(rs.getString("productimage"));
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

	// 상품 등록 작가 ID 가져오기
	public int getAuthorIdByProduct(int productId) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT authorid FROM NEW_PRODUCTS WHERE productid = ?";

		int authorId = 0;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				authorId = rs.getInt("authorid");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return authorId;
	}

	// 상품 삭제
	public void deleteProduct(int productId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM NEW_PRODUCTS WHERE productid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(null, pstmt, conn);
		}
	}
	
//--------------------------------------------------------------------//
	//회원정보변경 메서드//
	//마이페이지->회원정보변경->작가 수정할 수 있는 페이지 이동//

	// 로그인 시 userid로 authorid 찾기
	public CreatorVo getAuthorProfileByUserId(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CreatorVo vo = null;

		// String sql = "SELECT * FROM NEW_AUTHOR WHERE userid = ?";
		String sql = "SELECT * FROM NEW_AUTHOR WHERE LOWER(TRIM(userid)) = LOWER(TRIM(?))";
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			System.out.println("조회된 userid: " + userid);
			System.out.println("authorid 조회 시도...");
			if (rs.next()) {
				vo = new CreatorVo();
				vo.setAuthorid(rs.getInt("authorid"));
				System.out.println("찾은 authorid: " + vo.getAuthorid()); //
			} else {
				System.out.println("작가 정보 없음 (userid로 못 찾음)"); // ⭐️⭐️⭐️⭐️⭐️
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return vo;
	}

	// authorid로 작가 정보 조회
	public CreatorVo getAuthorProfileByAuthorId(int authorid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CreatorVo vo = null;

		String sql = "SELECT * FROM NEW_AUTHOR WHERE authorid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, authorid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new CreatorVo();
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setAuthorname(rs.getString("authorname"));
				vo.setAuthorinfo(rs.getString("authorinfo"));
				vo.setAuthorimg1(rs.getString("authorimg1"));
				vo.setAuthorimg2(rs.getString("authorimg2"));
				vo.setAuthorimg3(rs.getString("authorimg3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return vo;
	}

	// 작가 정보 업데이트
	public void updateAuthor(int authorid, String authorname, String authorinfo, String img1, String img2,
			String img3) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "UPDATE NEW_AUTHOR SET authorname = ?, authorinfo = ?, authorimg1 = ?, authorimg2 = ?, authorimg3 = ? WHERE authorid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, authorname);
			pstmt.setString(2, authorinfo);
			pstmt.setString(3, img1);
			pstmt.setString(4, img2);
			pstmt.setString(5, img3);
			pstmt.setInt(6, authorid);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
	}
//----------------------------------------------------------//
	//마이페이지 작가 등록 및 경고창 메서드//
	
	// 마이페이지 작가 등록 메서드
	public void insertAuthor(String authorname, String authorinfo, String authorimg1, String authorimg2,
			String authorimg3, String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO NEW_AUTHOR (authorid, authorname, authorinfo, authorimg1, authorimg2, authorimg3, userid) "
				+ "VALUES (NEW_AUTHOR_SEQ.nextval, ?, ?, ?, ?, ?, ?)";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, authorname);
			pstmt.setString(2, authorinfo);
			pstmt.setString(3, authorimg1);
			pstmt.setString(4, authorimg2);
			pstmt.setString(5, authorimg3);
			pstmt.setString(6, userid);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
	}
	
	
	// "이미 등록된 작가인지 확인" 메소드 
	public boolean isAuthorExist(String userid) {
	   
		boolean result = false;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    String sql = "SELECT COUNT(*) FROM NEW_AUTHOR WHERE userid = ?";
	    
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userid);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            result = rs.getInt(1) > 0; // 1 이상이면 이미 존재
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	    return result;
	}
	
//-----------------------------------------------------------------//
	//크리에이터 페이징 처리 //
	
	// 작가 목록 페이징 조회
	public List<CreatorVo> getPagingCreatorList(int page, int pageSize) {
	    List<CreatorVo> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT * FROM ( " +
	                 "    SELECT ROWNUM rnum, A.* FROM ( " +
	                 "        SELECT * FROM NEW_AUTHOR ORDER BY authorid DESC " +
	                 "    ) A WHERE ROWNUM <= ? " +
	                 ") WHERE rnum >= ?";

	    int endRow = page * pageSize;
	    int startRow = (page - 1) * pageSize + 1;

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, endRow);
	        pstmt.setInt(2, startRow);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            CreatorVo vo = new CreatorVo();
	            vo.setAuthorid(rs.getInt("authorid"));
	            vo.setAuthorname(rs.getString("authorname"));
	            vo.setAuthorinfo(rs.getString("authorinfo"));
	            vo.setAuthorimg1(rs.getString("authorimg1"));
	            vo.setAuthorimg2(rs.getString("authorimg2"));
	            vo.setAuthorimg3(rs.getString("authorimg3"));
	            vo.setUserid(rs.getString("userid")); // userid도 가져오기
	            list.add(vo);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }

	    return list;
	}

	// 전체 작가 수 조회 
	public int getCreatorCount() {
	    
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT COUNT(*) FROM NEW_AUTHOR";

	    int count = 0;
	    
	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }

	    return count;
	}


}// dao
