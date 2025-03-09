package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.PostSellingService;
import Service.PostWriteService;

@WebServlet("/post/*")
public class PostController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public PostController() {
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
		System.out.println("action = " + action);
		String page = null;

		// 🔹 로그인 여부 체크
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("/member/login.do"); // 로그인 안 되어 있으면 로그인 페이지로 이동
			return;
		}

		switch (action) {
		case "":
			page = "/posts/write.jsp";
			break;
		case "/ptwritepro.do":
			new PostWriteService().doCommand(request, response);
			response.sendRedirect("/post/postsellinglist.do");
			// 글 등록 후 상품 목록으로 이동
			return;
		// 상품 목록 조회 (PostSellingService 호출)
		case "/postsellinglist.do":
			new PostSellingService().doCommand(request, response);
			page = "/posts/postselling.jsp"; // 상품 목록 JSP로 이동
			break;

		}

		if (page != null) {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
