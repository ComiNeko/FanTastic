package Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import Model.PostDao;
import Model.PostVo;
import Model.MemberVo;

public class ProductUpdateService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 상품 수정 폼 제출을 처리하는 서비스
		// 사용자가 수정한 내용을 받아서 DB 업데이트를 수행하는 서비스

		HttpSession session = request.getSession();
		MemberVo user = (MemberVo) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("/member/login.do");
			return;
		}

		int productId = Integer.parseInt(request.getParameter("productid"));
		String productName = request.getParameter("productName");
		int productPrice = Integer.parseInt(request.getParameter("productPrice"));
		int productStock = Integer.parseInt(request.getParameter("productStock"));
		String productInfo = request.getParameter("productInfo");
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));

		Part imgFile = request.getPart("productImage");
		String fileName = null;
		String imagePath = null;

		if (imgFile != null && imgFile.getSize() > 0) {
			fileName = UUID.randomUUID().toString() + "_" + imgFile.getSubmittedFileName();
			String uploadPath = request.getServletContext().getRealPath("/uploads");
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			String filePath = uploadPath + File.separator + fileName;
			imgFile.write(filePath);
			imagePath = "/uploads/" + fileName;
		} else {
			imagePath = request.getParameter("existingProductImage");
		}

		PostVo vo = new PostVo();
		vo.setProductid(productId);
		vo.setProductName(productName);
		vo.setProductPrice(productPrice);
		vo.setProductStock(productStock);
		vo.setProductInfo(productInfo);
		vo.setProductImage(imagePath);
		vo.setCategoryid(categoryId);

		PostDao dao = new PostDao();
		dao.updateProductWithCategory(vo); // 카테고리 포함해서 수정

		response.sendRedirect("/mypage.do");
	}
}
