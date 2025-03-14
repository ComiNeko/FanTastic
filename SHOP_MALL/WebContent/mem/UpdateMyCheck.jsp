<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">


<body>
<div id="mypage">
    <!-- 1) 상단 프로필 영역 -->
    <div class="mypage-container">
        <div class="profile-top-container">
            <!-- 왼쪽: 프로필 이미지 + 사용자명 + 버튼 -->
            <div class="profile-info">
                <div class="username">${sessionScope.user.name}님, 반가워요!</div>
                <div class="profile-buttons">
                    <!-- 작가 등록 버튼 (폼 분리) -->
                    <form action="/member/authorinsert.do" method="get" style="display:inline;">
                        <button type="submit" class="auth-btn">작가등록</button>
                    </form>

                    <!-- 회원 정보 수정 -->
                    <button class="info-btn" onclick="location.href='/admin/editProfile.do'">
                        회원정보
                    </button>

                    <!-- 비밀번호 수정 -->
                    <button class="logout-btn" onclick="location.href='/member/updateMyPw.do'">
                        비밀번호 수정
                    </button>
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
    		
    		   <!-- 우측 메인 컨텐츠 -->
    <div id="mypage">
    <h2>현재 비밀번호 확인</h2>
    <form id="checkCurrentPwdForm" action="<%=request.getContextPath()%>/member/updatecheckPw.do" method="post">
        <div class="signup-form-group">
            <label for="currentPassword">현재 비밀번호</label>
            <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호 입력" required maxlength="25">
            <span class="error-message" id="err-currentPwd"></span>
        </div>
        <button type="submit">확인</button>
    </form>
    <% 
        String errorMsg = (String) request.getAttribute("errorMsg");
        if(errorMsg != null) { 
    %>
        <p style="color:red;"><%= errorMsg %></p>
    <% } %>
</div>
</div>

<script>
    
</script>

<%@ include file="../fragments/footer.jsp" %>