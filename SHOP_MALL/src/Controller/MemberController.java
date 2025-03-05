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
import Service.MemberUserUpdate;

@WebServlet("/member/*")

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
		HttpSession session = request.getSession(false);

		switch (action) {
		case "/signup.do":
			new MainService().doCommand(request, response);
			page = "/mem/signup.jsp";
			break;
		
		 case "/sendEmail.do":
			 String email = request.getParameter("email");

			    EmailService emailService = new EmailService();
			    String authCode = emailService.sendEmail(email);

			    if (authCode != null) {
			        response.getWriter().println(authCode); // 인증 코드 반환 (세션 저장 X)
			    } else {
			        response.getWriter().println("이메일 전송 실패");
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
			
	//_________________________________________________________________________________________________//	
										
											

			// 정보수정
			case "/updateMyInfo.do":
	        if(session == null || session.getAttribute("user") == null) {
	            response.sendRedirect(request.getContextPath() + "/member/login.do");
	            return;
	        }
	        page = "/mem/UpdateMyInfo.jsp";
	        break;
	        
			case "/updateMyInfopro.do":
			    new MemberUserUpdate().doCommand(request, response);
			    response.sendRedirect(request.getContextPath() + "/member/mypage.do");
			    return;
	            
	} //switch
			
		
		if(page!=null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
