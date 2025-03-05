<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/MyP.css">


<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
</head>

<body>
<!-- 최상위 래퍼 -->
<div id="myInfo-page">
    
   <!-- 좌측 사이드바 -->
    <div id="mypage-sidebar">
        <h3>마이페이지</h3>
        <ul>
            <li><a href="/member/orders.do">구매내역</a></li>
            <li><a href="/member/wishlist.do">좋아요</a></li>
            <li><a href="/member/cart.do">장바구니</a></li>
            <li><a href="/member/points.do">최근 본 상품</a></li>
            <li><a href="/member/reviews.do">レビュー</a></li>
            <li><a href="/member/updateMyInfo.do">계정 설정</a></li>
        </ul>
    </div>
    
    <!-- 우측 메인 컨텐츠 -->
    <div id="mypage-content">
        
        <!-- 상단 타이틀 -->
        <div id="mypage-title-area">
            <h2>정보수정</h2>
            <hr>
        </div>
        
        <!-- 이름 (수정 불가) -->
        <div class="form-row">
            <label>이름</label>
            <span class="read-only-text">
                ${sessionScope.user.name}
            </span>
        </div>
        
        <!-- 아이디 (수정 불가) -->
        <div class="form-row">
            <label>아이디</label>
            <span class="read-only-text">
                ${sessionScope.user.user_id}
            </span>
        </div>
        
        <!-- 이메일 (수정 후 재인증 필요) -->
        <div class="form-row">
            <label for="email">이메일</label>
            <span class="read-only-text">
                ${sessionScope.user.email}
            </span>
        </div>
        
        <!-- 비밀번호 변경 (입력하지 않으면 업데이트 안 함) -->
        <div class="form-row">
            <label for="newPassword">새 비밀번호</label>
            <input type="password"
                   id="newPassword"
                   name="newPassword"
                   placeholder="변경 시 새 비밀번호 입력">
        </div>
        <div class="form-row">
            <label for="confirmNewPassword">비밀번호 확인</label>
            <input type="password"
                   id="confirmNewPassword"
                   name="confirmNewPassword"
                   placeholder="새 비밀번호 확인">
        </div>
        
        <!-- 전화번호 수정 -->
        <div class="form-row">
            <label for="phonenumber">전화번호</label>
            <input type="text"
                   id="phonenumber"
                   name="phonenumber"
                   value="${sessionScope.user.phonenumber}">
        </div>
        
        <!-- 주소 수정 (주소찾기 버튼 포함) -->
        <div class="form-row">
            <label for="address">주소</label>
            <input type="text"
                   id="address"
                   name="address"
                   value="${sessionScope.user.address}">
            <button type="button" id="findAddressBtn">주소 찾기</button>
        </div>
        
        <!-- 버튼 그룹 -->
        <div id="mypage-submit-btns">
            <button type="submit" id="mypage-submit-btn">수정하기</button>
            <button type="button" id="mypage-cancel-btn"
                    onclick="location.href='${pageContext.request.contextPath}/member/mypage.do';">
                취소
            </button>
        </div>
    </div>
</div>
</body>
<script>
    
    // 비밀번호 확인 로직 (폼 제출 전에 확인)
    document.getElementById("mypage-submit-btn").addEventListener("click", function(e) {
        var newPwd = document.getElementById("newPassword").value.trim();
        var confirmPwd = document.getElementById("confirmNewPassword").value.trim();
        
        if(newPwd || confirmPwd) { // 둘 중 하나라도 입력된 경우
            if(newPwd !== confirmPwd) {
                e.preventDefault();
                alert("새 비밀번호와 확인이 일치하지 않습니다.");
                return false;
            }
        } 
      
      
</script>

<%@ include file="../fragments/footer.jsp" %>

