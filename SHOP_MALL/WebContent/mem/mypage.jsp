<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file="../fragments/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="../css/MyP.css">

<style>
/* ---------------------------------------
   1) 상단 프로필 컨테이너 (가로 배치)
---------------------------------------- */
/* 프로필 영역을 감싸는 컨테이너 */
.mypage-container {
    width: 1200px;
    margin: 0 auto;
    padding: 20px 0;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 프로필 상단 영역 (좌우로 배치) */
.profile-top-container {
    display: flex;
    justify-content: space-between; /* 왼쪽/오른쪽 공간 분리 */
    align-items: center;            /* 수직 가운데 정렬 */
    padding: 10px 0 20px;
    border-bottom: 1px solid #ccc;
}

/* 왼쪽: 사용자명, 버튼 */
.profile-left {
    display: flex;
    align-items: center;
}

.profile-info {
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    justify-content: center;
}

.username {
    font-size: 1.2rem;
    font-weight: 600;
    margin-bottom: 8px;
}

/* 프로필 변경/로그아웃 버튼 */
.profile-buttons {
    display: flex;
    gap: 10px;
}

.profile-buttons button {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    background-color: #f2f2f2;
    cursor: pointer;
    font-size: 0.9rem;
}

.profile-buttons button:hover {
    background-color: #e9e9e9;
}

/* 오른쪽: 통계 박스 */
.profile-right {
    display: flex;
    align-items: center;
}

.status-box {
    display: flex;
    gap: 40px; /* 통계 아이템 간격 */
}

.status-box .item {
    text-align: center;
}

.status-box .count {
    font-size: 1.2rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 5px;
}

.status-box .desc {
    font-size: 0.9rem;
    color: #777;
}

/* ---------------------------------------
   2) 메인 영역 (좌측 메뉴 + 우측 콘텐츠)
---------------------------------------- */
.mypage-two-col-container {
    /* 2개 컬럼을 가로로 배치하기 위한 Flex 컨테이너 */
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    width: 1200px;
    margin: 0 auto;
    padding-bottom: 30px; /* 아래쪽 여유 */
    font-family: 'Noto Sans KR', sans-serif;
}

/* 왼쪽 컬럼: 세로형 메뉴 */
.left-col {
    width: 250px;
    border-right: 1px solid #eee;
    padding-right: 20px;
    box-sizing: border-box;
}

/* 쇼핑정보 / 고객센터 타이틀 */
.left-col .mypage-submenu h6 {
    margin-top: 20px;
    margin-bottom: 10px;
    font-weight: bold;
    font-size: 1rem;
}

/* 세로형 메뉴 (ul) */
.left-col .mypage-submenu ul {
    list-style: none;
    margin: 0 0 20px 0;
    padding: 0;
}

/* 메뉴 항목(li) */
.left-col .mypage-submenu li {
    margin-bottom: 10px;
}

/* 메뉴 링크 */
.left-col .mypage-submenu a {
    text-decoration: none;
    color: #333;
    font-size: 0.95rem;
}

.left-col .mypage-submenu a:hover {
    color: #007bff;
}

/* 오른쪽 컬럼: 메인 콘텐츠 */
.right-col {
    flex: 1;
    padding-left: 30px;
    box-sizing: border-box;
}

/* 각 섹션 구분 */
.content-section {
    margin-bottom: 50px;
}

/* 테이블 예시 스타일 */
.order-box table {
    width: 100%;
    border-collapse: collapse;
}

.order-box th, .order-box td {
    border: 1px solid #eee;
    padding: 10px;
    text-align: center;
}

.order-box th {
    background-color: #f9f9f9;
}
</style>

<!-- 1) 상단 프로필 영역 -->
<div class="mypage-container">
    <div class="profile-top-container">
        <!-- 왼쪽: 프로필 이미지 + 사용자명 + 버튼 -->
         <div class="profile-info">
                <div class="username">${sessionScope.user.name}님, 반가워요!</div>
                <div class="profile-buttons">
                    <button class="info-btn">회원정보</button>
                    <button class="logout-btn">비밀번호 수정</button>
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
	               <li><a href="#cart">장바구니</a></li>
	               <li><a href="#likes">좋아요</a></li>
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



<%@ include file="../fragments/footer.jsp" %>