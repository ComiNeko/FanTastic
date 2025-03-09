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
		
		
		PostDao dao = new PostDao();
		List<PostVo> productList = dao.getSelect();
		
		 // 조회된 상품 목록을 request에 저장 (JSP에서 사용할 수 있도록)
        request.setAttribute("productList", productList);
	}

}
