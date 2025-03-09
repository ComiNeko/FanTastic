package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.PostCartService;
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

		// 로그인 체크: postsellinglist.do만 예외적으로 로그인 없이 접근 가능
		if (!"/postsellinglist.do".equals(action) && !"/postcart.do".equals(action)) {
			HttpSession session = request.getSession();
			if (session.getAttribute("user") == null) {
				response.sendRedirect("/member/login.do"); // 로그인 안 되어 있으면 로그인 페이지로 이동
				return;
			}
		}

		switch (action) {
			case "/addToCart.do": // 장바구니 추가
				new PostCartService().doCommand(request, response);
				return;

			case "/removeFromCart.do": // 장바구니에서 상품 삭제
				new PostCartService().doCommand(request, response);
				return;

			case "/postcart.do": // 장바구니 페이지 이동
				new PostCartService().doCommand(request, response);
				page = "/posts/postcart.jsp"; // 장바구니 페이지 이동
				break;

			case "/ptwritepro.do": // 글쓰기 처리
				new PostWriteService().doCommand(request, response);
				response.sendRedirect("/post/postsellinglist.do"); // 글 등록 후 상품 목록으로 이동
				return;

			case "/postsellinglist.do": // 상품 목록 조회
				new PostSellingService().doCommand(request, response);
				page = "/posts/postsellinglist.jsp";
				break;
		}

		// 페이지 이동 처리
		if (page != null) {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
