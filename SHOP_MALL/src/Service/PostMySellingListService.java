package Service;

import java.io.IOException;
import java.util.ArrayList;
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
            response.sendRedirect("/member/login.do");
            return;
        }

        String userId = loginUser.getUserid();
        PostDao dao = new PostDao();
        List<PostVo> productList = dao.getMyProductList(userId);

        if (productList == null || productList.isEmpty()) {
            System.out.println("상품 없음: productList가 비어 있음.");
            request.setAttribute("productList", new ArrayList<>()); // ✅ 올바른 문법
        } else {
            System.out.println("상품 있음: " + productList.size() + "개");
            request.setAttribute("productList", productList);
        }
    }
}
