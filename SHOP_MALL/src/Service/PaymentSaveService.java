package Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.annotation.JsonProperty;

import Model.PaymentDao;
import util.DBManager;


public class PaymentSaveService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	 // JSON 데이터 읽기
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }

     // JSON 데이터 파싱
        ObjectMapper objectMapper = new ObjectMapper();
        PaymentData paymentData = objectMapper.readValue(jsonBuilder.toString(), PaymentData.class);

        // 파싱된 데이터 출력
        System.out.println("userId: " + paymentData.getUserId());
        System.out.println("impUid: " + paymentData.getImpUid());
        System.out.println("productId: " + paymentData.getProductId());
        System.out.println("productQuantity: " + paymentData.getProductQuantity());
        System.out.println("payMethod: " + paymentData.getPayMethod());
        System.out.println("amount: " + paymentData.getAmount());
        System.out.println("buyerAddress: " + paymentData.getBuyerAddress());

        // PaymentDao 객체 생성
        PaymentDao paymentDao = new PaymentDao();

        Connection conn = null;
        try {
            conn = DBManager.getInstance().getConnection(); // 데이터베이스 연결

            // 1. 주문 정보 저장 (NEW_ORDERS 테이블)
            int orderId = paymentDao.insertOrder(conn, paymentData.getUserId(), Integer.parseInt(paymentData.getAmount()), paymentData.getBuyerAddress());

            // 2. 주문 상세 정보 저장 (NEW_ORDERDETAILS 테이블)
            boolean isOrderDetailInserted = paymentDao.insertOrderDetail(
                conn, 
                orderId, 
                Integer.parseInt(paymentData.getProductId()), 
                Integer.parseInt(paymentData.getProductQuantity()), 
                "Pending" // 배송 상태
            );

            // 3. 결제 정보 저장 (NEW_PAYMENTS 테이블)
            boolean isPaymentInserted = paymentDao.insertPayment(
                conn, 
                paymentData.getImpUid(), 
                paymentData.getUserId(), 
                orderId, 
                Integer.parseInt(paymentData.getAmount()), 
                paymentData.getPayMethod(), 
                "Completed" // 결제 상태
            );

            // 결과 처리
            if (isOrderDetailInserted && isPaymentInserted) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"결제 정보가 성공적으로 저장되었습니다.\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"결제 정보 저장에 실패했습니다.\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"데이터베이스 오류가 발생했습니다.\"}");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"잘못된 숫자 형식입니다.\"}");
        } finally {
            DBManager.getInstance().close(conn); // 연결 종료
        }
    }
}

// JSON 데이터를 매핑할 클래스
class PaymentData {
	@JsonProperty("userid") // JSON에서의 필드 이름
    private String userId;
	
    @JsonProperty("imp_uid")
    private String impUid;

    @JsonProperty("merchant_uid")
    private String merchantUid;

    @JsonProperty("productId")
    private String productId;

    @JsonProperty("productName")
    private String productName;

    @JsonProperty("productQuantity")
    private String productQuantity;

    @JsonProperty("pay_method")
    private String payMethod;

    private String amount;

    @JsonProperty("buyer_name")
    private String buyerName;

    @JsonProperty("buyer_tel")
    private String buyerTel;

    @JsonProperty("buyer_email")
    private String buyerEmail;

    @JsonProperty("buyer_address")
    private String buyerAddress;

    // Getter와 Setter
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getImpUid() { return impUid; }
    public void setImpUid(String impUid) { this.impUid = impUid; }

    public String getMerchantUid() { return merchantUid; }
    public void setMerchantUid(String merchantUid) { this.merchantUid = merchantUid; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductQuantity() { return productQuantity; }
    public void setProductQuantity(String productQuantity) { this.productQuantity = productQuantity; }

    public String getPayMethod() { return payMethod; }
    public void setPayMethod(String payMethod) { this.payMethod = payMethod; }

    public String getAmount() { return amount; }
    public void setAmount(String amount) { this.amount = amount; }

    public String getBuyerName() { return buyerName; }
    public void setBuyerName(String buyerName) { this.buyerName = buyerName; }

    public String getBuyerTel() { return buyerTel; }
    public void setBuyerTel(String buyerTel) { this.buyerTel = buyerTel; }

    public String getBuyerEmail() { return buyerEmail; }
    public void setBuyerEmail(String buyerEmail) { this.buyerEmail = buyerEmail; }

    public String getBuyerAddress() { return buyerAddress; }
    public void setBuyerAddress(String buyerAddress) { this.buyerAddress = buyerAddress; }
}