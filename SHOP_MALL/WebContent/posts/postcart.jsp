<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp"%>

<link rel="stylesheet" href="/css/postcart.css">

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
</head>
<body>

	<div class="cart-container">
		<h2 class="cart-title">장바구니</h2>

		<c:choose>
			<c:when test="${empty cartList}">
				<!-- 장바구니 비었을 때 -->
				<div class="empty-cart">
					<img src="${pageContext.request.contextPath}/img/cart.png"
						alt="장바구니 비었음">
					<p>장바구니가 비어있어요!</p>
					<p>
						다양한 상품을 구경하고<br> 나에게 맞는 상품을 담아보세요!
					</p>
					<a href="/post/postsellinglist.do?category=1"
						class="browse-products-btn">상품 구경하러 가기</a>
				</div>
			</c:when>
			<c:otherwise>
				<!-- 장바구니에 상품 있을 때 -->
				<ul class="cart-items">
					<c:forEach var="item" items="${cartList}">
						<li class="cart-item">
							<img src="${pageContext.request.contextPath}${item.productImage}" alt="${item.productName}">
							<div class="cart-item-info">
								<h3>${item.productName}</h3>
								<p>가격: <span class="cart-item-price">${item.productPrice}원</span></p>
								<p>수량: <span class="cart-item-quantity">${item.quantity}개</span></p>
							</div>
							<!-- AJAX 호출할 버튼 -->
							<button type="button" class="remove-cart-btn"
								onclick="removeFromCart('${item.productid}')">삭제</button>
							<button type="button" onclick="buyNow('${item.productid}', '${item.productName}', ${item.productPrice}, ${item.quantity}, '${item.productImage}')">바로 구매</button>
						</li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>

	<script>
	// 장바구니에서 상품 삭제 (수정된 URL 적용!)
	function removeFromCart(productId) {
	    console.log("삭제 요청 상품 ID: " + productId); // 콘솔 확인용
	 	// 삭제 요청
	    $.ajax({
	        type: "POST",
	        url: "/post/removeFromCart.do", // ✅ 수정된 URL
	        data: { productid: productId, action: 'remove' }, // 그대로 사용
	        success: function(response) {
	            // alert(response); // 필요 시 사용
	            location.reload(); // 새로고침
	        },
	        error: function(xhr, status, error) {
	            console.error("삭제 실패:", error);
	            alert("삭제 실패: " + error);
	        }
	    });
	}
	
	function buyNow(productId, productName, productPrice, productQuantity, productImage) {
	    console.log("productId:", productId);
	    console.log("productName:", productName);
	    console.log("productPrice:", productPrice);
	    console.log("productQuantity:", productQuantity);
	    console.log("productImage:", productImage);

	    const encodedName = encodeURIComponent(productName);
	    const encodedImage = encodeURIComponent(productImage);
	    const queryString = `?productId=${productId}&productName=${encodedName}&productPrice=${productPrice}&productQuantity=${productQuantity}&productImage=${encodedImage}`;
	    
	    console.log("QueryString:", queryString); // 쿼리 스트링 확인
	    window.location.href = `/payment/payment.do${queryString}`;
	}
	</script>

	<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
