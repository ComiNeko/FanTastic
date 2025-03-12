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
        MemberVo loginUser = (MemberVo) session.getAttribute("user");

        if (loginUser == null) {
            out.print("{\"result\":\"fail\", \"message\":\"로그인이 필요합니다.\"}");
            out.flush();
            return;
        }

        String userId = loginUser.getUserid();

        String productIdStr = request.getParameter("productId");
        System.out.println("[FavoriteAdd] 받은 productId : " + productIdStr);
        if (productIdStr == null || productIdStr.isEmpty()) {
            out.print("{\"result\":\"fail\", \"message\":\"상품 ID가 없습니다.\"}");
            out.flush();
            return;
        }

        int productId = Integer.parseInt(productIdStr);

        PostDao dao = new PostDao();
       
        boolean isSuccess = dao.addToFavorite(userId, productId, null);

        if (isSuccess) {
            out.print("{\"result\":\"success\", \"message\":\"찜 추가 성공!\"}");
        } else {
            out.print("{\"result\":\"fail\", \"message\":\"찜 추가 실패!\"}");
        }
        out.flush();
    }
}
