package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;
import util.PasswordUtil;

public class MemberResetPw implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if(token == null || token.isEmpty() ||
           newPassword == null || newPassword.isEmpty() ||
           confirmPassword == null || confirmPassword.isEmpty()){
            response.getWriter().println("비밀번호 재설정을 위해 모두 입력해주세요.");
            return;
        }
        if(!newPassword.equals(confirmPassword)){
            response.getWriter().println("비밀번호가 일치하지 않습니다.");
            return;
        }

        // DAO 통합 사용
        MemberDao memberDao = new MemberDao();
        String userid = memberDao.getUserIdByToken(token);
        if(userid == null){
            response.getWriter().println("유효하지 않은 토큰입니다.");
            return;
        }

        // 비밀번호 업데이트
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        int result = memberDao.updatePassword(userid, hashedPassword); // 해싱된 비밀번호 저장
        if(result > 0){
            memberDao.deleteToken(token);
            response.getWriter().println("비밀번호가 성공적으로 변경되었습니다.");
        } else {
            response.getWriter().println("비밀번호 변경에 실패했습니다.");
        }
		
	}

}
