package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.PaymentVo;
import util.PaymentUtil;

@WebServlet("/payment/*")
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PaymentController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo(); // 요청 URL에서 액션을 가져옴

        if (action.equals("/processPayment")) {
            processPayment(request, response);
        } else {
            // 다른 액션 처리
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404 오류 처리
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터 가져오기
        String userId = request.getParameter("userId");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String paymentMethod = request.getParameter("paymentMethod");

        // PaymentVo 객체 생성
        PaymentVo payment = new PaymentVo();
        payment.setUserId(userId);
        payment.setOrderId(orderId);
        payment.setPaymentMethod(paymentMethod);

        // Payment 처리
        boolean success = PaymentUtil.processPayment(payment);

        // 결과에 따라 다른 JSP 페이지로 포워딩
        if (success) {
        	response.sendRedirect(request.getContextPath() + "/index.jsp?message=Payment completed successfully.");
        } else {
            request.setAttribute("message", "Payment failed.");
            request.getRequestDispatcher("/adminpage/payments.jsp").forward(request, response);
        }
    }
}
