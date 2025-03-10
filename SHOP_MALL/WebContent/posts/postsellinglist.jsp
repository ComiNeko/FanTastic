<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
</head>
<body>
	<div class="header-icons">
		<a href="/posts/postcart.jsp"> <img src="/img/cart.png" alt="장바구니"
			class="cart-header-icon">
		</a>
	</div>

	<c:set var="isLoggedIn" value="${not empty sessionScope.user}" />

	<div class="container">
		<div class="sidebar">
			<ul>
				<li onclick="location.href='/post/postsellinglist.do?category=1'"
					class="${param.category == '1' ? 'active' : ''}">키링</li>
				<li onclick="location.href='/post/postsellinglist.do?category=2'"
					class="${param.category == '2' ? 'active' : ''}">아크릴굿즈</li>
				<li onclick="location.href='/post/postsellinglist.do?category=3'"
					class="${param.category == '3' ? 'active' : ''}">포토카드</li>
				<li onclick="location.href='/post/postsellinglist.do?category=4'"
					class="${param.category == '4' ? 'active' : ''}">틴케이스</li>
				<li onclick="location.href='/post/postsellinglist.do?category=5'"
					class="${param.category == '5' ? 'active' : ''}">키캡</li>
				<li onclick="location.href='/post/postsellinglist.do?category=6'"
					class="${param.category == '6' ? 'active' : ''}">거울/핀버튼</li>
				<li onclick="location.href='/post/postsellinglist.do?category=7'"
					class="${param.category == '7' ? 'active' : ''}">커버/클리너</li>
			</ul>
		</div>

		<div class="content">
			<h2>상품 목록</h2>

			<div class="write-button-container">
				<c:if test="${sessionScope.user.role == 'Admin'}">
					<%-- role 값이 Admin인 경우에만 관리자 페이지 링크를 표시 --%>
					<button type="button" class="write-button"
						onclick="handleWriteButton()">글쓰기</button>
				</c:if>
			</div>

			<div class="product-list">
				<c:choose>
					<c:when test="${not empty productList}">
						<c:forEach var="product" items="${productList}">
							<div class="product-item">
								<img src="uploads/${product.productImage}"
									alt="${product.productName}">
								<div class="name">${product.productName}</div>
								<div class="price">${product.productPrice}원</div>

								<button class="add-to-cart"
									onclick="addToCart('${product.productid}')">
									<img src="${pageContext.request.contextPath}/img/cart.png"
										alt="장바구니" class="cart-icon"> 장바구니 담기
								</button>

							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p>해당 카테고리에 등록된 상품이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<script>
        function handleWriteButton() {
            var isLoggedIn = ${isLoggedIn};

            if (!isLoggedIn) {
                alert("로그인해주세요");
                window.location.href = "/member/login.do";
            } else {
                window.location.href = "/posts/postwrite.jsp";
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
