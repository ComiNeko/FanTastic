package Service;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;

public class FavoriteAdd implements Command {
    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            out.print("{\"result\":\"fail\", \"message\":\"로그인이 필요합니다.\"}");
            out.flush();
            return;
        }

        String userId = user.getUserid();
        String productIdStr = request.getParameter("productId");

        if (productIdStr == null || productIdStr.isEmpty()) {
            out.print("{\"result\":\"fail\", \"message\":\"상품 ID가 없습니다.\"}");
            out.flush();
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            out.print("{\"result\":\"fail\", \"message\":\"잘못된 상품 ID입니다.\"}");
            out.flush();
            return;
        }

        System.out.println("찜하기 요청: userId=" + userId + ", productId=" + productId);

        PostDao dao = new PostDao();
        try {
            boolean success = dao.addToFavorite(userId, productId);
            if (success) {
                out.print("{\"result\":\"success\", \"message\":\"찜 추가 성공!\"}");
            } else {
                out.print("{\"result\":\"fail\", \"message\":\"이미 찜한 상품이거나 데이터베이스 오류입니다.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"result\":\"fail\", \"message\":\"서버 오류 발생!\"}");
        } finally {
            out.flush();
        }
    }
}
