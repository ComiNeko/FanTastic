package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.AuthorCheckService;
import Service.AuthorInsertService;
import Service.EmailService;
import Service.MainService;
import Service.MemberFindId;
import Service.MemberFindIdCode;
import Service.MemberFindPwCode;
import Service.MemberFindPwEmail;
import Service.MemberFindPwId;
import Service.MemberFindPwToken;
import Service.MemberLogin;
import Service.MemberLogout;
import Service.MemberResetPw;
import Service.MemberUserIdCheck;
import Service.MemberUserUpdatePw;
import Service.MemberUserSave;
import Service.MemberUserUpdate;

@WebServlet("/member/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1004 * 1024 * 50 // 50MB
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
			page = null;
			break;

		case "/signuppro.do":
			new MemberUserSave().doCommand(request, response);
			response.sendRedirect("/"); // 성공페이지를 만들 것인가, response.sendRedirect("/mem/signupSuccess.jsp");
			return; // NOPE 안 만들 거임!

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

		case "/findidpw.do":
			page = "/mem/FindIDPW.jsp";
			break;

		case "/findId.do":
			new MainService().doCommand(request, response);
			page = "/mem/findid.jsp";
			break;

		case "/findIdProcess.do":
			new MemberFindId().doCommand(request, response);
			return;

		case "/verifyEmail.do":
			new MemberFindIdCode().doCommand(request, response);
			return;

		case "/findPw.do":
			page = "/mem/findpw.jsp";
			break;

		case "/findPwId.do":
			new MemberFindPwId().doCommand(request, response);
			return;
		case "/findPwEmail.do":
			new MemberFindPwEmail().doCommand(request, response);
			return;
		case "/findPwCode.do":
			new MemberFindPwCode().doCommand(request, response);
			return;
		case "/findPwToken.do":
			new MemberFindPwToken().doCommand(request, response);
			return;
		case "/resetPw.do":
			new MemberResetPw().doCommand(request, response);
			return;
		default:
			break;

		case "/mypage.do":
			if (session == null || session.getAttribute("user") == null) {
				response.sendRedirect(request.getContextPath() + "/member/login.do");
				return;
			}
			page = "/mem/mypage.jsp";
			break;

		// 회원정보 수정 페이지 요청: 수정 폼을 보여줌
		case "/updateMyInfo.do":
			if (session == null || session.getAttribute("user") == null) {
				response.sendRedirect(request.getContextPath() + "/member/login.do");
				return;
			}
			page = "/mem/UpdateMyInfo.jsp";
			break;

		case "/updateMyInfopro.do":
			new MemberUserUpdate().doCommand(request, response);
			page = "/mem/UpdateMyInfo.jsp";
			break;

			
			// 현재 비밀번호 확인을 위한 페이지 이동
		case "/updatecheck.do":
		    page = "/mem/UpdateMyCheck.jsp";
		    break;	
		 // 현재 비밀번호 확인 요청 처리
		case "/updatecheckPw.do":
		    new MemberUserIdCheck().doCommand(request, response);
		    return;
			
		// 비밀번호 수정 페이지 요청: UpdateMyPw.jsp로 이동
		case "/updateMyPw.do":
			// 세션에 isPwdVerified 플래그가 있는지 확인하고, 없으면 다시 현재 비밀번호 페이지로 이동하도록 처리
		    if (session == null || session.getAttribute("isPwdVerified") == null) {
		        response.sendRedirect(request.getContextPath() + "/member/updateCurrentPassword.do");
		        return;
		    }
			break;

		case "/updateMyPwPro.do":
			new MemberUserUpdatePw().doCommand(request, response);
			page = "/mem/UpdateMyPw.jsp";
			break;

		case "/authorinsert.do": // 작가 등록 폼 이동
		    if (session == null || session.getAttribute("user") == null) {
		        response.sendRedirect(request.getContextPath() + "/member/login.do");
		        return;
		    }
		    new AuthorCheckService().doCommand(request, response);
		    return; // 서비스에서 다 처리하므로 리턴

		case "/authorinsertpro.do": // 작가 등록 처리
		    new AuthorInsertService().doCommand(request, response);
		    response.sendRedirect("/member/mypage.do"); // 등록 후 마이페이지
		    return;
		    
		    
		case "/faq.do" :
			page = "/mem/Fap.jsp";
			break;

		} // switch

		if (page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
