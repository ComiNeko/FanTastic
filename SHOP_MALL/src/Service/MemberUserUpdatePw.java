package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;
import Model.MemberVo;
import util.PasswordUtil;

public class MemberUserUpdatePw implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 request.setCharacterEncoding("utf-8");
	        
		 // 세션 플래그 확인 (비정상적인 접근 차단)
	        Boolean isVerified = (Boolean) request.getSession().getAttribute("isPwdVerified");
	        if(isVerified == null || !isVerified){
	            request.setAttribute("errorMsg", "비정상적인 접근입니다.");
	            response.sendRedirect(request.getContextPath() + "/member/updateMyPw.do");
	            return;
	        }
	        
	        // 로그인 여부 확인
	        MemberVo sessionUser = (MemberVo) request.getSession().getAttribute("user");
	        if(sessionUser == null) {
	            request.setAttribute("errorMsg", "로그인이 필요합니다.");
	            return;
	        }
	        String userid = sessionUser.getUserid();
	        
	        // 새 비밀번호 파라미터 검증
	        String newPwdParam = request.getParameter("newPassword");
	        if(newPwdParam == null || newPwdParam.trim().isEmpty()){
	            request.setAttribute("errorMsg", "새 비밀번호를 입력해 주세요.");
	            request.getRequestDispatcher("/mem/UpdateMyPw.jsp").forward(request, response);
	            return;
	        }
	        String newPwd = newPwdParam.trim();
	        
	        String confirmPwdParam = request.getParameter("passwordConfirm");
	        if(confirmPwdParam == null || confirmPwdParam.trim().isEmpty()){
	            request.setAttribute("errorMsg", "비밀번호 확인을 입력해 주세요.");
	            request.getRequestDispatcher("/mem/UpdateMyPw.jsp").forward(request, response);
	            return;
	        }
	        String confirmPwd = confirmPwdParam.trim();
	        
	        if(!newPwd.equals(confirmPwd)){
	            request.setAttribute("errorMsg", "비밀번호와 확인이 일치하지 않습니다.");
	            request.getRequestDispatcher("/mem/UpdateMyPw.jsp").forward(request, response);
	            return;
	        }
	        
	        // 선택: 새 비밀번호가 현재 비밀번호와 동일하면 업데이트하지 않도록 처리
	        if (PasswordUtil.checkPassword(newPwd, sessionUser.getPassword())) {
	            request.setAttribute("errorMsg", "새 비밀번호는 현재 비밀번호와 달라야 합니다.");
	            request.getRequestDispatcher("/mem/UpdateMyPw.jsp").forward(request, response);
	            return;
	        }
	        
	        // 새 비밀번호 암호화 및 DB 업데이트
	        String hashedPassword = PasswordUtil.hashPassword(newPwd);
	        int result = new MemberDao().updatePassword(userid, hashedPassword);
	        
	        if(result > 0){
	            // 업데이트 성공 시 세션 정보 갱신 및 플래그 제거
	            sessionUser.setPassword(hashedPassword);
	            request.getSession().removeAttribute("isPwdVerified");
	            response.sendRedirect(request.getContextPath() + "/member/mypage.do");
	        } else {
	            request.setAttribute("errorMsg", "비밀번호 수정에 실패했습니다.");
	            request.getRequestDispatcher("/mem/UpdateMyPw.jsp").forward(request, response);
	        }

	}
}