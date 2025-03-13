package Service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CreatorDao;
import Model.CreatorVo;

public class CreatorListService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CreatorDao 인스턴스 생성
        CreatorDao dao = new CreatorDao();

        // 작가 리스트 가져오기
        List<CreatorVo> creatorList = dao.getSelect(); // 전체 작가 리스트 반환 메서드 사용

        // request에 저장 (JSP에서 사용 가능)
        request.setAttribute("creatorList", creatorList);

        // 페이지 이동 (컨트롤러에서 포워드 처리)
    }
}
