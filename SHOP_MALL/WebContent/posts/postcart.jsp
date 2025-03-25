<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postcart.css">

<section class="cart-section">
	<div class="cart-header">
		<div class="container">
			<h2 class="cart-title">ショッピングカート</h2>
		</div>
	</div>
	<div class="cart-content">
		<div class="container">
			<c:choose>
				<c:when test="${empty cartList}">
					<!-- 장바구니 비었을 때 -->
					<div class="empty-cart">
						<img src="${pageContext.request.contextPath}/img/cart.png"
							alt="장바구니 비었음">
						<p>カートに商品がありません！</p>
                        <p>さまざまな商品をチェックして</p>
                        <p>お気に入りの商品を追加しましょう！</p>
						<a href="/post/postsellinglist.do" class="browse-products-btn">商品を見に行く</a>
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
									<p>価格: <span class="cart-item-price"><fmt:formatNumber value="${item.productPrice * 0.1}" type="number" pattern="#,##0" />円</span></p>
									<p>数量: <span class="cart-item-quantity">${item.quantity}個</span></p>
								</div>
								<!-- AJAX 호출할 버튼 -->
								<button type="button" class="remove-cart-btn" onclick="removeFromCart('${item.productid}')">削除</button>
								<button type="button" class="buy-now-btn" onclick="buyNow('${item.productid}', '${item.productName}', ${item.productPrice}, ${item.quantity}, '${item.productImage}')">今すぐ購入</button>
							</li>
						</c:forEach>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</section>

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
		//console.log("buyNow() 호출됨!");
	    //console.log("전달될 값:", productId, productName, productPrice, productQuantity, productImage);
		//
	    //const encodedName = encodeURIComponent(productName);
		//const encodedImage = encodeURIComponent(productImage);
	    //const queryString = `?productId=${productId}&productName=${encodedName}&productPrice=${productPrice}&productQuantity=${productQuantity}&productImage=${encodedImage}`;
	    //
		// console.log("생성된 URL:", `/payment/payment.do${queryString}`); // 생성된 URL 확인
	    //window.location.href = `/payment/payment.do${queryString}`;

	    // 폼 요소 생성
	    const form = document.createElement("form");
	    form.method = "POST";
	    form.action = "/payment/payment.do";

	    // 필드 추가 (🚨 기존의 innerHTML 대신 `createElement()` 사용)
	    const fields = {
	        productId: productId,
	        productName: productName,
	        productPrice: productPrice,
	        productQuantity: productQuantity,
	        productImage: productImage
	    };

	    for (let key in fields) {
	        const input = document.createElement("input");
	        input.type = "hidden";
	        input.name = key;
	        input.value = fields[key];
	        form.appendChild(input);
	    }

	    document.body.appendChild(form);
	    form.submit();
	}
</script>

<%@ include file="/fragments/footer.jsp"%>