package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.ReviewDao;
import Model.ReviewVo;

public class ReviewService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8"); // 인코딩 설정 (중요)
	    
		// 파라미터로 넘어오는 값 받기
		String userid = request.getParameter("userid");
		int productid = Integer.parseInt(request.getParameter("productid"));
		int rating = Integer.parseInt(request.getParameter("rating"));
		String reviewText = request.getParameter("reviewText");

		// VO 세팅
		ReviewVo vo = new ReviewVo();
		vo.setUserid(userid);
		vo.setProductid(productid);
		vo.setRating(rating);
		vo.setReviewText(reviewText);

		// DAO 호출
		ReviewDao dao = new ReviewDao();
		int review = dao.insertReview(vo);

		// 결과 처리 (필요 시 성공/실패 로직 작성 가능)
		if (review > 0) {
			System.out.println("리뷰 등록 성공");
		} else {
			System.out.println("리뷰 등록 실패");
		}

		
	}

}
