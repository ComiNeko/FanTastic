package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.MemberVo;
import Model.PaymentDao;
import Model.PostVo;

public class MemberPaymentView implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/member/login.do");
			return;
		}

		// ❗ 수정 부분 (MyPageCountView 방식으로 동일하게 수정)
		MemberVo user = (MemberVo) session.getAttribute("user");
		String userId = user.getUserid();  // 이제 진짜 userId 값!

		System.out.println("[MemberPaymentView] 세션 유저 아이디: " + userId);

		PaymentDao dao = new PaymentDao();
		PostVo recentOrder = dao.getRecentOrderByUserId(userId);

		if (recentOrder != null) {
			System.out.println("[MemberPaymentView] 최근 주문 있음: " + recentOrder.getProductName());
		} else {
			System.out.println("[MemberPaymentView] 최근 주문 없음");
		}

		request.setAttribute("recentOrder", recentOrder);

		
	}
}
