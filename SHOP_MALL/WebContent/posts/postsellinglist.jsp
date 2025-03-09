<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.PostVo"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="/css/postsellinglist.css">

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 목록</title>
<div class="header-icons">
    <a href="/posts/postcart.jsp" class="cart-link">
        <img src="/img/cart.png" alt="장바구니" class="cart-header-icon">
    </a>
</div>


</head>
<body>

	<%
		HttpSession sessionObj = request.getSession(false);
	boolean isLoggedIn = (sessionObj != null && sessionObj.getAttribute("user") != null);
	String category = request.getParameter("category");
	%>

	<div class="container">
		<div class="sidebar">
			<ul>
				<li onclick="location.href='/post/postsellinglist.do?category=1'"
					class="<%="1".equals(category) ? "active" : ""%>">키링</li>
				<li onclick="location.href='/post/postsellinglist.do?category=2'"
					class="<%="2".equals(category) ? "active" : ""%>">아크릴굿즈</li>
				<li onclick="location.href='/post/postsellinglist.do?category=3'"
					class="<%="3".equals(category) ? "active" : ""%>">포토카드</li>
				<li onclick="location.href='/post/postsellinglist.do?category=4'"
					class="<%="4".equals(category) ? "active" : ""%>">틴케이스</li>
				<li onclick="location.href='/post/postsellinglist.do?category=5'"
					class="<%="5".equals(category) ? "active" : ""%>">키캡</li>
				<li onclick="location.href='/post/postsellinglist.do?category=6'"
					class="<%="6".equals(category) ? "active" : ""%>">거울/핀버튼</li>
				<li onclick="location.href='/post/postsellinglist.do?category=7'"
					class="<%="7".equals(category) ? "active" : ""%>">커버/클리너</li>
			</ul>
		</div>

		<div class="content">
			<h2>상품 목록</h2>

			<div class="write-button-container">
				<button type="button" class="write-button"
					onclick="handleWriteButton()">글쓰기</button>
			</div>

			<div class="product-list">
				<%
					List<PostVo> productList = (List<PostVo>) request.getAttribute("productList");
				if (productList != null && !productList.isEmpty()) {
					for (PostVo post : productList) {
				%>
				<div class="product-item">
					<img src="uploads/<%=post.getProductImage()%>"
						alt="<%=post.getProductName()%>">
					<div class="name"><%=post.getProductName()%></div>
					<div class="price"><%=post.getProductPrice()%>원
					</div>

					<button class="add-to-cart" onclick="addToCart('<%= post.getProductid() %>')">
    <img src="/img/cart.png" alt="장바구니" class="cart-icon"> 장바구니 담기
</button>


				</div>
				<%
					}
				} else {
				%>
				<p>해당 카테고리에 등록된 상품이 없습니다.</p>
				<%
					}
				%>
			</div>
		</div>
	</div>

	<script>
        function handleWriteButton() {
            var isLoggedIn = <%=isLoggedIn%>; 

            if (!isLoggedIn) {
                alert("로그인해주세요");
                window.location.href = "/member/login.do"; // 로그인 페이지로 이동
            } else {
                window.location.href = "postwrite.jsp"; // 로그인된 경우 글쓰기 페이지로 이동
            }
        }

        function addToCart(productId) {
            fetch('/post/addToCart.do?productid=' + productId, {
                method: 'GET'
            }).then(response => {
                if (response.ok) {
                    alert("상품이 장바구니에 추가되었습니다!");
                } else {
                    alert("장바구니 추가에 실패했습니다.");
                }
            });
        }
    </script>

	<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
