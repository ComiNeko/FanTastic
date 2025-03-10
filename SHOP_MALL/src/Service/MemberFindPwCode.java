package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberFindPwCode implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		
		String inputCode = request.getParameter("authCode");
        if(inputCode == null || inputCode.isEmpty()){
            response.getWriter().println("인증 코드를 입력해주세요.");
            return;
        }
        HttpSession session = request.getSession();
        String savedCode = (String) session.getAttribute("resetPwAuthCode");
        Long expiryTime = (Long) session.getAttribute("authCodeExpiry");
        if(savedCode == null || expiryTime == null || System.currentTimeMillis() > expiryTime){
            response.getWriter().println("인증 코드가 만료되었습니다.");
            return;
        }
        if(savedCode.equals(inputCode)){
            response.getWriter().println("success");
        } else {
            response.getWriter().println("인증 코드가 일치하지 않습니다.");
        }

	}

}
