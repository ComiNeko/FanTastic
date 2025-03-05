package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		    } catch(Exception e) {
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
		        conn.setAutoCommit(false);  // 트랜잭션 시작
		        
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
		    } catch(Exception e) {e.printStackTrace();}
		      finally {DBManager.getInstance().close(pstmt, conn);}
		}
		
	//________________________________________________________________________________//
		
		
		//로그인: user_id로 회원 정보 가져오기
		public MemberVo getMemberById(String userid) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String sql = "SELECT u.userid, u.name, u.password, u.phonenumber, u.email, a.address "
	                   + "FROM NEW_USERS u JOIN NEW_ADDRESSES a ON u.userid = a.userid "
	                   + "WHERE u.userid = ?";
	        
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
	                vo.setAddress(rs.getString("address"));
	            }
	        } catch(Exception e) {
	            e.printStackTrace();
	        } finally {
	            DBManager.getInstance().close(rs, pstmt, conn);
	        }
	        return vo;
	    }
		
		
		//________________________________________________________________________________//
		
		//회원정보 수정
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
		        conn.setAutoCommit(false);  // 트랜잭션 시작

		        // 휴대폰번호 업데이트
		        pstmt = conn.prepareStatement(sqlUser);
		        pstmt.setString(1, vo.getPhonenumber());
		        pstmt.setString(2, vo.getUserid());
		        result = pstmt.executeUpdate();
		        pstmt.close();  // PreparedStatement 재사용

		        // 주소 업데이트
		        pstmt = conn.prepareStatement(sqlAddress);
		        pstmt.setString(1, vo.getAddress());
		        pstmt.setString(2, vo.getUserid());
		        pstmt.executeUpdate();

		        conn.commit();
		    } catch(Exception e) {
		        e.printStackTrace();
		    } finally {
		        DBManager.getInstance().close(pstmt, conn);
		    }
		    return result;
		}
		
		//회원정보 수정: 비밀번호
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
		        } catch(Exception e) {
		            e.printStackTrace();
		        } finally {
		            DBManager.getInstance().close(pstmt, conn);
		        }
		        return result;
		    }
	    
		
}
