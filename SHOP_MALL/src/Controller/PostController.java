package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Service.PostWriteService;



@WebServlet("/post/*")
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
		System.out.println("action = "+action);
		String page = null;
		
		switch(action) {
		case "":
			page = "/posts/write.jsp";
			break;
		case "/ptwritepro.do":
			new PostWriteService().doCommand(request, response);
			response.sendRedirect("/posts/List.do");
			return; //여기서 리턴을 만나면 밑에 페이지를 실행하지 않는다. 	
			
		}
		
		if(page != null) {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
	
		}
	}
		

}
