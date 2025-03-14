<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postcreatordetail.css">

<title>${creatorList[0].authorname}작가 상세 페이지</title>

<body>
	<div class="container">
		<!-- 작가 프로필 -->
		<div class="creator-profile">
			<img src="/uploads/${creatorList[0].authorimg1}"
				alt="${creatorList[0].authorname}">
			<h2>${creatorList[0].authorname}</h2>
			<p>${creatorList[0].authorinfo}</p>
			<div class="extra-images">
				<c:if test="${not empty creatorList[0].authorimg2}">
					<img src="/uploads/${creatorList[0].authorimg2}" alt="추가 이미지">
				</c:if>
				<c:if test="${not empty creatorList[0].authorimg3}">
					<img src="/uploads/${creatorList[0].authorimg3}" alt="추가 이미지">
				</c:if>
			</div>
		</div>

		<!-- 상품 목록 -->
		<div class="product-list">
			<h3>상품 목록</h3>
			<div class="product-grid">
				<c:forEach var="product" items="${creatorList}">
					<c:if test="${product.productid != 0}">
						<div class="product-card">
							<!-- 상품 이미지 클릭 시 상세 페이지로 이동 -->
							<a href="/post/postdetail.do?productid=${product.productid}">
								<c:if test="${not empty product.productImage}">
									<img src="${product.productImage}" alt="${product.productName}">
								</c:if>
								<h4>${product.productName}</h4>
								<p class="price">${product.productPrice}원</p>
								<p>재고: ${product.productStock}개</p>
								<p>${product.productInfo}</p>
							</a>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
	<%@ include file="../fragments/footer.jsp"%>
</body>
</html>
