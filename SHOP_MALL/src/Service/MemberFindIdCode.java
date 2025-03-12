package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberFindIdCode implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		String inputCode = request.getParameter("authCode");
		if (inputCode == null || inputCode.isEmpty()) {
			// response.getWriter().println("인증 코드를 입력해주세요."); //
			return;
		}

		HttpSession session = request.getSession();
		String savedCode = (String) session.getAttribute("findIdAuthCode");
		String userId = (String) session.getAttribute("findIdUserId");
		Long expiryTime = (Long) session.getAttribute("authCodeExpiry");

		if (savedCode == null || expiryTime == null || System.currentTimeMillis() > expiryTime) {
			response.getWriter().println("인증 코드가 만료되었습니다.");
			session.removeAttribute("findIdAuthCode");
			session.removeAttribute("findIdUserId");
			session.removeAttribute("authCodeExpiry");
			return;
		}

		if (savedCode.equals(inputCode)) {
			// 아이디 마스킹: 숫자가 있다면 최대 2자리만 마스킹 처리, 숫자가 없으면 그대로 노출
			String maskedUserId = maskUserId(userId);
			session.removeAttribute("findIdAuthCode");
			session.removeAttribute("findIdUserId");
			session.removeAttribute("authCodeExpiry");
			response.getWriter().println("success:" + maskedUserId);
		} else {
			response.getWriter().println("인증 코드가 일치하지 않습니다.");
		}
	}

	/**
	 * 아이디 마스킹 처리 메서드 - userId에 숫자가 하나라도 있으면, 그 숫자들 중 최대 2자리만 '*' 로 대체합니다. - 만약
	 * userId에 숫자가 없다면 원래 userId를 그대로 반환합니다.
	 */
	private String maskUserId(String userId) {
		// 숫자가 있는지 여부 체크
		boolean hasDigit = false;
		for (int i = 0; i < userId.length(); i++) {
			if (Character.isDigit(userId.charAt(i))) {
				hasDigit = true;
				break;
			}
		}
		if (!hasDigit) {
			return userId; // 숫자가 없으면 그대로 반환
		}

		// 숫자가 있다면 최대 2자리만 마스킹 처리
		int maskedCount = 0;
		StringBuilder masked = new StringBuilder();
		for (int i = 0; i < userId.length(); i++) {
			char ch = userId.charAt(i);
			if (Character.isDigit(ch) && maskedCount < 2) {
				masked.append("*");
				maskedCount++;
			} else {
				masked.append(ch);
			}
		}
		return masked.toString();
	}

}
