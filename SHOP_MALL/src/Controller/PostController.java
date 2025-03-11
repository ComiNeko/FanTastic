package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.CreatorDetailService;
import Service.CreatorService;
import Service.PostCartService;
import Service.PostSellingService;
import Service.PostWriteService;

@WebServlet("/post/*")
@MultipartConfig(
fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1004 * 1024 *50 // 50MB
)
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
			    return; // 여기까지만 하면 끝
			    
			case "/ptwrite.do": // 글쓰기 페이지 이동
			    page = "/posts/postwrite.jsp"; // 글쓰기 폼
			    break;
			    
			case "/ptwritepro.do": // 글을 적고 나서 제출(등록) 할 때 호출하는 주소
				new PostWriteService().doCommand(request, response);
				response.sendRedirect("/post/postsellinglist.do"); // 글 등록 후 상품 목록으로 이동
				return;

			case "/postsellinglist.do": // 상품 목록 조회
				new PostSellingService().doCommand(request, response);
				page = "/posts/postsellinglist.jsp";
				break;
				
			case "/creatorlist.do": // 작가 리스트 페이지
			    new CreatorService().doCommand(request, response); 
			    return;
			    
			case "/creatordetail.do": // 작가 상세 페이지
			    new CreatorDetailService().doCommand(request, response);
			    return;
		}

		// 페이지 이동 처리
		if (page != null) {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
