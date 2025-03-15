package Service;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.PostDao;
import Model.PostVo;

public class PostSellingPagingService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        int categoryId = (category != null && !category.isEmpty()) ? Integer.parseInt(category) : -1;

        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 9;
        int pageBlock = 3;

        PostDao dao = new PostDao();
        int totalCount = dao.getProductCountByCategory(categoryId);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        List<PostVo> productList = dao.getProductListByCategory(page, pageSize, categoryId);

        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = Math.min(startPage + pageBlock - 1, totalPage);

        request.setAttribute("productList", productList);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("category", category);
    }
}