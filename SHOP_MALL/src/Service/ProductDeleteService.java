package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;

public class ProductDeleteService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("user");

        if (loginUser == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        String userId = loginUser.getUserid(); // 로그인한 사용자의 ID 가져오기
        String productIdParam = request.getParameter("productid");

        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("/post/mysellinglist.do");
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        PostDao dao = new PostDao();

        // 삭제 성공 여부 확인 후 처리
        boolean result = dao.deleteMyProduct(productId, userId);

        if (result) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('삭제가 완료되었습니다.'); location.href='/mypage.do';</script>");
        } else {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('본인 상품만 삭제할 수 있습니다.'); location.href='/post/mysellinglist.do';</script>");
        }
    }
}
