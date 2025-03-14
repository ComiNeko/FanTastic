package Service;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.PaymentDao;
import Model.PaymentVo;

public class PaymentSaveService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 요청 파라미터에서 결제 정보 추출
        String paymentId = request.getParameter("paymentId");
        String userId = request.getParameter("userId");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int amount = Integer.parseInt(request.getParameter("amount"));
        String paymentMethod = request.getParameter("paymentMethod");
        String paymentStatus = request.getParameter("paymentStatus");

        // PaymentVo 객체 생성
        PaymentVo vo = new PaymentVo();
        vo.setPaymentId(paymentId);
        vo.setUserId(userId);
        vo.setOrderId(orderId);
        vo.setAmount(amount);
        vo.setPaymentMethod(paymentMethod);
        vo.setPaymentStatus(paymentStatus);
        vo.setPaymentDate(new Timestamp(System.currentTimeMillis()));

        // PaymentDao를 통해 결제 정보 저장
        PaymentDao paymentDao = new PaymentDao();
        boolean isSaved = paymentDao.savePayment(vo);

        // 저장 결과에 따라 응답 처리
        if (isSaved) {
            request.setAttribute("message", "결제 정보가 성공적으로 저장되었습니다.");
        } else {
            request.setAttribute("message", "결제 정보 저장에 실패했습니다.");
        }

        // 결과 페이지로 포워딩
        request.getRequestDispatcher("/adminpange/paymentResult.jsp").forward(request, response);
    }
}
