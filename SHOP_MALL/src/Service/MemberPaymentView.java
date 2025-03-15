package Service;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


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

	        String userId = (String) session.getAttribute("user");
	        System.out.println("세션 유저 아이디: " + userId);

	        PaymentDao dao = new PaymentDao();

	        PostVo recentOrder = dao.getRecentOrderByUserId(userId);

	        request.setAttribute("recentOrder", recentOrder);

	        // 포워딩 경로 확실하게!
	        request.getRequestDispatcher("/mem/mypage.jsp").forward(request, response);

	}

}
