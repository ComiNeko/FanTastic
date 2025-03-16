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
    
    
//-----------------
    //LTR-마이페이지 결제 VIEW 관련
//-----------------
    
 // 최근 3개월 이내 주문 내역 1건 조회 (수정본)
    public PostVo getRecentOrderByUserId(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        PostVo vo = null;

        String sql = 
            "SELECT * FROM ( \n" + 
            "    SELECT \n" + 
            "        o.orderid AS order_id, \n" + 
            "        p.productid AS product_id, \n" + 
            "        p.productName AS product_name, \n" + 
            "        od.productCount AS product_count, \n" + 
            "        od.deliveryStatus AS delivery_status, \n" + 
            "        TO_CHAR(pay.paymentDate, 'YYYY-MM-DD') AS payment_date, \n" + //-- 날짜만 가져오기
            "        p.productImage AS product_image \n" + 
            "    FROM NEW_ORDERS o \n" + 
            "    JOIN NEW_ORDERDETAILS od ON o.orderid = od.orderid \n" + 
            "    JOIN NEW_PRODUCTS p ON od.productid = p.productid \n" + 
            "    JOIN NEW_PAYMENTS pay ON o.orderid = pay.orderid \n" + 
            "    WHERE o.userid = ? \n" + 
            "    AND pay.paymentDate >= ADD_MONTHS(SYSDATE, -3) \n" + 
            "    ORDER BY pay.paymentDate DESC \n" + 
            ") WHERE ROWNUM = 1";

        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                vo = new PostVo();
                vo.setOrderid(rs.getInt("order_id"));
                vo.setProductid(rs.getInt("product_id"));
                vo.setProductName(rs.getString("product_name"));
                vo.setQuantity(rs.getInt("product_count"));
                vo.setDeliveryStatus(rs.getString("delivery_status"));
                vo.setProductImage(rs.getString("product_image"));
                vo.setCreatedAt(rs.getString("payment_date"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBManager.getInstance().close(rs, pstmt, conn);
        }

        return vo;
    }

   //구매이력조회
    public List<PostVo> getOrderListByUserId(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<PostVo> list = new ArrayList<>();

        String sql = "SELECT o.orderid, p.productName, od.productCount, od.deliveryStatus, pay.paymentDate, p.productImage "
                   + "FROM NEW_ORDERS o "
                   + "JOIN NEW_ORDERDETAILS od ON o.orderid = od.orderid "
                   + "JOIN NEW_PRODUCTS p ON od.productid = p.productid "
                   + "JOIN NEW_PAYMENTS pay ON o.orderid = pay.orderid "
                   + "WHERE o.userid = ? "
                   + "ORDER BY pay.paymentDate DESC";

        try {
            conn = DBManager.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            // 날짜 포맷터 생성
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

            while (rs.next()) {
                PostVo vo = new PostVo();

                vo.setProductid(rs.getInt("orderid"));
                vo.setProductName(rs.getString("productName"));
                vo.setQuantity(rs.getInt("productCount"));
                vo.setProductImage(rs.getString("productImage"));

                // Timestamp -> 원하는 포맷으로 String 변환
                java.sql.Timestamp paymentDate = rs.getTimestamp("paymentDate");
                String formattedDate = sdf.format(paymentDate);

                vo.setCreatedAt(formattedDate);  // 포맷한 값 저장!

                list.add(vo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.getInstance().close(rs, pstmt, conn);
        }

        return list;
    }

	    
	    
    
}