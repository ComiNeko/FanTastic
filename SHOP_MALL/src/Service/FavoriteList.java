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

public class FavoriteList implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        String userId = user.getUserid();
        int categoryId = 0;
        String categoryParam = request.getParameter("categoryId");
        if (categoryParam != null && !categoryParam.isEmpty()) {
            categoryId = Integer.parseInt(categoryParam);
        }

        int page = 1;
        int pageSize = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception e) { }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (Exception e) { }

        PostDao dao = new PostDao();
        List<PostVo> favoriteList = dao.getFavoriteListByCategory(userId, categoryId, page, pageSize);
        request.setAttribute("favoriteList", favoriteList);
        
        // Ajax 호출 시 목록 프래그먼트만 반환 (favoriteListFragment.jsp)
        request.getRequestDispatcher("/posts/postfavoriteFragment.jsp").forward(request, response);
    
        
    }
}