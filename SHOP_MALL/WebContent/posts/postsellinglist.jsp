<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postsellinglist.css">
<c:set var="isLoggedIn" value="${not empty sessionScope.user}" />

<section class="saleslist-section">
	<div class="saleslist-header">
       	<div class="container">
       		<div class="saleslist-banner">
				<h4 class="saleslist-semi-title">FanTastic한 상품들만 보여드려요!</h4>
				<h2 class="saleslist-title">상품 목록</h2>
			</div>
		</div>
	</div>
		
	<div class="saleslist-content">
		<div class="container">
			<div class="saleslist-sidebar">
				<ul>
					<li onclick="location.href='/post/creatorlist.do'"
					class="${pageContext.request.requestURI == '/post/creatorlist.do' ? 'active' : ''}">
					크리에이터 </li>
					<li onclick="location.href='/post/postsellinglist.do'">전체상품</li>
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
					<li onclick="location.href='/post/postsellinglist.do?category=8'"
						class="${param.category == '8' ? 'active' : ''}">기타</li>
				</ul>
			</div>
			
			<div class="saleslist-frame">
				<div class="write-button-container">
					<c:if test="${sessionScope.user.role == 'Admin'}">
						<button type="button" class="write-button" onclick="location.href='/post/ptwrite.do'">상품등록</button>
					</c:if>
				</div> <!-- write-button-container end -->

				<div class="saleslist-products">
					<c:choose>
						<c:when test="${not empty productList}">
							<c:forEach var="product" items="${productList}">
								<div class="product-card">
									<div class="product-card-top">
										<a href="/post/postdetail.do?productid=${product.productid}">
											<img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}" class="product-img">
										</a>
									</div>
									<div class="product-card-bottom">
										<div class="product-card-bottom-top">
											<a href="/post/postdetail.do?productid=${product.productid}">
												<span class="product-author">${product.authorName}</span>
												<span class="product-category">${product.categoryName}</span>
											</a>
										</div>
										<div class="product-card-bottom-bottom">
											<a href="/post/postdetail.do?productid=${product.productid}">
												<span class="product-name">${product.productName}</span>
												<span class="product-price">${product.productPrice}원</span>
												<span class="product-info">${product.productInfo}</span>
											</a>
										</div>
									</div>
									<!-- 장바구니 버튼 -->
									<div class="product-card-btnbox">
										<button class="cart-btn" data-productid="${product.productid}">
											<img src="${pageContext.request.contextPath}/img/cart.png"
												alt="장바구니" class="cart-icon">
										</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p>해당 카테고리에 등록된 상품이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div> 				<!-- saleslist-products end -->
				
				<div class="saleslist-pagination">
					<c:if test="${startPage > 1}">
						<a href="/post/postsellinglist.do?page=${startPage - 1}&category=${param.category}">&laquo;</a>
					</c:if>
	
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<a href="/post/postsellinglist.do?page=${i}&category=${param.category}" class="${i == currentPage ? 'active' : ''}">${i}</a>
					</c:forEach>
	
					<c:if test="${endPage < totalPage}">
						<a href="/post/postsellinglist.do?page=${endPage + 1}&category=${param.category}">&raquo;</a>
					</c:if>
				</div>
			</div> 	   				<!-- saleslist-frame end -->
		</div>         				<!-- container end -->
	</div>             				<!-- saleslist-content end -->
</section>							<!-- saleslist-section end -->

<!-- 자바스크립트: 로그인 여부 확인 및 장바구니 기능 -->
<script>
	$(document).ready(function() {
		var isLoggedIn = "${isLoggedIn}" === "true"; // 로그인 여부 JS로 변환

		// 장바구니 아이콘 클릭 시 로그인 확인
		$("#cartIcon").on("click", function(e) {
			e.preventDefault(); // 기본 이동 막기
			if (!isLoggedIn) {
				alert("로그인 후 이용해주세요.");
				window.location.href = "/member/login.do"; // 로그인 페이지로 이동
			} else {
				window.location.href = "/post/postcart.do"; // 장바구니 페이지로 이동
			}
		});

		// 상품 장바구니 추가 버튼
		$(".cart-floating-btn").on("click", function() {
			var productId = $(this).data("productid");
			if (!isLoggedIn) {
				alert("로그인 후 이용해주세요.");
				window.location.href = "/member/login.do"; // 로그인 페이지로 이동
				return;
			}

			$.ajax({
				type: "GET",
				url: "/post/addToCart.do",
				data: {
					productid: productId,
					action: 'add'
				},
				success: function(response) {
					alert("상품이 장바구니에 추가되었습니다!");
				},
				error: function(xhr, status, error) {
					console.log("에러 상태: " + status);
					console.log("에러 내용: " + error);
					alert("장바구니 추가에 실패했습니다.");
				}
			});
		});
	});
	
	// 찜하기 버튼 클릭 이벤트
       $(".favorite-btn").on("click", function() {
           var productId = $(this).data("productid");
           var isLoggedIn = "${isLoggedIn}" === "true";
           if (!isLoggedIn) {
               alert("로그인 후 이용해주세요.");
               window.location.href = "/member/login.do";
               return;
           }
           
           $.ajax({
               url: "/post/add.do",
               type: "POST",
               data: { productId: productId },
               contentType: "application/x-www-form-urlencoded; charset=UTF-8",
               dataType: "json",
               success: function(response) {
                   alert(response.message);
               },
               error: function(xhr, status, error) {
                   console.error("에러 상태: " + status);
                   console.error("에러 내용: " + error);
                   alert("찜하기 추가에 실패했습니다.");
               }
           });
       });
</script>

<%@ include file="/fragments/footer.jsp"%>
