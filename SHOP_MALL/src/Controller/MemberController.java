package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.EmailService;
import Service.MainService;
import Service.MemberLogin;
import Service.MemberLogout;
import Service.MemberUserIdCheck;
import Service.MemberUserSave;

@WebServlet("/member/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberController() {
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
		System.out.println("member_action = " + action);
		String page = null;
		HttpSession session = request.getSession();

		switch (action) {
		case "/signup.do":
			new MainService().doCommand(request, response);
			page = "/mem/signup.jsp";
			break;
		
		case "/sendEmail.do":
            String email = request.getParameter("email");
            EmailService emailService = new EmailService();
            String code = emailService.sendEmail(email);

            if (code != null) {
                // 인증 코드를 세션에 저장 (나중에 인증 확인 시 비교)
                session.setAttribute("emailAuthCode", code);
                response.getWriter().println("이메일 전송 완료");
            } else {
                response.getWriter().println("이메일 전송 실패");
            }
            return; // 페이지 이동 없이 AJAX 응답
            
        case "/verifyEmailCode.do":
            String inputCode = request.getParameter("emailCode");
            String sessionCode = (String) session.getAttribute("emailAuthCode");

            if (sessionCode != null && sessionCode.equals(inputCode)) {
                response.getWriter().println("인증 성공");
            } else {
                response.getWriter().println("인증 실패");
            }
            return;
			
        case "/useridcheck.do":
            // 아이디 중복 체크 (AJAX 요청)
            new MemberUserIdCheck().doCommand(request, response);
            page=null;
			break;
			
        case "/signuppro.do":
            new MemberUserSave().doCommand(request, response);
            response.sendRedirect("/");  // 성공페이지를 만들 것인가, response.sendRedirect("/mem/signupSuccess.jsp");
            return;	//NOPE 안 만들 거임!
			
			
		case "/login.do":
			page = "/mem/login.jsp";
			break;
			
		case "/loginpro.do":
			new MemberLogin().doCommand(request, response);
			return;
		case "/logout.do":
			new MemberLogout().doCommand(request, response);
			response.sendRedirect("/");
			return;	
            
	} //switch
			
		
		if(page!=null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
