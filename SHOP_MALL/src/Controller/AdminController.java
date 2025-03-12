package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.CreatorService;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String action = request.getPathInfo();
		System.out.println("admin_action = " + action);
		String page = null;
		HttpSession session = request.getSession(false);
		
		switch (action) {
		 case "/editProfile.do":
             new CreatorService().getAuthorProfile(request, response); // DB에서 데이터 가져오기
             request.getRequestDispatcher("/author/authorprofileedit.jsp").forward(request, response); // 폼 이동
             return;

         case "/updateProfile.do":
             new CreatorService().updateAuthorProfile(request, response); // DB 업데이트
             response.sendRedirect("/mypage.jsp"); // 마이페이지로 이동
             return;
		
		}
	}

}
