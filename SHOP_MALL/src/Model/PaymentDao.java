package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class PaymentDao {
	public int insertOrder(Connection conn, String userId, int totalPrice, String address) throws SQLException {
	    String sql = "INSERT INTO NEW_ORDERS (orderid, userid, totalPrice, address) VALUES (order_seq.NEXTVAL, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql, new String[] {"orderid"})) {
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, totalPrice);
	        pstmt.setString(3, address);
	        pstmt.executeUpdate();

	        // 생성된 orderid 반환
	        try (ResultSet rs = pstmt.getGeneratedKeys()) {
	            if (rs.next()) {
	                return rs.getInt(1);
	            }
	        }
	    }
	    throw new SQLException("주문 정보 저장 실패");
	}

	public boolean insertOrderDetail(Connection conn, int orderId, int productId, int productCount, String deliveryStatus) throws SQLException {
	    String sql = "INSERT INTO NEW_ORDERDETAILS (orderDetail, productid, orderid, productCount, deliveryStatus) VALUES (order_detail_seq.NEXTVAL, ?, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, productId);
	        pstmt.setInt(2, orderId);
	        pstmt.setInt(3, productCount);
	        pstmt.setString(4, deliveryStatus);
	        return pstmt.executeUpdate() > 0;
	    }
	}

	public boolean insertPayment(Connection conn, String paymentid, String userId, int orderId, int amount, String paymentMethod, String paymentStatus) throws SQLException {
	    String sql = "INSERT INTO NEW_PAYMENTS (paymentid, userid, orderid, amount, paymentMethod, paymentStatus) VALUES (?, ?, ?, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, paymentid);
	        pstmt.setString(2, userId);
	        pstmt.setInt(3, orderId);
	        pstmt.setInt(4, amount);
	        pstmt.setString(5, paymentMethod);
	        pstmt.setString(6, paymentStatus);
	        return pstmt.executeUpdate() > 0;
	    }
	}

    // 결제 정보 조회
    public List<PaymentVo> getPaymentsByUserId(String userId) {
        Connection cnn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<PaymentVo> list = new ArrayList<>();

        String sql = "SELECT * FROM NEW_PAYMENTS WHERE userid = ? ORDER BY paymentDate DESC";
        try {
            cnn = DBManager.getInstance().getConnection();
            pstmt = cnn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PaymentVo vo = new PaymentVo();
                vo.setPaymentId(rs.getString("paymentid"));
                vo.setUserId(rs.getString("userid"));
                vo.setOrderId(rs.getInt("orderid"));
                vo.setAmount(rs.getInt("amount"));
                vo.setPaymentMethod(rs.getString("paymentMethod"));
                vo.setPaymentStatus(rs.getString("paymentStatus"));
                vo.setPaymentDate(rs.getTimestamp("paymentDate"));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBManager.getInstance().close(rs, pstmt, cnn);
        }
        return list;
    }

    // 결제 상태 업데이트
    public boolean updatePaymentStatus(String paymentId, String newStatus) {
        Connection cnn = null;
        PreparedStatement pstmt = null;

        String sql = "UPDATE NEW_PAYMENTS SET paymentStatus = ? WHERE paymentid = ?";
        try {
            cnn = DBManager.getInstance().getConnection();
            pstmt = cnn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setString(2, paymentId);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBManager.getInstance().close(pstmt, cnn);
        }
    }

    // 결제 정보 삭제
    public boolean deletePayment(String paymentId) {
        Connection cnn = null;
        PreparedStatement pstmt = null;

        String sql = "DELETE FROM NEW_PAYMENTS WHERE paymentid = ?";
        try {
            cnn = DBManager.getInstance().getConnection();
            pstmt = cnn.prepareStatement(sql);
            pstmt.setString(1, paymentId);

            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBManager.getInstance().close(pstmt, cnn);
        }
    }
}