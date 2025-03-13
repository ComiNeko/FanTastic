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
        // 단일 또는 여러 productId 파라미터 수신 (예: checkbox 선택)
        String[] productIds = request.getParameterValues("productId");
        PostDao dao = new PostDao();
        if (productIds != null && productIds.length > 0) {
            for (String pidStr : productIds) {
                int productId = Integer.parseInt(pidStr);
                dao.removeFromFavorite(userId, productId);
            }
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}
