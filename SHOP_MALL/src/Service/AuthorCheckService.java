package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.CreatorDao;
import Model.MemberVo;

public class AuthorCheckService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 작가 중복확인 서비스
		// 마이페이지에서 작가 등록 버튼 누를 때, 이미 작가라면 접근 불가
		
	
		HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");
        String userid = user.getUserid();

        CreatorDao dao = new CreatorDao();
        boolean isAuthorExist = dao.isAuthorExist(userid); // 작가 존재 확인

        // 결과를 request에 저장
        request.setAttribute("isAuthorExist", isAuthorExist);

        // 작가일 경우 마이페이지로, 아닐 경우 등록 폼으로 이동
        if (isAuthorExist) {
            request.getRequestDispatcher("/mem/mypage.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/mem/mypage_authorinsert.jsp").forward(request, response);
        }

	}

}
