package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CreatorDao;
import Model.CreatorVo;

public class CreatorPagingService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		CreatorDao dao = new CreatorDao();

		// 현재 페이지
		int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

		int pageSize = 9; // 3줄 3칸
		int pageBlock = 3; // 페이징 번호 3개 제한

		// 총 데이터 수
		int totalCount = dao.getCreatorCount();
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);

		// 현재 페이지의 작가 목록
		List<CreatorVo> creatorList = dao.getPagingCreatorList(page, pageSize);

		// 페이지 블럭 계산
		int startPage = ((page - 1) / pageBlock) * pageBlock + 1; //시작페이지
		int endPage = Math.min(startPage + pageBlock - 1, totalPage); //끝페이지

		// JSP로 데이터 전달
		request.setAttribute("creatorList", creatorList);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", page);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalCount", totalCount);

	}

}
