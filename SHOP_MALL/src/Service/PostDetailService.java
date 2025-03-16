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
import Model.ReviewDao;
import Model.ReviewVo;

public class PostDetailService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		int productid = Integer.parseInt(request.getParameter("productid"));

        // 상품 상세 조회
        PostDao dao = new PostDao();
        PostVo vo = dao.getPostDetail(productid);

        // 리뷰 리스트 조회
        ReviewDao reviewdao = new ReviewDao();
        List<ReviewVo> reviewList = reviewdao.getReviews(productid);

        // request에 저장
        request.setAttribute("post", vo); // 상품 정보
        request.setAttribute("reviewList", reviewList); // 리뷰 목록

        
        //최근 본 상품 등록
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {

            MemberVo user = (MemberVo) session.getAttribute("user");
            String userid = user.getUserid();

            MemberRecentView recentViewService = new MemberRecentView();
            recentViewService.addRecentView(userid, productid); 
        }

	}

}
