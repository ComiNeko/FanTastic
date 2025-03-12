package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Model.CreatorDao;
import Model.CreatorVo;
import Model.MemberVo;
import java.util.UUID;
import java.io.File;

public class CreatorService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CreatorDao dao = new CreatorDao();

        // 작가 리스트 가져오기
        List<CreatorVo> creatorList = dao.getSelect();

        // 가져온 데이터 request에 저장
        request.setAttribute("creatorList", creatorList);

        // 이동할 JSP 지정
        request.getRequestDispatcher("/posts/postcreator.jsp").forward(request, response);
    }

    // [추가] 작가 프로필 조회 (마이페이지 → 프로필 수정 폼용)
    public void getAuthorProfile(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String userId = ((MemberVo) session.getAttribute("user")).getUserid(); // 세션에서 아이디

        CreatorDao dao = new CreatorDao();
        CreatorVo author = dao.getAuthorProfile(userId); // 작가 정보 조회
        request.setAttribute("author", author); // request에 저장
    }

    // [추가] 작가 프로필 업데이트
    public void updateAuthorProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String authorid = request.getParameter("authorid");
        String authorname = request.getParameter("authorname");
        String authorinfo = request.getParameter("authorinfo");

        // 파일 업로드 경로
        String uploadPath = request.getServletContext().getRealPath("/uploads");

        // 이미지 처리
        Part img1Part = request.getPart("authorimg1");
        String img1Name = saveFile(img1Part, uploadPath);

        Part img2Part = request.getPart("authorimg2");
        String img2Name = saveFile(img2Part, uploadPath);

        Part img3Part = request.getPart("authorimg3");
        String img3Name = saveFile(img3Part, uploadPath);

        // DAO 호출
        CreatorDao dao = new CreatorDao();
        dao.updateAuthor(authorid, authorname, authorinfo, img1Name, img2Name, img3Name);
    }

    // 파일 저장 메서드 (null 체크 포함)
    private String saveFile(Part part, String uploadPath) throws IOException {
        if (part != null && part.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + part.getSubmittedFileName();
            part.write(uploadPath + File.separator + fileName);
            return fileName;
        }
        return null;
    }
}
