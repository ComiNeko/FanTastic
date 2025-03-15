package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import Model.MemberDao;
import Model.MemberVo;

public class MemberRecentView implements Command {

    private MemberDao dao = new MemberDao();

    // 최근 본 상품 페이지 이동
    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.do");
            return;
        }

        MemberVo user = (MemberVo) session.getAttribute("user");
        String userid = user.getUserid();

        List<MemberVo.RecentView> recentViews = dao.getRecentViews(userid);
        request.setAttribute("recentViews", recentViews);

        // JSP 경로도 확인해! 오타 여부: recentview.jsp or myresent.jsp
        request.getRequestDispatcher("/mem/myresent.jsp").forward(request, response);
    }

    // 최근 본 상품 추가
    public void addRecentView(String userid, int productid) {
        dao.addRecentView(userid, productid);
    }

    // 최근 본 상품 삭제 (DAO 호출용)
    public void removeRecentView(String userid, int recent_view_id) {
        dao.removeRecentView(userid, recent_view_id);
    }

    // 컨트롤러에서 호출하는 삭제 처리 메서드 (Request, Response 받음)
    public void removeRecentViewCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.do");
            return;
        }

        MemberVo user = (MemberVo) session.getAttribute("user");
        String userid = user.getUserid();

        // ✅ 파라미터명과 변수명 모두 recent_view_id 로 일치
        int recent_view_id = Integer.parseInt(request.getParameter("recent_view_id"));

        dao.removeRecentView(userid, recent_view_id);

        // 삭제 후 다시 최근 본 상품 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/recentViewPage.do");
    }
}
