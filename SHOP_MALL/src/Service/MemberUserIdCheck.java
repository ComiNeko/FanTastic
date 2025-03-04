package Service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;

public class MemberUserIdCheck implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
        String userid = request.getParameter("userid");
        
        // 중복이면 1, 없으면 -1
        int result = new MemberDao().UserFindUserid(userid);
        
        PrintWriter out = response.getWriter();
        out.print(result);  // 숫자(문자열 형태)로 클라이언트에 전송
    }
		

	

}
