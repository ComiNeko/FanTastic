package Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.MemberPaymentView;
import Service.PaymentSaveService;
import Service.PaymentService;

import java.io.IOException;

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
		request.setCharacterEncoding("utf-8");
		String action = request.getPathInfo();
		HttpSession session = request.getSession(false);
		
		System.out.println("payment_action = " + action);
	    System.out.println("QueryString: " + request.getQueryString()); // 쿼리스트링 확인
	    System.out.println("Full URL: " + request.getRequestURL().toString()); // 전체 URL 확인
	    
		switch (action) {
		case "/payment.do":
			System.out.println("상품 정보 파라미터 확인:");
            System.out.println("productId = " + request.getParameter("productId"));
            System.out.println("productName = " + request.getParameter("productName"));
            System.out.println("productPrice = " + request.getParameter("productPrice"));
            System.out.println("productQuantity = " + request.getParameter("productQuantity"));

			new PaymentService().doCommand(request, response);
			return;
			
		case "/save.do":
			// 결제 정보 저장 요청 처리
            new PaymentSaveService().doCommand(request, response);
            return;
            
         // 마이페이지: 메인화면에 최근 주문 내역 1건 띄우기
		case "/mypayment.do":
		    if (session == null || session.getAttribute("user") == null) {
		        response.sendRedirect(request.getContextPath() + "/member/login.do");
		        return;
		    }
		    new MemberPaymentView().doCommand(request, response);
		    return;
		}
	}
}