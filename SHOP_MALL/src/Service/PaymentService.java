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
        String productQuantityStr = request.getParameter("productQuantity"); // 수량을 문자열로 받음
        
        int productQuantity = 1;
        
        if (productQuantityStr != null && !productQuantityStr.isEmpty()) {
            try {
                productQuantity = Integer.parseInt(productQuantityStr); // 변환 시도
            } catch (NumberFormatException e) {
                // 변환 실패 시 기본값 유지 또는 에러 처리
                System.err.println("수량 변환 실패: " + e.getMessage());
                // 변환 실패시 값은 1
            }
        }
        
        System.out.println("Received Product ID: " + productId);
        System.out.println("Received Product Name: " + productName);
        System.out.println("Received Product Price: " + productPrice);
        System.out.println("Received Product Quantity: " + productQuantity);

        // 상품 정보를 request에 저장
        request.setAttribute("productId", productId);
        request.setAttribute("productName", productName);
        request.setAttribute("productPrice", productPrice);
        request.setAttribute("productQuantity", productQuantity);

        // 결제 JSP 페이지로 포워딩
        request.getRequestDispatcher("/adminpange/payments.jsp").forward(request, response);
    }
}
