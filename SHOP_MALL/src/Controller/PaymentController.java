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
		System.out.println("payment_action = " + action);
		String page = null;
		HttpSession session = request.getSession(false);

		switch (action) {
		case "/payment.do":

			String productId = request.getParameter("productId");
			String productName = request.getParameter("productName");
			String productPrice = request.getParameter("productPrice");

			// 로그 출력
			System.out.println("Received Product ID: " + productId);
			System.out.println("Received Product Name: " + productName);
			System.out.println("Received Product Price: " + productPrice);

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
		

		if (page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}

	}
}