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

import Service.*;

@WebServlet("/post/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PostController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getPathInfo();
        System.out.println("action = " + action);
        String page = null;

        // 로그인 체크: 일부 페이지는 로그인 없이 접근 가능
        if (!"/postsellinglist.do".equals(action) && !"/postcart.do".equals(action)) {
            HttpSession session = request.getSession();
            if (session.getAttribute("user") == null) {
                response.sendRedirect("/member/login.do");
                return;
            }
        }

        switch (action) {
            case "/addToCart.do":
            case "/removeFromCart.do":
            case "/postcart.do":
                new PostCartService().doCommand(request, response);
                return;
            
            case "/ptwrite.do":
                page = "/posts/postwrite.jsp";
                break;
            
            case "/ptwritepro.do":
                new PostWriteService().doCommand(request, response);
                response.sendRedirect("/post/postsellinglist.do");
                return;
            
            case "/postsellinglist.do":
                new PostSellingService().doCommand(request, response);
                page = "/posts/postsellinglist.jsp";
                break;
            
            case "/postdetail.do":
                new PostDetailService().doCommand(request, response);
                page = "/posts/postdetail.jsp";
                break;
            
            case "/creatorlist.do":
                new CreatorListService().doCommand(request, response);
                page = "/posts/postcreator.jsp";
                break;
            
            case "/creatordetail.do":
                new CreatorDetailService().doCommand(request, response);
                return;
            
            case "/productdelete.do":
                new ProductDeleteService().doCommand(request, response);
                return;
            
            case "/review.do":
                new ReviewService().doCommand(request, response);
                String productId = request.getParameter("productid");
                response.sendRedirect("/post/postdetail.do?productid=" + productId);
                return;
            
            case "/list.do":
                new FavoriteList().doCommand(request, response);
                return;
            
            case "/add.do":
                new FavoriteAdd().doCommand(request, response);
                return;
            
            case "/remove.do":
                new FavoriteRemove().doCommand(request, response);
                return;
        }

        // 페이지 이동 처리
        if (page != null) {
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request, response);
        }
    }
}
