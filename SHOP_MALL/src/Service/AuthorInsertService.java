package Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Model.CreatorDao;
import Model.MemberVo;

public class AuthorInsertService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("utf-8");

	    // 세션에서 user 객체 받아오기
	    HttpSession session = request.getSession();
	    MemberVo user = (MemberVo) session.getAttribute("user");

	    String userid = user.getUserid(); // 세션에서 꺼냄
	    String authorname = request.getParameter("authorname");
	    String authorinfo = request.getParameter("authorinfo");

	    System.out.println("세션에서 받은 userid: " + userid);
	    System.out.println("폼에서 받은 authorname: " + authorname);
	    System.out.println("폼에서 받은 authorinfo: " + authorinfo);

	    // 파일 업로드 경로
	    String uploadPath = request.getServletContext().getRealPath("/uploads");
	    System.out.println("업로드 경로: "+uploadPath);
	    
	    // 이미지 파일 받기
	    Part img1Part = request.getPart("authorimg1");
	    Part img2Part = request.getPart("authorimg2");
	    Part img3Part = request.getPart("authorimg3");

	    // 파일 저장
	    String authorimg1 = saveFile(img1Part, uploadPath);
	    String authorimg2 = saveFile(img2Part, uploadPath);
	    String authorimg3 = saveFile(img3Part, uploadPath);

	    // DB 저장
	    CreatorDao dao = new CreatorDao();
	    dao.insertAuthor(authorname, authorinfo, authorimg1, authorimg2, authorimg3, userid);

	    System.out.println("작가 등록 완료! authorname: " + authorname + " / userid: " + userid);
	}

    // 파일 저장
    private String saveFile(Part part, String uploadPath) throws IOException {
        if (part != null && part.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + Paths.get(part.getSubmittedFileName()).getFileName().toString();
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            part.write(uploadPath + File.separator + fileName);
            return fileName;
        }
        return null;
    }
}
