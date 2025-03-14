package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;
import Model.PostVo;

public class ProductEditService implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("user");

		if (loginUser == null) {
			response.sendRedirect("/member/login.do");
			return;
		}

		String userId = loginUser.getUserid();
		String productIdParam = request.getParameter("productid");

		if (productIdParam == null || productIdParam.isEmpty()) {
			response.sendRedirect("/post/mysellinglist.do");
			return;
		}

		int productId = Integer.parseInt(productIdParam);
		PostDao dao = new PostDao();

		// 특정 상품 정보 조회
		PostVo product = dao.getPostDetail(productId);

		if (product == null) {
			response.sendRedirect("/post/mysellinglist.do");
			return;
		}

		request.setAttribute("product", product);
		request.getRequestDispatcher("/posts/productedit.jsp").forward(request, response);

	}
}
