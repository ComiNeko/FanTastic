package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;

public class FavoriteRemove implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("user");
        if (loginUser == null) {
            response.sendRedirect("/member/login.do");
            return;
        }
        String userId = loginUser.getUserid();
        int productId = Integer.parseInt(request.getParameter("productId"));
        String folderParam = request.getParameter("folderId");
        Integer folderId = (folderParam == null || folderParam.equals("0")) ? null : Integer.parseInt(folderParam);
        
        PostDao dao = new PostDao();
        dao.removeFromFavorite(userId, productId, folderId);
        response.getWriter().write("success");
    }
}
