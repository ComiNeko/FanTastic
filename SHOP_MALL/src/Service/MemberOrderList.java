package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.MemberVo;
import Model.PaymentDao;
import Model.PostVo;

public class MemberOrderList implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		 HttpSession session = request.getSession(false);

	      
	        MemberVo member = (MemberVo) session.getAttribute("user");
	        String userId = member.getUserid();  // 또는 member.getUserId(), 정확한 메서드명에 맞게 사용
System.out.println("구매이력 조회 요청한 사용자 ID: " + userId);

	        PaymentDao dao = new PaymentDao();

	        // 전체 주문 목록 조회 (리스트 가져오기)
	        List<PostVo> orderList = dao.getOrderListByUserId(userId);

	        // JSP에 데이터 전달
	        request.setAttribute("orderList", orderList);

	        // 구매 이력 페이지로 이동
	        request.getRequestDispatcher("/mem/myorderlist.jsp").forward(request, response);

	}

}
