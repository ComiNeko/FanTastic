package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberVo;
import util.PasswordUtil;

public class MemberUserUpdateCheck implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");

	        // 로그인 여부 확인
	        MemberVo sessionUser = (MemberVo) request.getSession().getAttribute("user");
	        if(sessionUser == null) {
	            request.setAttribute("errorMsg", "로그인이 필요합니다.");
	            request.getRequestDispatcher("/mem/UpdateMyCheck.jsp").forward(request, response);
	            return;
	        }
	        
	        // 파라미터 검증 (null 체크 후 trim)
	        String currentPwdParam = request.getParameter("currentPassword");
	        if(currentPwdParam == null || currentPwdParam.trim().isEmpty()){
	            request.setAttribute("errorMsg", "현재 비밀번호를 입력해 주세요.");
	            request.getRequestDispatcher("/mem/UpdateMyCheck.jsp").forward(request, response);
	            return;
	        }
	        String currentPwd = currentPwdParam.trim();
	        
	        // 비밀번호 검증 (암호화된 상태라면 PasswordUtil 사용)
	        if (!PasswordUtil.checkPassword(currentPwd, sessionUser.getPassword())){
	            request.setAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
	            request.getRequestDispatcher("/mem/UpdateMyCheck.jsp").forward(request, response);
	            return;
	        }
	        
	        // 검증 성공 시 세션에 플래그 설정
	        request.getSession().setAttribute("isPwdVerified", true);
	        
	        // 새 비밀번호 수정 페이지로 리다이렉트
	        response.sendRedirect(request.getContextPath() + "/member/updateMyPw.do");
	    }



	

}
