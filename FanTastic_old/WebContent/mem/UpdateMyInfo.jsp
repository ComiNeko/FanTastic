<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/MyP.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

