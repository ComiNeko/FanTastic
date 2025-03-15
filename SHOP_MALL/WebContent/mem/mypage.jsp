<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page session="true"%>
<%@ include file="../fragments/header.jsp"%>

<link rel="stylesheet" href="../css/mypage.css">

<script>
	// JSTL을 이용한 서버 결과를 자바스크립트로
	<c:if test="${isAuthorExist == true}">
	alert('이미 작가입니다.');
	</c:if>
</script>

<div id="mypage">
	<!-- 1) 상단 프로필 영역 -->
	<div class="mypage-container">
		<div class="profile-top-container">
			<!-- 왼쪽: 프로필 이미지 + 사용자명 + 버튼 -->
			<div class="profile-info">
				<div class="username">${sessionScope.user.name}님,반가워요!</div>
				<div class="profile-buttons">
					<c:if test="${sessionScope.user.role == 'Admin'}">
						<!-- 작가 등록 버튼 -->
						<button class="auth-btn"
							onclick="location.href='/member/authorinsert.do'">작가등록</button>

						<!-- 작가 정보 수정 -->
						<button class="info-btn"
							onclick="location.href='/admin/editProfile.do'">작가정보수정</button>

						<!-- 회원 정보 수정 -->
						<button class="info-btn"
							onclick="location.href='/admin/memberEdit.do'">회원정보수정</button>

						<!-- 등록 상품 수정 -->
						<button class="product-btn"
							onclick="location.href='/post/mysellinglist.do'">등록상품 수정</button>

						<!-- 비밀번호 수정 -->
						<button class="logout-btn"
							onclick="location.href='/member/updateMyPw.do'">비밀번호 수정</button>
					</c:if>

				</div>
			</div>

			<!-- 오른쪽: 통계 정보 (예시) -->
			<div class="profile-right">
				<div class="status-box">
					<div class="item">
						<div class="count">0</div>
						<div class="desc">최근 주문/배송중</div>
					</div>
					<div class="item">
						<div class="count">0</div>
						<div class="desc">작성한 리뷰</div>
					</div>
					<div class="item">
						<div class="count">0</div>
						<div class="desc">좋아요 한 상품</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 오른쪽: 통계 정보 (예시) -->
<div class="profile-right">
	<div class="status-box">
		<div class="item">
			<div class="count">0</div>
			<div class="desc">최근 주문/배송중</div>
		</div>
		<div class="item">
			<div class="count">0</div>
			<div class="desc">작성한 리뷰</div>
		</div>
		<div class="item">
			<div class="count">0</div>
			<div class="desc">좋아요 한 상품</div>
		</div>
	</div>
</div>
</div>
</div>

<!-- 2) 좌우 2컬럼 레이아웃 -->
<div class="mypage-two-col-container">

	<!-- 왼쪽 컬럼 (메뉴) -->
	<div class="left-col">
		<div class="mypage-submenu">
			<h6>쇼핑정보</h6>
			<ul>
				<li><a href="#orderHistory">구매내역</a></li>
				<li><a href="/mycart.do">장바구니</a></li>
				<li><a href="/post/mylike.do?page=1&pageSize=10">좋아요</a></li>
				<li><a href="#recentlyViewed">최근 본</a></li>
			</ul>
			<h6>고객센터</h6>
			<ul>
				<li><a href="#faq">FAQ</a></li>
			</ul>
		</div>
	</div>

	<!-- 오른쪽 컬럼 (메인 콘텐츠) -->
	<div class="right-col">
		<!-- 예시: 구매내역 섹션 -->
		<section id="orderHistory" class="content-section">
			<h5>주문 목록</h5>
			<div class="order-box">
				<table>
					<thead>
						<tr>
							<th>주문번호</th>
							<th>주문일자</th>
							<th>상품정보</th>
							<th>옵션</th>
							<th>배송상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>999503</td>
							<td>2025-03-09</td>
							<td>김간 2000 오리지널 티셔츠</td>
							<td>XL / 블랙</td>
							<td>배송중</td>
						</tr>
						<!-- 실제 DB 연동 시 c:forEach 등을 사용 -->
					</tbody>
				</table>
			</div>
		</section>

		<!-- 다른 섹션 (장바구니, 좋아요, 최근 본, FAQ 등)은
	             아래와 같은 형태로 이어서 작성하기
	             <section id="cart" class="content-section">...</section> 
	             <section id="likes" class="content-section">...</section>
	             <section id="faq" class="content-section">...</section> 
	        -->

	</div>
</div>
</div>

<!-- 왼쪽 컬럼 (메뉴) -->
<div class="left-col">
	<div class="mypage-submenu">
		<h6>쇼핑정보</h6>
		<ul>
			<li><a href="#orderHistory">구매내역</a></li>
			<li><a href="/posts/postcart.jsp">장바구니</a></li>
			<li><a href="/heart.do">좋아요</a></li>
			<li><a href="#recentlyViewed">최근 본</a></li>
		</ul>
		<h6>고객센터</h6>
		<ul>
			<li><a href="#faq">FAQ</a></li>
		</ul>
	</div>
</div>

<!-- 오른쪽 컬럼 (메인 콘텐츠) -->
<div class="right-col">
	<!-- 예시: 구매내역 섹션 -->
	<section id="orderHistory" class="content-section">
		<h5>주문 목록</h5>
		<div class="order-box">
			<table>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문일자</th>
						<th>상품정보</th>
						<th>옵션</th>
						<th>배송상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>999503</td>
						<td>2025-03-09</td>
						<td>김간 2000 오리지널 티셔츠</td>
						<td>XL / 블랙</td>
						<td>배송중</td>
					</tr>
					<!-- 실제 DB 연동 시 c:forEach 등을 사용 -->
				</tbody>
			</table>
		</div>
	</section>

	<!-- 다른 섹션 (장바구니, 좋아요, 최근 본, FAQ 등)은

                 아래와 같은 형태로 이어서 작성하기
                 <section id="cart" class="content-section">...</section> 
                 <section id="likes" class="content-section">...</section>
                 <section id="faq" class="content-section">...</section> 
            -->
</div>
</div>
</div>

<%@ include file="../fragments/footer.jsp"%>
