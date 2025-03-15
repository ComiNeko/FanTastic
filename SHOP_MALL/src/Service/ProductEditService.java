package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;
import Model.PostVo;
import Model.CategoryDao;
import Model.CategoryVo;

public class ProductEditService implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 상품 수정 화면(productedit.jsp)으로 이동할 때 사용되는 서비스
		// 마이페이지->상품 수정하기->수정하기 버튼 누를 때

		HttpSession session = request.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("user");

		if (loginUser == null) {
			response.sendRedirect("/member/login.do");
			return;
		}

		String productIdParam = request.getParameter("productid");

		if (productIdParam == null || productIdParam.isEmpty()) {
			response.sendRedirect("/post/mysellinglist.do");
			return;
		}

		int productId = Integer.parseInt(productIdParam);
		PostDao dao = new PostDao();
		PostVo product = dao.getPostDetail(productId);

		if (product == null) {
			response.sendRedirect("/post/mysellinglist.do");
			return;
		}

		// 카테고리 목록 가져오기
		CategoryDao categoryDao = new CategoryDao();
		List<CategoryVo> categoryList = categoryDao.getAllCategories();

		request.setAttribute("product", product);
		request.setAttribute("categoryList", categoryList);
		request.getRequestDispatcher("/posts/productedit.jsp").forward(request, response);
	}
}
