package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;
import Model.MemberVo;
import util.PasswordUtil;

public class MemberUserPw implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 request.setCharacterEncoding("utf-8");
	        
	        // 세션에서 사용자 정보 가져오기
	        MemberVo sessionUser = (MemberVo) request.getSession().getAttribute("user");
	        if(sessionUser == null) {
	            request.setAttribute("errorMsg", "로그인이 필요합니다.");
	            return;
	        }
	        String userid = sessionUser.getUserid();
	        
	        // 폼에서 새 비밀번호와 확인 비밀번호 값 가져오기
	        String newPwd = request.getParameter("newPassword").trim();
	        String confirmPwd = request.getParameter("confirmNewPassword").trim();
	        
	        // 서버측 유효성 검사: 새 비밀번호가 입력되어 있어야 하고, 두 값이 일치해야 함.
	        if(newPwd == null || newPwd.isEmpty()) {
	            request.setAttribute("errorMsg", "새 비밀번호를 입력해 주세요.");
	            request.setAttribute("updateResult", "fail");
	            return;
	        }
	        if(confirmPwd == null || confirmPwd.isEmpty()) {
	            request.setAttribute("errorMsg", "비밀번호 확인을 입력해 주세요.");
	            request.setAttribute("updateResult", "fail");
	            return;
	        }
	        if(!newPwd.equals(confirmPwd)) {
	            request.setAttribute("errorMsg", "비밀번호와 확인이 일치하지 않습니다.");
	            request.setAttribute("updateResult", "fail");
	            return;
	        }
	        
	        // 비밀번호 암호화 (PasswordUtil.hashPassword() 사용, 암호화 로직은 프로젝트에 맞게 처리)
	        String hashedPassword = PasswordUtil.hashPassword(newPwd);
	        
	        // DAO를 통한 DB 업데이트
	        int result = new MemberDao().updatePassword(userid, hashedPassword);
	        
	        if(result > 0) {
	            // DB 업데이트 성공 시 세션 정보 갱신
	            sessionUser.setPassword(hashedPassword);
	            request.setAttribute("updateResult", "success");
	        } else {
	            request.setAttribute("updateResult", "fail");
	            request.setAttribute("errorMsg", "비밀번호 수정에 실패했습니다.");
	        }
	   

	}

}
