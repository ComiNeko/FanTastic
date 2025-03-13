package util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.google.gson.JsonObject;

import Model.PaymentDao;
import Model.PaymentVo;

public class PaymentUtil {

	public static boolean processPayments(List<PaymentVo> paymentList) {
        boolean allPaymentsSuccessful = true; // 모든 결제가 성공했는지 확인

        for (PaymentVo payment : paymentList) {
            // 각 결제 처리
            boolean paymentSuccess = callPaymentApi(payment);

            // 결제 성공 시 데이터베이스에 저장
            if (paymentSuccess) {
                PaymentDao dao = new PaymentDao();
                payment.setPaymentStatus("Completed"); // 결제 상태 설정
                String paymentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
                payment.setPaymentDate(paymentDate); // 현재 시간을 포맷팅하여 설정
                dao.savePayment(payment); // 결제 정보 저장
            } else {
                payment.setPaymentStatus("Failed"); // 결제 실패 시 상태 설정
                PaymentDao dao = new PaymentDao();
                dao.savePayment(payment); // 결제 정보 저장 (실패로)
                allPaymentsSuccessful = false; // 하나라도 실패하면 false
            }
        }

        return allPaymentsSuccessful; // 모든 결제가 성공했는지 여부 반환
    }

    private static boolean callPaymentApi(PaymentVo payment) {
        try {
            // 아임포트 결제 요청 URL
            String url = "https://api.iamport.kr/payments/prepare"; // 결제 준비 API (예시)

            // 아임포트 API 호출을 위한 연결 설정
            URL obj = new URL(url);
            HttpURLConnection connection = (HttpURLConnection) obj.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);

            // Gson을 사용하여 JSON 객체 생성
            JsonObject requestData = new JsonObject();
            requestData.addProperty("merchant_uid", String.valueOf(payment.getOrderId())); // 주문 ID
            requestData.addProperty("amount", payment.getAmount()); // 결제 금액
            requestData.addProperty("name", "상품명"); // 상품명
            requestData.addProperty("buyer_name", payment.getUserId()); // 구매자 이름
            requestData.addProperty("buyer_email", "buyer@example.com"); // 구매자 이메일 (선택)

            // 요청 데이터 전송
            OutputStream os = connection.getOutputStream();
            os.write(requestData.toString().getBytes());
            os.flush();
            os.close();

            // 응답 코드 확인
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 추가적으로 응답 본문을 읽어 결제 성공 여부 확인
                // (예: InputStreamReader로 응답을 읽고 JSON 파싱하여 처리)
                return true; // 성공으로 가정
            } else {
                // 오류 처리: 응답 코드가 200이 아닐 경우
                System.err.println("Payment API call failed with response code: " + responseCode);
                return false;
            }
        } catch (Exception e) {
            // 구체적인 예외 처리
            System.err.println("Error during payment API call: " + e.getMessage());
            return false; // 예외 발생 시 결제 실패로 처리
        }
    }

	public static int generateOrderId() {
		// TODO Auto-generated method stub
		return 0;
	}
}
