package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model.MemberVo;
import Model.PostDao;

public class FavoriteRenameFolder implements Command {

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
        int folderId = Integer.parseInt(request.getParameter("folderId"));
        String folderName = request.getParameter("folderName");
        
        PostDao dao = new PostDao();
        boolean result = dao.updateFavoriteFolderName(userId, folderId, folderName);
        response.setContentType("text/plain; charset=utf-8");
        response.getWriter().write(result ? "OK" : "FAIL");

	}

}
