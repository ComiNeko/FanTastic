<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postsellinglist.css">
<c:set var="isLoggedIn" value="${not empty sessionScope.user}" />

<section class="saleslist-section">
	<div class="saleslist-container">
		<div class="saleslist-sidebar">
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

		<div class="saleslist-content">
			<h2 class="saleslist-sign">상품 목록</h2>
			<div class="write-button-container">
				<c:if test="${sessionScope.user.role == 'Admin'}">
					<%-- role 값이 Admin인 경우에만 관리자 페이지 링크를 표시 --%>
					<button type="button" class="write-button" onclick="location.href='/post/ptwrite.do'">글쓰기</button>
				</c:if>
			</div>
			<div class="saleslist-products">
				<c:choose>
					<c:when test="${not empty productList}">
						<c:forEach var="product" items="${productList}">
						
							<div class="product-item">
								<!-- 상품 이미지 클릭 시 상세 페이지로 이동 -->
								<a href="/post/postdetail.do?productid=${product.productid}">
									<img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}" class="product-img">
								</a>

								<!-- 상품명 클릭 시 상세 페이지로 이동 -->
								<a href="/post/postdetail.do?productid=${product.productid}" class="name">${product.productName}</a>
								<div class="price">${product.productPrice}원</div>
								<div class="productInfo">${product.productInfo}</div>

								<!-- 장바구니 버튼 -->
								<button class="cart-floating-btn" data-productid="${product.productid}">
									<img src="${pageContext.request.contextPath}/img/cart.png" alt="장바구니" class="cart-icon">
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
</section>

<script>
	$(document).ready(function() {
		$(".cart-floating-btn").on("click", function() {
			var productId = $(this).data("productid");
			var isLoggedIn = "${isLoggedIn}" === "true"; // 문자열을 비교해서 boolean으로 변환
			// 로그인 여부 확인

			if (!isLoggedIn) {
				alert("로그인 후 이용해주세요.");
				window.location.href = "/member/login.do";
				return;
			}

			$.ajax({
				type : "GET",
				url : "/post/addToCart.do",
				data : {
					productid : productId,
					action : 'add'
				}, // action 파라미터 추가
				success : function(response) {
					alert("상품이 장바구니에 추가되었습니다!");
				},
				error : function(xhr, status, error) {
					console.log("에러 상태: " + status);
					console.log("에러 내용: " + error);
					alert("장바구니 추가에 실패했습니다.");
				}
			});
		});
	});
</script>

<%@ include file="/fragments/footer.jsp"%>