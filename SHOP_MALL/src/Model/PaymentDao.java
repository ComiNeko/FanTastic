package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import util.DBManager;

public class PaymentDao {

	// 결제 정보를 데이터베이스에 저장
	public void savePayment(PaymentVo vo) {
	    Connection cnn = null; // DB 연결 메서드
	    PreparedStatement pstmt = null; 

	    // 결제 ID 생성
	    String paymentId = generatePaymentId();
	    vo.setPaymentId(paymentId); // PaymentVo에 결제 ID 설정

	    String sql = "INSERT INTO NEW_PAYMENTS (paymentid, userid, orderid, amount, paymentMethod, paymentStatus, paymentDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try {
	        cnn = DBManager.getInstance().getConnection();
	        pstmt = cnn.prepareStatement(sql);
	            
	        pstmt.setString(1, vo.getPaymentId());
	        pstmt.setString(2, vo.getUserId());
	        pstmt.setInt(3, vo.getOrderId());
	        pstmt.setDouble(4, vo.getAmount()); // 결제 금액 추가
	        pstmt.setString(5, vo.getPaymentMethod());
	        pstmt.setString(6, vo.getPaymentStatus());
	        pstmt.setString(7, vo.getPaymentDate()); // String 형식으로 저장
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.getInstance().close(pstmt, cnn);
	    }
	}

	// 결제 ID로 결제 정보를 조회
	public List<PaymentVo> getPaymentById(String paymentId) {
		Connection cnn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<PaymentVo> list = new ArrayList<PaymentVo>();

		String sql = "SELECT * FROM NEW_PAYMENTS WHERE paymentid = ?";
		try {
			cnn = DBManager.getInstance().getConnection();
			pstmt = cnn.prepareStatement(sql);
			pstmt.setString(1, paymentId); // paymentId를 문자열로 설정
			rs = pstmt.executeQuery();
			while (rs.next()) { // 여러 결제 레코드를 처리하기 위해 while 사용
				PaymentVo vo = new PaymentVo();
				vo.setPaymentId(rs.getString("paymentid"));
				vo.setUserId(rs.getString("userid"));
				vo.setOrderId(rs.getInt("orderid"));
				vo.setAmount(rs.getDouble("amount")); // 결제 금액 추가
				vo.setPaymentMethod(rs.getString("paymentMethod"));
				vo.setPaymentStatus(rs.getString("paymentStatus"));
				vo.setPaymentDate(rs.getString("paymentDate"));
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, cnn); // 자원 해제
		}
		return list;
	}

	// 결제 ID 생성 메서드
	public String generatePaymentId() {
		// 현재 날짜를 YYYYMMDD 형식으로 포맷팅
		String datePart = new SimpleDateFormat("yyyyMMdd").format(new Date());

		// 데이터베이스에서 오늘 날짜에 대한 결제 수를 카운트하여 다음 번호 생성
		int count = getTodayPaymentCount(datePart); // 오늘 결제 수를 가져오는 메서드
		String countPart = String.format("%06d", count + 1); // 6자리 번호로 포맷팅

		return "ORD" + datePart + "-" + countPart; // 결제 ID 생성
	}

	// 오늘 날짜에 대한 결제 수를 카운트하는 메서드
	private int getTodayPaymentCount(String datePart) {
		Connection cnn = null; // DB 연결 메서드
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;
		String sql = "SELECT COUNT(*) FROM NEW_PAYMENTS WHERE paymentid LIKE 'ORD" + datePart + "-%'";
		try {
			cnn = DBManager.getInstance().getConnection();
			pstmt = cnn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count; // 오늘 날짜의 결제 수 반환
	}
}
