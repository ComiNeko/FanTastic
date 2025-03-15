package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import Model.MemberDao;
import Model.MemberVo;

public class MemberRecentView implements Command {

    private MemberDao dao = new MemberDao();
    
    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        // 세션 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.do");
            return;
        }
        MemberVo user = (MemberVo) session.getAttribute("user");
        String userId = user.getUserid();
        
        // DAO를 통해 최근 본 상품 목록 조회 후 request 속성에 저장
        List<MemberVo.RecentView> recentViews = dao.getRecentViews(userId);
        request.setAttribute("recentViews", recentViews);
        
        // 최근 본 상품 전용 JSP로 포워딩
        request.getRequestDispatcher("/mem/recentViewPage.jsp").forward(request, response);
    }
    
    // 필요에 따라 외부에서 호출할 수 있도록 별도 메서드로 제공 (클래스 레벨에 선언)
    public void addRecentView(String userId, int productId) {
        dao.addRecentView(userId, productId);
    }
    
    public void removeRecentView(String userId, int productId) {
        dao.removeRecentView(userId, productId);
    }
}
