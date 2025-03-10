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

public class PostCartService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("user");
        String userId = loginUser.getUserid(); // MemberVo에 있는 userid 필드 가져오기

        // 사용자가 로그인하지 않았을 경우 로그인 페이지로 이동
        if (userId == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        PostDao dao = new PostDao();
        String action = request.getParameter("action");
        System.out.println("PostCartService action: " + action); // ✅ 디버깅용 로그

        if (action == null || action.equals("list")) {
            // 장바구니 목록 조회
            List<PostVo> cartList = dao.getCartList(userId);
            request.setAttribute("cartList", cartList);
            request.getRequestDispatcher("/posts/postcart.jsp").forward(request, response);

        } else if (action.equals("add")) {
            // 장바구니에 상품 추가
            String productId = request.getParameter("productid");
            
            // ✅ 여기 두 줄 추가 (디버깅용)
            System.out.println("현재 로그인된 사용자 ID: " + userId); 
            System.out.println("장바구니 추가 요청 들어옴. productId = " + productId); // ✅ 디버깅용 로그

            if (productId != null) {
                dao.addToCart(userId, Integer.parseInt(productId), 1); // 기본 수량 1
                response.setStatus(HttpServletResponse.SC_OK); // 성공 응답
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 요청
            }

        } else if (action.equals("remove")) {
            // 장바구니에서 상품 삭제
            String cartId = request.getParameter("cartid");
            if (cartId != null) {
                dao.removeFromCart(Integer.parseInt(cartId));
                response.sendRedirect("/post/postcart.do"); // 삭제 후 장바구니 페이지로 이동
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
