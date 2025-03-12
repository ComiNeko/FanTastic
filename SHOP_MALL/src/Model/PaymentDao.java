package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class PaymentDao {

	// 결제 정보를 데이터베이스에 저장
	public void savePayment(PaymentVo vo) {
    	Connection cnn = null; // DB 연결 메서드
        PreparedStatement pstmt = null; 
    	
        String sql = "INSERT INTO NEW_PAYMENTS (paymentid, userid, orderid, paymentMethod, paymentStatus, paymentDate) VALUES (?, ?, ?, ?, ?, ?)";
        try {
        	cnn = DBManager.getInstance().getConnection();
    		pstmt = cnn.prepareStatement(sql);
        		
            pstmt.setInt(1, vo.getPaymentId());
            pstmt.setString(2, vo.getUserId());
            pstmt.setInt(3, vo.getOrderId());
            pstmt.setString(4, vo.getPaymentMethod());
            pstmt.setString(5, vo.getPaymentStatus());
            pstmt.setString(6, vo.getPaymentDate()); // String 형식으로 저장
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
			DBManager.getInstance().close(pstmt, cnn);
		}
    }

	// 결제 ID로 결제 정보를 조회
	public List<PaymentVo> getPaymentById(int paymentId) {
		Connection cnn = null; 
        PreparedStatement pstmt = null; 
        
        List<PaymentVo> list = new ArrayList<PaymentVo>();
        
		String sql = "SELECT * FROM NEW_PAYMENTS WHERE paymentid = ?";
		try {
			cnn = DBManager.getInstance().getConnection();
	    	pstmt = cnn.prepareStatement(sql);
			pstmt.setInt(1, paymentId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				PaymentVo vo = new PaymentVo();
				vo = new PaymentVo();
				vo.setPaymentId(rs.getInt("paymentid"));
				vo.setUserId(rs.getString("userid"));
				vo.setOrderId(rs.getInt("orderid"));
				vo.setPaymentMethod(rs.getString("paymentMethod"));
				vo.setPaymentStatus(rs.getString("paymentStatus"));
				vo.setPaymentDate(rs.getString("paymentDate")); 
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
