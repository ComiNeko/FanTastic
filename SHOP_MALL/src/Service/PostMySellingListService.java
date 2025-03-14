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

public class PostMySellingListService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("user");

        if (loginUser == null) {
            response.sendRedirect("/member/login.do"); // 로그인 안 한 경우 로그인 페이지로 이동
            return; // sendRedirect() 이후 코드 실행 방지
        }

        String userId = loginUser.getUserid();
        PostDao dao = new PostDao();
        
        // 로그인한 사용자의 상품만 가져오기
        List<PostVo> productList = dao.getMyProductList(userId);

        if (productList == null || productList.isEmpty()) {
            System.out.println("등록된 상품 없음.");
            request.setAttribute("productList", null);
        } else {
            System.out.println("등록된 상품 수: " + productList.size());
            request.setAttribute("productList", productList);
        }
        
    }
}
