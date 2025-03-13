package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        int productQuantity = 1;
        
        System.out.println(productId);
        System.out.println(productName);
        System.out.println(productPrice);
        System.out.println(productQuantity);

        // 상품 정보를 request에 저장
        request.setAttribute("productId", productId);
        request.setAttribute("productName", productName);
        request.setAttribute("productPrice", productPrice);
        request.setAttribute("productQuantity", productQuantity);

        // 결제 JSP 페이지로 포워딩
        request.getRequestDispatcher("/adminpange/payments.jsp").forward(request, response);
    }
}
