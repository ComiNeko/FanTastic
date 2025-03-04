package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLogout implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			request.setCharacterEncoding("utf-8");
					
					HttpSession session = request.getSession(false);
					
					if(session != null) {
						session.invalidate(); //세션 삭제
					}//if

	}

}
