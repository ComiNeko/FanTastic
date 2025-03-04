package Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.PostDao;
import Model.PostVo;

public class PostWriteService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		int productid = Integer.parseInt(request.getParameter("productid"));//상품 ID (기본 키)
		int categoryid = Integer.parseInt(request.getParameter("categoryid"));//카테고리 ID (외래 키, NOT NULL)
		int authorid = Integer.parseInt(request.getParameter("authorid"));//작가 ID (외래 키, NOT NULL)
		String productName = request.getParameter("productName");//상품 이름 (NOT NULL)
		int productPrice = Integer.parseInt(request.getParameter("productPrice")); //상품 가격 (NOT NULL)
		int productStock = Integer.parseInt(request.getParameter("productStock")); //상품 재고 (NOT NULL)
		String productInfo = request.getParameter("productInfo");//상품 정보
		String productImage = request.getParameter("productImage");//상품 이미지
		
		// 첨부파일 처리
		String savedFileName = null;
		javax.servlet.http.Part imgfile = request.getPart("productImage");

		if (imgfile != null && imgfile.getSize() > 0) {
			String originalFileName = imgfile.getSubmittedFileName();
			savedFileName = UUID.randomUUID().toString() + "_" + originalFileName; // 파일명 변경

			String uploadPath = request.getServletContext().getRealPath("") + "uploads";
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			String filePath = uploadPath + File.separator + savedFileName;
			imgfile.write(filePath); // 실제 파일 저장
		}
		
		// VO에 데이터 저장
		PostVo vo = new PostVo();
		vo.setProductid(productid);
		vo.setCategoryid(categoryid);
		vo.setAuthorid(authorid);
		vo.setProductName(productName);
		vo.setProductPrice(productPrice);
		vo.setProductStock(productStock);
		vo.setProductInfo(productInfo);
		vo.setProductImage(productImage);
		
		// DAO 호출
		PostDao dao = new PostDao();
		dao.postInsert(vo);
		

	}//@Override

}//Command
