package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class PaymentDao {

    // 결제 정보 저장 (트랜잭션 포함)
    public boolean savePayment(PaymentVo vo) {
        Connection cnn = null;
        PreparedStatement pstmtPayment = null;
        PreparedStatement pstmtOrder = null;

        try {
            cnn = DBManager.getInstance().getConnection();
            cnn.setAutoCommit(false); // 트랜잭션 시작

            // 결제 정보 저장
            String sqlPayment = "INSERT INTO NEW_PAYMENTS (paymentid, userid, orderid, amount, paymentMethod, paymentStatus, paymentDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmtPayment = cnn.prepareStatement(sqlPayment);
            pstmtPayment.setString(1, vo.getPaymentId());
            pstmtPayment.setString(2, vo.getUserId());
            pstmtPayment.setInt(3, vo.getOrderId());
            pstmtPayment.setDouble(4, vo.getAmount());
            pstmtPayment.setString(5, vo.getPaymentMethod());
            pstmtPayment.setString(6, vo.getPaymentStatus());
            pstmtPayment.setTimestamp(7, vo.getPaymentDate());
            pstmtPayment.executeUpdate();

            // 주문 상태 업데이트 (예시)
            String sqlOrder = "UPDATE NEW_ORDERS SET orderStatus = 'Paid' WHERE orderid = ?";
            pstmtOrder = cnn.prepareStatement(sqlOrder);
            pstmtOrder.setInt(1, vo.getOrderId());
            pstmtOrder.executeUpdate();

            cnn.commit(); // 트랜잭션 완료
            return true;

        } catch (SQLException e) {
            if (cnn != null) {
                try {
                    cnn.rollback(); // 오류 발생 시 롤백
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            DBManager.getInstance().close(pstmtPayment, cnn);
            DBManager.getInstance().close(pstmtOrder, null);
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