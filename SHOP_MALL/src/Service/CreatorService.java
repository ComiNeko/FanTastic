package Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Model.CreatorDao;
import Model.CreatorVo;

public class CreatorService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 사용 안 함 (기본 인터페이스 구현용)
    }

    // [1] 작가 프로필 조회
    public void getAuthorProfile(HttpServletRequest request, HttpServletResponse response, int authorid) {
        CreatorDao dao = new CreatorDao();
        CreatorVo author = dao.getAuthorProfileByAuthorId(authorid); // authorid로 조회
        request.setAttribute("author", author); // jsp로 전달
    }

    // [2] 작가 프로필 수정
    public void updateAuthorProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // authorid 가져오기 (multipart/form-data 때문에 Part로 받아야 함)
        Part authoridPart = request.getPart("authorid");
        String authoridStr = new BufferedReader(new InputStreamReader(authoridPart.getInputStream())).readLine();
        System.out.println("넘어온 authorid: " + authoridStr);

        if (authoridStr == null || authoridStr.trim().isEmpty()) {
            throw new ServletException("authorid가 없습니다.");
        }
        int authorid = Integer.parseInt(authoridStr);

        // 나머지 데이터 (작가명, 소개)
        Part authornamePart = request.getPart("authorname");
        String authorname = new BufferedReader(new InputStreamReader(authornamePart.getInputStream())).readLine();

        Part authorinfoPart = request.getPart("authorinfo");
        String authorinfo = new BufferedReader(new InputStreamReader(authorinfoPart.getInputStream())).readLine();

        // 파일 업로드 경로
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        System.out.println("파일 업로드 경로: " + uploadPath);

        // 이미지 파일 Part로 받기
        Part img1Part = request.getPart("authorimg1");
        Part img2Part = request.getPart("authorimg2");
        Part img3Part = request.getPart("authorimg3");

        // 파일 저장
        String authorimg1 = saveFile(img1Part, uploadPath);
        String authorimg2 = saveFile(img2Part, uploadPath);
        String authorimg3 = saveFile(img3Part, uploadPath);

        // ✅ DB 업데이트
        CreatorDao dao = new CreatorDao();
        dao.updateAuthor(authorid, authorname, authorinfo, authorimg1, authorimg2, authorimg3);

        System.out.println("작가 정보 수정 완료.");
    }

    // [파일 저장 메서드]
    private String saveFile(Part part, String uploadPath) throws IOException {
        if (part != null && part.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + Paths.get(part.getSubmittedFileName()).getFileName().toString();
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // 폴더 없으면 생성
            part.write(uploadPath + File.separator + fileName); // 파일 저장
            System.out.println("저장된 파일명: " + fileName);
            return fileName;
        }
        return null; // 파일 없으면 null
    }
}
