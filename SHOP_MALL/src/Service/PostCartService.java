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
        String userId = loginUser.getUserid(); // 로그인 유저 ID

        if (userId == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        PostDao dao = new PostDao();
        String action = request.getParameter("action");
        System.out.println("PostCartService action: " + action);

        try {
            if (action == null || action.equals("list")) {
                // 장바구니 목록 조회
                List<PostVo> cartList = dao.getCartList(userId);
                request.setAttribute("cartList", cartList);
                request.getRequestDispatcher("/posts/postcart.jsp").forward(request, response);

            } else if (action.equals("add")) {
                // 장바구니 상품 추가 (중복 시 수량 +1)
                String productId = request.getParameter("productid");

                if (productId != null) {
                    dao.addToCart(userId, Integer.parseInt(productId), 1); // 기본 수량 1 추가
                    response.setContentType("text/plain; charset=UTF-8"); // 한글 메시지 깨지지 않게
                    response.getWriter().write("장바구니에 추가되었습니다!");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("상품 ID가 없습니다.");
                }

            } else if (action.equals("remove")) {
                // 장바구니 상품 삭제
                String productId = request.getParameter("productid"); // ✅ productid로 받기
                System.out.println("삭제할 상품 ID: " + productId); // 콘솔 확인

                if (productId != null) {
                    dao.removeFromCart(userId, Integer.parseInt(productId)); // ✅ productid로 삭제
                    response.setContentType("text/plain; charset=UTF-8");
                    response.getWriter().write("장바구니에서 삭제되었습니다.");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("상품 ID가 없습니다.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("서버 오류 발생");
        }
    }
}
