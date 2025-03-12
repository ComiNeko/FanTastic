<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="/css/postdetail.css">

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 상품 정보 -->
<div class="product-main-container">
    <div class="product-image">
        <img src="${post.productImage}" alt="${post.productName}">
    </div>
  <div class="product-info">
    <h2>${post.productName}</h2>
    <p class="price">${post.productPrice}원</p>
    <button class="btn-cart" onclick="addToCart('${post.productid}')">장바구니</button>
    <button class="btn-buy" onclick="buyNow('${post.productid}')">바로구매</button>
</div>

</div>

<!-- 고정 탭 메뉴 -->
<div class="tab-menu">
    <a href="#product-detail">상품 상세</a>
    <a href="#purchase-info">구매 안내</a>
    <a href="#reviews">리뷰</a>
</div>

<!-- 상세, 구매 안내, 리뷰 -->
<div id="product-detail" class="section">
    <h2>상품 상세</h2>
    <p>${post.productInfo}</p>
</div>

<div id="purchase-info" class="section">
    <h2>구매 안내</h2>
    <ul>
        <li>배송비: 3,000원 (50,000원 이상 무료)</li>
        <li>교환/환불: 상품 수령 후 7일 이내 가능</li>
    </ul>
</div>

<div id="reviews" class="section">
    <h2>리뷰</h2>

    <!-- 리뷰 목록 (먼저 보여주기) -->
    <c:choose>
        <c:when test="${not empty reviewList}">
            <c:forEach var="review" items="${reviewList}">
                <div class="review-item">
                    <p><strong>${review.userid}</strong></p>
                    <p>
                        <c:forEach var="i" begin="1" end="${review.rating}">&#9733;</c:forEach>
                        <c:forEach var="i" begin="${review.rating + 1}" end="5">&#9734;</c:forEach>
                    </p>
                    <p>${review.reviewText}</p>
                    <p><small>${review.createdAt}</small></p>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>아직 등록된 리뷰가 없습니다. 첫 리뷰를 남겨보세요!</p>
        </c:otherwise>
    </c:choose>

    <!-- 리뷰 작성 (목록 아래) -->
    <h3>리뷰 작성하기</h3>
    <c:if test="${not empty sessionScope.user}">
        <form action="/post/review.do" method="post" class="review-form">
            <input type="hidden" name="userid" value="${sessionScope.user.userid}">
            <input type="hidden" name="productid" value="${post.productid}">

            <div class="rating-stars">
                <input type="hidden" name="rating" id="ratingValue" value="0">
                <span class="star" data-value="1">&#9734;</span>
                <span class="star" data-value="2">&#9734;</span>
                <span class="star" data-value="3">&#9734;</span>
                <span class="star" data-value="4">&#9734;</span>
                <span class="star" data-value="5">&#9734;</span>
            </div>

            <textarea name="reviewText" placeholder="리뷰를 작성하세요."></textarea><br>
            <button type="submit">리뷰 등록</button>
        </form>
    </c:if>

    <c:if test="${empty sessionScope.user}">
        <p><a href="/member/login.do">로그인</a> 후 리뷰를 작성할 수 있습니다.</p>
    </c:if>
</div>

<!-- 스크립트 -->
<script>
console.log("스크립트 로드 확인!"); // 맨 위에 이거 추가해서 F12 콘솔로 확인
    // 부드러운 스크롤
    document.querySelectorAll('.tab-menu a').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
        });
    });

    // 별 클릭
    document.querySelectorAll('.star').forEach(function(star) {
        star.addEventListener('click', function() {
            let rating = this.getAttribute('data-value');
            document.getElementById('ratingValue').value = rating;
            updateStars(rating);
        });
    });

    function updateStars(rating) {
        document.querySelectorAll('.star').forEach(function(star, index) {
            star.innerHTML = (index < rating) ? '&#9733;' : '&#9734;';
        });
    }

 // 장바구니
    function addToCart(productid) {
        console.log("장바구니에 담을 상품 ID: " + productid); // 콘솔 확인용
        $.ajax({
            type: "GET", 
            url: "/post/addToCart.do",
            data: { productid: productid, action: 'add' }, // Form 방식
            success: function(response) {
                alert(response); // 서버가 보낸 응답 메세지
            },
            error: function(xhr, status, error) {
                console.error("장바구니 에러:", error); // 콘솔에 에러 확인
                alert("장바구니 추가 실패: " + error);
            }
        });
    }



    function buyNow(productid) {
        alert("구매 기능 준비 중입니다.");
    }
</script>

<%@ include file="../fragments/footer.jsp" %>
</body>
</html>
