//비밀번호 찾기 위한 서비스
//아이디 확인 서비스 (입력한 아이디가 존재하는지 확인)
package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import Model.MemberDao;
import Model.MemberVo;

public class MemberFindPwId implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		 response.setContentType("text/html; charset=UTF-8");
		 request.setCharacterEncoding("utf-8");

		 String userid = request.getParameter("userid");
         if(userid == null || userid.isEmpty()){
             response.getWriter().println("ユーザーIDを入力してください。");
             return;
         }

         MemberDao dao = new MemberDao();
         MemberVo vo = dao.getMemberById(userid);
         if(vo == null){
             response.getWriter().println("存在しないユーザーIDです。");
         } else {
             response.getWriter().println("success");
         }
		
	}

}
