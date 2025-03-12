package Service;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;

public class FavoriteMoveFolder implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("user");
        if(loginUser == null) {
            response.sendRedirect("/member/login.do");
            return;
        }
        String userId = loginUser.getUserid();
        int targetFolderId = Integer.parseInt(request.getParameter("folderId"));
        String[] productIds = request.getParameterValues("productId");
        Integer folderId = (targetFolderId == 0) ? null : targetFolderId;
        
        PostDao dao = new PostDao();
        dao.moveFavoritesToFolder(userId, productIds, folderId);
        response.getWriter().write("success");

	}

}
