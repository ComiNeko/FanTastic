<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file="../fragments/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="../css/MyP.css">

<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
</head>

<body>
<div id="mypage-container">
    <!-- 좌측 사이드바 -->
    <div id="mypage-sidebar">
        <h3>마이페이지</h3>
        <ul>
            <li><a href="/member/orders.do">구매내역</a></li>
            <li><a href="/member/wishlist.do">좋아요</a></li>
            <li><a href="/member/cart.do">장s바구니</a></li>
            <li><a href="/member/points.do">최근 본 상품</a></li>
            <li><a href="/member/reviews.do">レビュー</a></li>
        </ul>
    </div>
    <div id="mypage-sidebar">
        <ul>
            <li><a href="/member/updateMyInfo.do">계정 설정</a></li>
            <li><a href="/member/updateMyPw.do">비밀번호 변경</a></li>
        </ul>
    </div>

    <!-- 우측 메인 컨텐츠 -->
    <div id="mypage-content">

        <!-- 프로필 및 요약 정보 컨테이너 -->
        <div id="mypage-summary-container">
            <div id="mypage-summary-box">
                <div id="mypage-profile-section">
                    
                    <p><strong>${sessionScope.user.name}님, 반가워요 👋</strong></p>
                </div>
                <div id="mypage-summary">
                    <div class="summary-box">
                        <h4>리뷰</h4>
                        <p>0 / 0 개</p>
                    </div>
                    <div class="summary-box">
                        <h4>장바구니</h4>
                        <p>0 개</p>
                    </div>
                    <div class="summary-box">
                        <h4>찜한 상품</h4>
                        <p>0 개</p>
                    </div>
                    <div class="summary-box">
                        <h4>포인트</h4>
                        <p>0 P</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- 주문 내역 섹션 -->
        <div id="mypage-orders">
            <h3>주문 내역</h3>
        
        </div>
    </div>
</div>

</body>


<%@ include file="../fragments/footer.jsp" %>