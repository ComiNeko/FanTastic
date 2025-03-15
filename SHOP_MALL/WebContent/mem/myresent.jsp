<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ include file="../fragments/header.jsp"%>
<input type="hidden" name="recentViewId" value="${rv.recentViewId}">

<link rel="stylesheet" href="../css/mypage.css">


<style>
#mypage .profile-buttons {
    display: flex;
    flex-direction: column; /* 줄 나눠서 배치 */
    gap: 10px; /* 줄 간격 */
}

/* 각 버튼 라인 */
#mypage .button-row {
    display: flex;
    gap: 10px; /* 버튼 사이 간격 */
}


/* ===== disabled 상태일 때 따로 스타일 지정 ===== */
#mypage .info-btn:disabled {
    background-color: #000000; /* 동일하게 유지 */
    color: #ffffff;
    opacity: 1; /* 흐릿해지는 것 방지 */
    cursor: not-allowed; /* 또는 pointer로 변경 가능 */
}

/* ===== 회원정보 수정, 비밀번호 수정 버튼 (작게 조정) ===== */
#mypage .info-btn {
    padding: 6px 12px; /* 기존 10px 16px → 줄임 */
    background-color: #000000;
    color: #ffffff;
    border: none;
    border-radius: 3px; /* 기존 4px → 살짝 더 각지게 */
    cursor: pointer;
    font-size: 0.85rem; /* 기존 0.9rem → 폰트 크기 살짝 줄임 */
}

#mypage .info-btn:hover:enabled {
    background-color: #333333;
}

#mypage .info-btn:disabled {
    opacity: 1;
    cursor: not-allowed;
}

/* ===== admin 버튼도 동일하게 ===== */
#mypage .admin-btn {
    padding: 10px 16px;
    background-color: #f5f5f5;
    color: #333333;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
}

/* ===== 작가 관련 버튼 ===== */
#mypage .admin-btn {
    padding: 6px 12px; /* 기존 10px 16px → 동일하게 줄임 */
    background-color: #f5f5f5;
    color: #333333;
    border: 1px solid #ddd;
    border-radius: 3px;
    cursor: pointer;
    font-size: 0.85rem; /* 폰트 크기 작게 */
}

#mypage .admin-btn:hover:enabled {
    background-color: #e0e0e0;
}

#mypage .admin-btn:disabled {
    opacity: 1;
    cursor: not-allowed;
}





.recent-views-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 16px;
    margin: 20px;
}
.recent-view-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 12px;
    text-align: center;
}
.recent-view-card img {
    width: 100%;
    height: auto;
    border-radius: 4px;
    margin-bottom: 8px;
}
.recent-view-card .product-name {
    font-weight: bold;
    margin-bottom: 4px;
}
.recent-view-card .product-price {
    color: #f00;
    margin-bottom: 8px;
}
.recent-view-card .remove-btn {
    background-color: #ccc;
    border: none;
    padding: 6px 10px;
    cursor: pointer;
    border-radius: 4px;
}
.recent-view-card .remove-btn:hover {
    background-color: #aaa;
}
</style>


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
                <div class="username">${sessionScope.user.name}님, 반가워요!</div>
                <div class="profile-buttons">
				    <!-- 첫 번째 줄: 회원 버튼 -->
				    <div class="button-row member-buttons">
				        <button class="info-btn" onclick="location.href='/member/updateMyInfo.do'">회원정보 수정</button>
				        <button class="info-btn" onclick="location.href='/member/updatecheck.do'">비밀번호 수정</button>
				    </div>
				
				    <!-- 두 번째 줄: 관리자 버튼 (Admin 권한일 때만 노출) -->
				    <c:if test="${sessionScope.user.role == 'Admin'}">
				        <div class="button-row admin-buttons">
				            <button class="admin-btn" onclick="location.href='/member/authorinsert.do'">작가등록</button>
				            <button class="admin-btn" onclick="location.href='/admin/editProfile.do'">작가정보수정</button>
				            <button class="admin-btn" onclick="location.href='/post/mysellinglist.do'">등록상품 수정</button>
				        </div>
				    </c:if>
				    
				</div> <!-- "profile-buttons" -->
            </div> <!-- "profile-info" -->>


<!-- 최근 본 상품 목록 -->
<h2>최근 본 상품</h2>

<div class="recent-views-container">
    <c:forEach var="rv" items="${recentViews}">
        <div class="recent-view-card">
            <img src="${rv.productImage}" alt="상품 이미지" />
            <div class="product-name">${rv.productName}</div>
            <div class="product-author">${rv.authorName}</div>
            <div class="product-price">${rv.productPrice}원</div>

            <form action="${pageContext.request.contextPath}/recentView/remove.do" method="post" style="margin:0;">
                
                <input type="hidden" name="recent_view_id" value="${rv.recent_view_id}">
                <button type="submit" class="remove-btn">삭제</button>
            </form>
        </div>
    </c:forEach>
</div>

    </div> <!-- mypage-two-col-container(left-col + right-col) -->
</div>    


<%@ include file="../fragments/footer.jsp"%>
