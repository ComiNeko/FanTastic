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
            response.sendRedirect("/member/login.do");
            return;
        }

        String userId = loginUser.getUserid(); // 로그인된 사용자 ID
        PostDao dao = new PostDao();
        List<PostVo> myProductList = dao.getMyProductList(userId); // 내가 등록한 상품 조회

        request.setAttribute("myProductList", myProductList);
        request.getRequestDispatcher("/posts/postmysellinglist.jsp").forward(request, response);
    }
}
