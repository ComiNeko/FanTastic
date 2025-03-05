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
/* 마이페이지 컨테이너 */
#mypage-container {
    width: 80%;
    margin: 0 auto;
    font-family: 'Arial', sans-serif;
}

/* 상단 네비게이션 */
#mypage-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 0;
}

#mypage-header h2 {
    font-size: 24px;
    font-weight: bold;
}

#mypage-header nav ul {
    display: flex;
    list-style: none;
    padding: 0;
}

#mypage-header nav ul li {
    margin-right: 20px;
}

#mypage-header nav ul li a {
    text-decoration: none;
    color: black;
    font-size: 16px;
}

#mypage-header nav ul li a:hover {
    text-decoration: underline;
}

/* 메인 마이페이지 섹션 */
#mypage-main {
    background-color: #000;
    color: white;
    padding: 30px;
    border-radius: 10px;
}

#mypage-user-info {
    text-align: center;
    margin-bottom: 20px;
}

#mypage-user-info h3 {
    font-size: 18px;
    margin-bottom: 5px;
}

#mypage-user-info p {
    font-size: 22px;
    font-weight: bold;
}

/* 요약 정보 섹션 */
#mypage-summary {
    display: flex;
    justify-content: space-around;
    text-align: center;
}

.summary-box {
    background-color: #333;
    padding: 20px;
    border-radius: 8px;
    width: 20%;
}

.summary-box h4 {
    font-size: 16px;
    margin-bottom: 10px;
}

.summary-box p {
    font-size: 20px;
    font-weight: bold;
}
</style>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
</head>

<body>
<div id="mypage-container">
    <!-- 상단 네비게이션 -->
    <div id="mypage-header">
        <h2>마이페이지</h2>
        <nav>
            <ul>
                <li><a href="/member/orders.do">구매내역</a></li>
                <li><a href="/member/wishlist.do">찜한 상품</a></li>
                <li><a href="/member/points.do">포인트</a></li>
                <li><a href="/member/reviews.do">나의 리뷰</a></li>
                <li><a href="/member/settings.do">계정 설정</a></li>
            </ul>
        </nav>
    </div>

    <!-- 메인 마이페이지 섹션 -->
    <div id="mypage-main">
        <div id="mypage-user-info">
            <h3>개인정보 변경</h3>
            <p><strong>${sessionScope.user.nickname}님, 반가워요 👋</strong></p>
        </div>
    </div>
    
    <!-- 구매 목록이 아래에 위치하도록 수정 -->
    <div id="mypage-orders">
        <h3>구매내역</h3>
        <table>
            <tr>
                <th>주문번호</th>
                <th>상품명</th>
                <th>주문일</th>
                <th>상태</th>
                <th>상세보기</th>
            </tr>
            <c:forEach var="order" items="${sessionScope.user.recentOrders}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.productName}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.status}</td>
                    <td><a href="/order/detail.do?orderId=${order.orderId}">보기</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>


</body>


<%@ include file="../fragments/footer.jsp" %>