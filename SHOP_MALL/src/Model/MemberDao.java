package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class MemberDao {
	// 회원가입: 아이디 중복확인
	public int UserFindUserid(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT userid FROM NEW_USERS WHERE userid=?";
		int result = 0;

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			System.out.println("입력된 userid: " + userid);
			if (rs.next()) {
				System.out.println("존재하는 userid: " + rs.getString("userid"));
				result = 1;
			} else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return result;
	}

	// 회원가입: 회원 정보 삽입 (회원 테이블과 주소 테이블에 분리하여 삽입)
	public void saveUser(MemberVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		// 회원 테이블과 주소 테이블에 삽입할 SQL 구문
		String sqlUser = "INSERT INTO NEW_USERS (userid, password, name, phonenumber, email, role) VALUES (?, ?, ?, ?, ?, 'User')";
		String sqlAddress = "INSERT INTO NEW_ADDRESSES (addressid, userid, address) VALUES (NEW_ADDRESSES_seq.nextval, ?, ?)";

		try {
			conn = DBManager.getInstance().getConnection();
			conn.setAutoCommit(false); // 트랜잭션 시작

			// 1. 회원 테이블에 데이터 삽입
			pstmt = conn.prepareStatement(sqlUser);
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getPhonenumber());
			pstmt.setString(5, vo.getEmail());
			pstmt.executeUpdate();
			pstmt.close(); // 다음 쿼리를 위해 pstmt를 재사용

			// 2. 주소 테이블에 데이터 삽입
			pstmt = conn.prepareStatement(sqlAddress);
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, vo.getAddress());
			pstmt.executeUpdate();

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
	}

	// ________________________________________________________________________________//

	// 로그인: userid로 회원 정보 가져오기
	public MemberVo getMemberById(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT u.userid, u.name, u.password, u.phonenumber, u.email, u.role, a.address "
				+ "FROM NEW_USERS u JOIN NEW_ADDRESSES a ON u.userid = a.userid " + "WHERE u.userid = ?";

		MemberVo vo = null;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVo();
				vo.setUserid(rs.getString("userid"));
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setPhonenumber(rs.getString("phonenumber"));
				vo.setEmail(rs.getString("email"));
				vo.setRole(rs.getString("role"));
				vo.setAddress(rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return vo;
	}

	// 아이디 찾기: 이메일로 아이디 찾기
	public String findUserId(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT userid FROM NEW_USERS WHERE email = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString("userid");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return null;
	}
		       
	   
		 
		//________________________________________________________________________________//
		//________________________________________________________________________________//  
		 
		
		// 최근 본 상품 추가
	public void addRecentView(String userid, int productid) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DBManager.getInstance().getConnection();
	        conn.setAutoCommit(false);

	        // 1. 동일한 상품이 이미 등록되어 있으면 삭제 (중복 제거)
	        String deleteSql = "DELETE FROM NEW_RECENT_VIEWS WHERE userid = ? AND productid = ?";
	        pstmt = conn.prepareStatement(deleteSql);
	        pstmt.setString(1, userid);
	        pstmt.setInt(2, productid);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 2. 새 기록 삽입
	        String insertSql = "INSERT INTO NEW_RECENT_VIEWS (recent_view_id, userid, productid, view_date) "
	                         + "VALUES (NEW_RECENT_VIEWS_SEQ.nextval, ?, ?, CURRENT_TIMESTAMP)";
	        pstmt = conn.prepareStatement(insertSql);
	        pstmt.setString(1, userid);
	        pstmt.setInt(2, productid);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 3. 최근 본 상품 개수가 10개 초과하면 오래된 항목 삭제
	        String selectSql = "SELECT recent_view_id "
	                         + "FROM (SELECT recent_view_id FROM NEW_RECENT_VIEWS WHERE userid = ? ORDER BY view_date DESC) "
	                         + "WHERE ROWNUM > 13";
	        pstmt = conn.prepareStatement(selectSql);
	        pstmt.setString(1, userid);
	        rs = pstmt.executeQuery();

	        List<Integer> idsToDelete = new ArrayList<>();
	        while (rs.next()) {
	            idsToDelete.add(rs.getInt("recent_view_id"));
	        }
	        rs.close();
	        pstmt.close();

	        if (!idsToDelete.isEmpty()) {
	            StringBuilder sb = new StringBuilder("DELETE FROM NEW_RECENT_VIEWS WHERE recent_view_id IN (");
	            for (int i = 0; i < idsToDelete.size(); i++) {
	                sb.append("?");
	                if (i < idsToDelete.size() - 1) sb.append(",");
	            }
	            sb.append(")");

	            pstmt = conn.prepareStatement(sb.toString());
	            for (int i = 0; i < idsToDelete.size(); i++) {
	                pstmt.setInt(i + 1, idsToDelete.get(i));
	            }
	            pstmt.executeUpdate();
	            pstmt.close();
	        }

	        conn.commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }
	}

		 // 최근 본 상품 조회 (view_date를 String으로 변환)
	public List<MemberVo.RecentView> getRecentViews(String userid) {
	    List<MemberVo.RecentView> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT rv.recent_view_id, rv.productid, rv.view_date, "
	               + "p.productName, p.productPrice, p.productImage, "
	               + "a.authorName "
	               + "FROM NEW_RECENT_VIEWS rv "
	               + "JOIN NEW_PRODUCTS p ON rv.productid = p.productid "
	               + "JOIN NEW_AUTHOR a ON p.authorid = a.authorid "
	               + "WHERE rv.userid = ? "
	               + "ORDER BY rv.view_date DESC";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userid);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            MemberVo.RecentView rv = new MemberVo.RecentView();

	            
	            rv.setRecent_view_id(rs.getInt("recent_view_id"));

	            // 기존 상품 정보 세팅
	            rv.setProductId(rs.getInt("productid"));
	            rv.setViewDate(rs.getTimestamp("view_date").toString());
	            rv.setProductName(rs.getString("productName"));
	            rv.setProductPrice(rs.getInt("productPrice"));
	            rv.setProductImage(rs.getString("productImage"));
	            rv.setAuthorName(rs.getString("authorName"));

	            // 리스트에 추가
	            list.add(rv);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(rs, pstmt, conn);
	    }

	    return list;
	}


		 // 최근 본 상품 삭제
	public void removeRecentView(String userid, int recent_view_id) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "DELETE FROM NEW_RECENT_VIEWS WHERE userid = ? AND recent_view_id = ?";

	    try {
	        conn = DBManager.getInstance().getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userid);
	        pstmt.setInt(2, recent_view_id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, conn);
	    }
	}

	// ________________________________________________________________________________//

	// 비밀번호 찾기: 토큰 저장
	public int createResetToken(String userid, String token, long expiryTime) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO PASSWORD_TOKENS (token, userid, expiryTime) VALUES (?, ?, ?)";
		int result = 0;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, token);
			pstmt.setString(2, userid);
			pstmt.setLong(3, expiryTime);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
		return result;
	}

	// 비밀번호 찾기: 토큰으로 userid 조회 (토큰이 유효한 경우)
	public String getUserIdByToken(String token) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT userid FROM PASSWORD_TOKENS WHERE token = ? AND expiryTime >= ?";
		String userid = null;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, token);
			pstmt.setLong(2, System.currentTimeMillis());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userid = rs.getString("userid");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return userid;
	}

	// 비밀번호 찾기: 사용자 아이디로 유효한 토큰 조회
	public String getTokenByUserId(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT token FROM PASSWORD_TOKENS WHERE userid = ? AND expiryTime >= ?";
		String token = null;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setLong(2, System.currentTimeMillis());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				token = rs.getString("token");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return token;
	}

	// 비밀번호 찾기: 토큰 삭제
	public int deleteToken(String token) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM PASSWORD_TOKENS WHERE token = ?";
		int result = 0;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, token);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
		return result;
	}

	// ________________________________________________________________________________//
	// ________________________________________________________________________________//

	// 회원정보 수정
	public int updateMember(MemberVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		// NEW_USERS 테이블에서는 휴대폰번호만 수정
		String sqlUser = "UPDATE NEW_USERS SET phonenumber = ? WHERE userid = ?";

		// NEW_ADDRESSES 테이블에서는 하나의 칼럼인 address에 전체 주소(주소 + 상세주소)를 업데이트
		String sqlAddress = "UPDATE NEW_ADDRESSES SET address = ? WHERE userid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			conn.setAutoCommit(false); // 트랜잭션 시작

			// 휴대폰번호 업데이트
			pstmt = conn.prepareStatement(sqlUser);
			pstmt.setString(1, vo.getPhonenumber());
			pstmt.setString(2, vo.getUserid());
			result = pstmt.executeUpdate();
			pstmt.close(); // PreparedStatement 재사용

			// 주소 업데이트
			pstmt = conn.prepareStatement(sqlAddress);
			pstmt.setString(1, vo.getAddress());
			pstmt.setString(2, vo.getUserid());
			pstmt.executeUpdate();

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
		return result;
	}

	// 회원정보 수정: 비밀번호
	public int updatePassword(String userid, String newPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "UPDATE NEW_USERS SET password = ? WHERE userid = ?";

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPassword);
			pstmt.setString(2, userid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
		return result;
	}

	// userid로 authorid 찾기
	public int getAuthorid(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select a.authorid\n" + 
				"from new_author a, new_users u \n" + 
				"where a.userid = u.userid and u.userid = ?";
		int authorid = 0;
		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				authorid = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(pstmt, conn);
		}
		return authorid;
		
	}

}
