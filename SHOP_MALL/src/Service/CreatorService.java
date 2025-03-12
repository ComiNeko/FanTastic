package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CreatorDao;
import Model.CreatorVo;

public class CreatorService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		 // DAO 객체 생성
        CreatorDao dao = new CreatorDao();

        // 작가 리스트 가져오기
        List<CreatorVo> creatorList = dao.getSelect(); // getSelect()는 전체 작가 조회 메서드

        // 가져온 데이터 request에 저장
        request.setAttribute("creatorList", creatorList);

        // 이동할 JSP 지정 (작가 리스트 화면)
        request.getRequestDispatcher("/posts/postcreator.jsp").forward(request, response);
		

	}

}
