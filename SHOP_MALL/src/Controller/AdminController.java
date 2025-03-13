package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.CreatorService;

// ✅ 파일 업로드 위해 반드시 추가!
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        String action = request.getPathInfo();
        System.out.println("admin_action = " + action);
        String page = null;

        HttpSession session = request.getSession(false);

        // [로그인 체크]
        if (session == null || session.getAttribute("authorid") == null) {
            response.sendRedirect("/member/login.do");
            return;
        }

        switch (action) {

            // [1] 프로필 수정 페이지 이동
            case "/editProfile.do":
                int authorid = (int) session.getAttribute("authorid");
                System.out.println("컨트롤러 확인용 author: " + authorid);
                new CreatorService().getAuthorProfile(request, response, authorid); // 데이터 조회 후 request로 넘김
                page = "/mem/authorprofileedit.jsp"; // 이동할 페이지
                break;

            // [2] 프로필 업데이트 처리
            case "/updateProfile.do":
                System.out.println("프로필 수정 처리 진입");
                new CreatorService().updateAuthorProfile(request, response); // 프로필 업데이트 로직 실행
                response.sendRedirect("/index.jsp"); // 완료 후 메인 페이지 이동
                return; // redirect라서 바로 return
        }

        // [공통 페이지 이동]
        if (page != null) {
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request, response);
        }
    }
}
