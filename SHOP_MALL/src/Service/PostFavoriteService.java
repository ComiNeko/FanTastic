package Service;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import java.util.List;
import Model.MemberVo;
import Model.PostDao;
import Model.PostVo;

public class PostFavoriteService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
	        MemberVo loginUser = (MemberVo) session.getAttribute("user");
	        if(loginUser == null){
	            response.sendRedirect("/member/login.do");
	            return;
	        }
	        String userId = loginUser.getUserid();
	        PostDao dao = new PostDao();
	        String action = request.getParameter("action");
	        switch(action) {
            case "list": {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String folderParam = request.getParameter("folderId");
                // folderId "0" → 기본 폴더 → 처리 시 null
                Integer folderId = (folderParam == null || folderParam.equals("0")) ? null : Integer.parseInt(folderParam);
                int page = Integer.parseInt(request.getParameter("page"));
                int pageSize = Integer.parseInt(request.getParameter("pageSize"));
                List<PostVo> favoriteList = dao.getFavoriteListPaging(userId, categoryId, folderId, page, pageSize);
                String json = new Gson().toJson(favoriteList);
                response.setContentType("application/json; charset=utf-8");
                response.getWriter().write(json);
                return;
            }
            case "add": {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String folderParam = request.getParameter("folderId");
                Integer folderId = (folderParam == null || folderParam.equals("0")) ? null : Integer.parseInt(folderParam);
                dao.addToFavorite(userId, productId, folderId);
                response.getWriter().write("success");
                return;
            }
            case "remove": {
                int productId = Integer.parseInt(request.getParameter("productId"));
                String folderParam = request.getParameter("folderId");
                Integer folderId = (folderParam == null || folderParam.equals("0")) ? null : Integer.parseInt(folderParam);
                dao.removeFromFavorite(userId, productId, folderId);
                response.getWriter().write("success");
                return;
            }
            case "createFolder": {
                String folderName = request.getParameter("folderName");
                dao.createFavoriteFolder(userId, folderName);
                response.getWriter().write("success");
                return;
            }
            case "renameFolder": {
                int folderIdParam = Integer.parseInt(request.getParameter("folderId"));
                String folderName = request.getParameter("folderName");
                boolean result = dao.updateFavoriteFolderName(userId, folderIdParam, folderName);
                response.setContentType("text/plain; charset=utf-8");
                response.getWriter().write(result ? "OK" : "FAIL");
                return;
            }
            case "deleteFolder": {
                int folderIdParam = Integer.parseInt(request.getParameter("folderId"));
                boolean result = dao.deleteFavoriteFolder(userId, folderIdParam);
                response.setContentType("text/plain; charset=utf-8");
                response.getWriter().write(result ? "OK" : "FAIL");
                return;
            }
            default:
                break;
        }

	}

}
