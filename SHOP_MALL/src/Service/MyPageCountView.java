package Service;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.MemberVo;
import Model.PostDao;


public class MyPageCountView implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		 HttpSession session = request.getSession(false);
	        if (session == null) return;

	        MemberVo user = (MemberVo) session.getAttribute("user");
	        if (user == null) return;

	        PostDao dao = new PostDao();
	        int count = dao.countFavoritesByUser(user.getUserid());

	        // session에 담아두기
	        session.setAttribute("favoriteCount", count);
	    }
	

}
