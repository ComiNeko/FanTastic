package Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import Model.PostDao;
import Model.PostVo;
import Model.MemberVo;

public class ProductUpdateService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 세션에서 로그인한 사용자 정보 가져오기
        HttpSession session = request.getSession();
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        // 수정할 상품 정보 가져오기
        int productId = Integer.parseInt(request.getParameter("productid"));
        String productName = request.getParameter("productName");
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
        int productStock = Integer.parseInt(request.getParameter("productStock"));
        String productInfo = request.getParameter("productInfo");

        // 이미지 업로드 처리
        Part imgFile = request.getPart("productImage");
        String fileName = null;
        String imagePath = null;

        if (imgFile != null && imgFile.getSize() > 0) { // 새로운 이미지가 업로드되었는지 확인
            fileName = UUID.randomUUID().toString() + "_" + imgFile.getSubmittedFileName();
            System.out.println("업로드된 파일명: " + fileName);

            // 저장 경로 설정
            String uploadPath = request.getServletContext().getRealPath("/uploads");
            System.out.println("저장 경로: " + uploadPath);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            imgFile.write(filePath); // 파일 저장

            // DB 저장용 경로 설정
            imagePath = "/uploads/" + fileName;
        } else {
            // 이미지 변경하지 않는 경우 기존 이미지 유지
            imagePath = request.getParameter("existingProductImage");
        }

        // 상품 정보 객체 생성
        PostVo vo = new PostVo();
        vo.setProductid(productId);
        vo.setProductName(productName);
        vo.setProductPrice(productPrice);
        vo.setProductStock(productStock);
        vo.setProductInfo(productInfo);
        vo.setProductImage(imagePath); // 업데이트된 이미지 경로 저장

        // DAO를 통해 DB 업데이트 수행
        PostDao dao = new PostDao();
        dao.updateProduct(vo);

        // 수정 완료 후 마이페이지로 이동
        response.sendRedirect("/mypage.do");
    }
}
