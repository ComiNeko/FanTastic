package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;
import Model.PostVo;

public class ProductEditService implements Command {
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
        PostDao dao = new PostDao();

        if (!dao.isUserProductOwner(productId, userId)) {
            response.sendRedirect("/post/mysellinglist.do");
            return;
        }

        PostVo product = dao.getPostDetail(productId);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/posts/productedit.jsp").forward(request, response);
    }
}
