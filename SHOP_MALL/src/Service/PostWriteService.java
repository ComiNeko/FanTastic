package Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.PostDao;
import Model.PostVo;
import Model.MemberVo;

public class PostWriteService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 세션에서 로그인한 사용자 정보 가져오기
		HttpSession session = request.getSession();
		MemberVo user = (MemberVo) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("/member/login.do");
			return;
		}

		// 값이 null인지 로그 확인 (디버깅)
		System.out.println("categoryid: " + request.getParameter("categoryid"));
		System.out.println("productName: " + request.getParameter("productName"));
		System.out.println("productPrice: " + request.getParameter("productPrice"));
		System.out.println("productStock: " + request.getParameter("productStock"));
		System.out.println("productInfo: " + request.getParameter("productInfo"));
		// productImage 파라미터는 파일 업로드 처리로 대체됩니다.
		
		// categoryid가 null이면 기본값 설정 (예: 1)
		String categoryStr = request.getParameter("categoryid");
		int categoryid = (categoryStr != null && !categoryStr.isEmpty()) ? Integer.parseInt(categoryStr) : 1;

		String productName = request.getParameter("productName");
		int productPrice = Integer.parseInt(request.getParameter("productPrice"));
		int productStock = Integer.parseInt(request.getParameter("productStock"));
		String productInfo = request.getParameter("productInfo");
		int authorid = 1;

		// 첨부파일 처리
		javax.servlet.http.Part imgfile = request.getPart("productImage");
		String fileName = null;
		if (imgfile != null) {
			// 파일명을 UUID를 붙여서 고유하게 변경
			fileName = UUID.randomUUID().toString() + "_" + imgfile.getSubmittedFileName();
			System.out.println("fileName = " + fileName);

			// 업로드 경로 설정
			String uploadPath = request.getServletContext().getRealPath("") + "uploads";
			System.out.println("upload path = " + uploadPath);
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			String filePath = uploadPath + File.separator + fileName;
			// 파일을 실제 서버의 디스크에 저장
			imgfile.write(filePath);
		}

		// PostVo 객체 생성 후 값 설정
		PostVo vo = new PostVo();
		vo.setCategoryid(categoryid);
		vo.setAuthorid(authorid); // user id를 int로 변환
		vo.setProductName(productName);
		vo.setProductPrice(productPrice);
		vo.setProductStock(productStock);
		vo.setProductInfo(productInfo);
		
		vo.setProductImage("uploads/" + fileName); // 웹에서 접근 가능한 상대경로로 저장

		// DAO를 호출하여 DB에 저장
		PostDao dao = new PostDao();
		dao.postInsert(vo);
	}
}
