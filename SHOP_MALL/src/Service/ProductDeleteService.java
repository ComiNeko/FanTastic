package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.CreatorDao;

public class ProductDeleteService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		
//		request.setCharacterEncoding("UTF-8"); // 인코딩 설정 
//		int productId = Integer.parseInt(request.getParameter("productid")); // 삭제할 상품 ID
//        HttpSession session = request.getSession();
//        int loginAuthorId = (int) session.getAttribute("authorid"); // 로그인한 작가 ID
//
//        CreatorDao dao = new CreatorDao();
//        int productAuthorId = dao.getAuthorIdByProduct(productId); // 상품의 등록 작가 ID 가져오기
//
//        // 본인 확인
//        if (loginAuthorId == productAuthorId) {
//            dao.deleteProduct(productId); // 상품 삭제
//            response.sendRedirect("/post/creatordetail.do?authorid=" + loginAuthorId); // 본인 페이지로
//        } else {
//            response.getWriter().println("<script>alert('삭제 권한이 없습니다.'); history.back();</script>");
//        }
	}

}
