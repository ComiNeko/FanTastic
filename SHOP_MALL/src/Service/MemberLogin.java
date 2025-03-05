package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.MemberDao;
import Model.MemberVo;
import util.PasswordUtil;



public class MemberLogin implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        
        MemberDao dao = new MemberDao();
        MemberVo vo = dao.getMemberById(userid);
        

//        if (vo != null && PasswordUtil.checkPassword(password, vo.getPassword())) {
//            HttpSession session = request.getSession();
//            session.setAttribute("user", vo);
//            response.getWriter().write("success"); // 클라이언트에게 success 응답
//        } else {
//        	response.getWriter().write("fail"); // 로그인 실패 응답
//            System.out.println("해당 userid의 회원이 존재하지 않습니다.");
//        	}
		
        if(vo == null) {
            System.out.println("해당 userid의 회원이 존재하지 않습니다.");
            response.getWriter().write("fail");
            return;
        }

        // vo가 존재하는 경우
        System.out.println("DB에 저장된 해시: " + vo.getPassword());
        boolean isMatch = PasswordUtil.checkPassword(password, vo.getPassword());
        System.out.println("비밀번호 일치 여부: " + isMatch);

        if(isMatch) {
            HttpSession session = request.getSession();
            session.setAttribute("user", vo);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
        
        
		}

}	