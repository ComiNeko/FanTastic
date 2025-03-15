<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
</head>

<body>
<div id="mypage">
    <!-- 1) 상단 프로필 영역 -->
    <div class="mypage-container">
        <div class="profile-top-container">
            <!-- 왼쪽: 프로필 이미지 + 사용자명 + 버튼 -->
            <div class="profile-info">
                <div class="username">${sessionScope.user.name}님, 반가워요!</div>
                <div class="profile-buttons">
                    
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
    <div id="mypage-content">
        
        <form action="/member/updateMyInfopro.do" method="post">
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
                ${sessionScope.user.userid}
            </span>
        </div>
        
        <!-- 이메일 ('수정불가'로 합시다! ) -->
        <div class="form-row">
            <label for="email">이메일</label>
            <span class="read-only-text">
                ${sessionScope.user.email}
            </span>
        </div>
        
        <!-- 비밀번호 변경 창으로 이동 -->
        <div class="form-row">
		        <label for="newPassword">비밀번호</label>
		        <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/updateMyPw.do';">
		    비밀번호 수정
				</button>
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
		    <input type="text" id="address" name="address" value="${address}">
		    <button type="button" id="findAddressBtn">주소 찾기</button>
		</div>
	
		<!-- 상세 주소 수정 -->
		<div class="form-row">
		    <label for="detailAddress">상세 주소</label>
		    <input type="text" id="detailAddress" name="detailAddress" value="${detailAddress}">
		</div>
        
        <!-- 버튼 그룹 -->
        <div id="mypage-submit-btns">
            <button type="submit" id="mypage-submit-btn">수정하기</button>
            <button type="button" id="mypage-cancel-btn"
                    onclick="location.href='${pageContext.request.contextPath}/member/mypage.do';">
                취소
            </button>
        </div>
        </form>
    </div>
</div>
</body>
<script>
		document.getElementById("findAddressBtn").addEventListener("click", function(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		            document.getElementById("address").value = data.address;
		        }
		    }).open();
		});   
   
</script>

<%@ include file="../fragments/footer.jsp" %>

