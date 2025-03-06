package Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.PostDao;
import Model.PostVo;
import Model.MemberVo;

public class PostWriteService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 🔹 세션에서 로그인한 사용자 정보 가져오기
        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        // 🔹 폼에서 입력받은 데이터 가져오기
        int categoryid = Integer.parseInt(request.getParameter("categoryid"));
        String productName = request.getParameter("productName");
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
        int productStock = Integer.parseInt(request.getParameter("productStock"));
        String productInfo = request.getParameter("productInfo");
        String productImage = request.getParameter("productImage");

        // 🔹 기본 생성자 사용 후 set 메서드로 값 설정
        PostVo vo = new PostVo();
        vo.setCategoryid(categoryid);
        vo.setAuthorid(Integer.parseInt(user.getUserid())); // String을 int로 변환 후 저장
        vo.setProductName(productName);
        vo.setProductPrice(productPrice);
        vo.setProductStock(productStock);
        vo.setProductInfo(productInfo);
        vo.setProductImage(productImage);

        // 🔹 DAO 호출해서 DB에 저장
        PostDao dao = new PostDao();
        dao.postInsert(vo);
    }
}
