package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.PostDao;
import Model.PostVo;

public class PostCartService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userId = (session.getAttribute("user") != null) ? (String) session.getAttribute("user") : null;

        // 사용자가 로그인하지 않았을 경우 로그인 페이지로 이동
        if (userId == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        PostDao dao = new PostDao();
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            // 장바구니 목록 조회
            List<PostVo> cartList = dao.getCartList(userId);
            request.setAttribute("cartList", cartList);
            request.getRequestDispatcher("/posts/postcart.jsp").forward(request, response);

        } else if (action.equals("add")) {
            // 장바구니에 상품 추가
            String productId = request.getParameter("productid");
            if (productId != null) {
                dao.addToCart(userId, Integer.parseInt(productId), 1); // 기본 수량 1
                response.sendRedirect("/postcart.do"); // 장바구니 페이지로 이동
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }

        } else if (action.equals("remove")) {
            // 장바구니에서 상품 삭제
            String cartId = request.getParameter("cartid");
            if (cartId != null) {
                dao.removeFromCart(Integer.parseInt(cartId));
                response.sendRedirect("/postcart.do"); // 삭제 후 장바구니 페이지로 이동
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
