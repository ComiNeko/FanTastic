package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CreatorDao;
import Model.CreatorVo;

public class CreatorDetailService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 작가 ID 파라미터로 받기
        int authorid = Integer.parseInt(request.getParameter("authorid"));
        System.out.println("받은 authorid: " + authorid); // 디버깅

        // 2. DAO 호출해서 데이터 가져오기
        CreatorDao dao = new CreatorDao();
        List<CreatorVo> creatorList = dao.getSearch(authorid);

        // 3. 가져온 데이터를 request에 저장
        request.setAttribute("creatorList", creatorList); // 리스트 형태로 저장 (작가 + 상품 묶인 형태)

        // 4. JSP 페이지로 이동
        request.getRequestDispatcher("/posts/creatorDetail.jsp").forward(request, response);
    }

}
