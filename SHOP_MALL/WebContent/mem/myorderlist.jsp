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
    grid-template-columns: repeat(3, 1fr); /* 3개씩 배치 */
    gap: 20px;
    padding: 20px;
}

.recent-view-card {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 16px;
    text-align: center;
    background-color: #fafafa;
    transition: transform 0.2s;
}

.recent-view-card:hover {
    transform: translateY(-5px);
}

.recent-view-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 6px;
    margin-bottom: 10px;
}

.recent-view-card .product-name {
    font-size: 1rem;
    font-weight: bold;
    margin-bottom: 5px;
}

.recent-view-card .product-author {
    font-size: 0.9rem;
    color: #555;
    margin-bottom: 8px;
}

.recent-view-card .product-price {
    color: #e60023;
    font-size: 1rem;
    font-weight: bold;
}

.remove-btn {
    margin-top: 10px;
    background-color: #ff6666;
    border: none;
    color: white;
    padding: 8px 12px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.remove-btn:hover {
    background-color: #cc0000;
}

.orderright-col {
    width: 100%;
    display: flex;
    justify-content: center;
}

.order-box {
    width: 100%;
    padding: 20px 0;       /* 위아래 여백 */
    display: flex;
    justify-content: center; /* 가운데 정렬 */
}

.order-box table {
    width: 90%;             /* 테이블 넓이 늘리기 */
    max-width: 1200px;      /* 최대 넓이 제한, 필요시 조정 가능 */
    margin: 0 auto;
    border-collapse: collapse;
    background-color: #fff; /* 테이블 배경 흰색 */
}

.order-box table th,
.order-box table td {
    padding: 15px 10px;    /* 셀 패딩 더 주기 */
    text-align: center;    /* 가운데 정렬 */
    border: 1px solid #ddd;
    font-size: 0.95rem;    /* 글자 크기 조정 가능 */
}

.order-box table th {
    background-color: #f8f8f8; /* 헤더 배경색 */
    font-weight: bold;
}

.order-box table img {
    display: block;
    margin: 0 auto;
    max-width: 80px;
    height: auto;
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
            </div> <!-- "profile-info" -->
		</div>
	</div>
<!-- 2) 좌우 2컬럼 레이아웃 -->
	<div class="mypage-two-col-container">

		<!-- 왼쪽 컬럼 (메뉴) -->
		<div class="left-col">
			<div class="mypage-submenu">
				<h6>쇼핑정보</h6>
				<ul>
					<li><a href="/member/orderlist.do">구매내역</a></li>
					<li><a href="/post/postcart.do">장바구니</a></li>
					<li><a href="/post//list.do">좋아요</a></li>
					<li><a href="/member/recentViewPage.do">최근 본</a></li>
				</ul>
				<h6>고객센터</h6>
				<ul>
					<li><a href="/member/faq.do">FAQ</a></li>
				</ul>
			</div>
		</div>		
				<!-- 최근 본 상품 목록 -->
				<!-- 오른쪽 컬럼 (메인 콘텐츠) -->
				<div class="orderright-col">
				<div class="mypage-submenu">
					<h6>구매 이력</h6>
				</div>

		<div class="recent-views-container">
	   		<table>
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>주문일자</th>
                    <th>상품정보</th>
                    <th>수량</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty orderList}">
                    <tr>
                        <td colspan="4">구매 내역이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>${order.productid}</td>
                        <td>${order.createdAt}</td>
                        <td>
                            ${order.productName}<br/>
                            <img src="${order.productImage}" alt="상품 이미지" width="100px" height="100px">
                        </td>
                        <td>${order.quantity}개</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

	</div>
</div> <!-- mypage-two-col-container(left-col + right-col) -->

</div>

<%@ include file="../fragments/footer.jsp"%>
