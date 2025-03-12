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
        MemberVo mvo = (MemberVo) session.getAttribute("user");

        if (mvo == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        String userId = mvo.getUserid();
        String categoryParam = request.getParameter("categoryId");
        int categoryId = (categoryParam != null && !categoryParam.isEmpty()) ? Integer.parseInt(categoryParam) : 0;

        String folderParam = request.getParameter("folderId");
        int folderId = (folderParam != null && !folderParam.isEmpty()) ? Integer.parseInt(folderParam) : 0;

        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");
        int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int pageSize = (pageSizeParam != null && !pageSizeParam.isEmpty()) ? Integer.parseInt(pageSizeParam) : 10;

        PostDao dao = new PostDao();
        List<PostVo> favoriteList;

        if (folderId > 0) {
            favoriteList = dao.getFavoriteListByFolder(userId, folderId, page, pageSize);
        } else {
            favoriteList = dao.getFavoriteListByCategory(userId, categoryId, page, pageSize);
        }

        request.setAttribute("favoriteList", favoriteList);

        // 폴더 리스트도 추가 (사이드바나 모달에 필요하면)
        List<PostVo> folderList = dao.getFolderList(userId);
        request.setAttribute("folderList", folderList);
    

    }
}
