package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;
import Model.PostVo;

public class ProductUpdateService implements Command {
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
        int productId = Integer.parseInt(request.getParameter("productid"));
        String productName = request.getParameter("productName");
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
        int productStock = Integer.parseInt(request.getParameter("productStock"));
        String productInfo = request.getParameter("productInfo");
        String productImage = request.getParameter("productImage");

        PostDao dao = new PostDao();

        if (!dao.isUserProductOwner(productId, userId)) {
            response.getWriter().write("<script>alert('본인 상품만 수정할 수 있습니다.'); location.href='/post/mysellinglist.do';</script>");
            return;
        }

        PostVo vo = new PostVo();
        vo.setProductid(productId);
        vo.setProductName(productName);
        vo.setProductPrice(productPrice);
        vo.setProductStock(productStock);
        vo.setProductInfo(productInfo);
        vo.setProductImage(productImage);

        boolean result = dao.updateMyProduct(vo, userId);
        response.sendRedirect(result ? "/post/mysellinglist.do" : "/post/productedit.do?productid=" + productId);
    }
}
