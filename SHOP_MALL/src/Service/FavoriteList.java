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

        // 페이지당 6개씩 출력하도록 변경
        int page = 1, pageSize = 6;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch(Exception e) { }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch(Exception e) { }

        PostDao dao = new PostDao();
        List<PostVo> favoriteList = dao.getFavoriteListByCategory(userId, categoryId, page, pageSize);
        int totalResults = dao.getFavoriteCount(userId, categoryId);
        int totalPages = (int)Math.ceil((double)totalResults / pageSize);

        // 페이지 블럭 계산 (한 블럭에 3페이지씩 표시)
        int pageBlock = 3;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = Math.min(startPage + pageBlock - 1, totalPages);

        request.setAttribute("favoriteList", favoriteList);
        request.setAttribute("totalResults", totalResults);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("categoryId", categoryId);

        // JSP로 포워드 (전체 페이지 새로고침 방식)
        request.getRequestDispatcher("/posts/postfavorite.jsp").forward(request, response);
    
        
    }
}