package Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.PostVo;

public class PostCartService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		HttpSession session = request.getSession();
		
        List<PostVo> cart = (List<PostVo>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // 상품 정보 받기
        int productid = Integer.parseInt(request.getParameter("productid"));
        String productName = request.getParameter("productName");
        int price = Integer.parseInt(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // 장바구니에 같은 상품이 있으면 수량 증가
        boolean exists = false;
        for (PostVo item : cart) {
            if (item.getProductid() == productid) {
                item.setQuantity(item.getQuantity() + quantity);
                exists = true;
                break;
            }
        }

//        // 새 상품 추가
//        if (!exists) {
//            cart.add(new PostVo(productid, productName, price, quantity));
//        }

        session.setAttribute("cart", cart);

        response.sendRedirect("postcart.jsp");
		
		
	}

}
