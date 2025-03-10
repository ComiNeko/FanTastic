package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.PostDao;
import Model.PostVo;

public class PostSellingService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//category 파라미터 가져오기
		String category = request.getParameter("category"); // category 파라미터 가져오기
        int categoryId = (category != null && !category.isEmpty()) ? Integer.parseInt(category) : -1;

		PostDao dao = new PostDao();
		List<PostVo> productList = dao.getSelect();
		
		if (categoryId > 0) {
            // 특정 카테고리의 상품 목록 조회 (기존 DAO의 getPostsByCategory() 활용)
            productList = dao.getPostsByCategory(categoryId);
        } else {
            // 모든 상품 조회
            productList = dao.getSelect();
        }
		
	 // 조회된 상품 목록을 request에 저장 (JSP에서 사용할 수 있도록)
		request.setAttribute("category", category);
        request.setAttribute("productList", productList);
	}

}
