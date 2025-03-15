<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.MemberVo.RecentView" %>

<%@ include file="../fragments/header.jsp" %>

<!-- 최근 본 상품 카드 레이아웃 CSS -->
<style>
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

<h2>마이페이지</h2>

<!-- 최근 본 상품 목록 -->
<h2>최근 본 상품</h2>

<div class="recent-views-container">
    <c:forEach var="rv" items="${recentViews}">
        <div class="recent-view-card">
            <img src="${rv.productImage}" alt="상품 이미지" />
            <div class="product-name">${rv.productName}</div>
            <div class="product-price">${rv.productPrice}원</div>
            <!-- 삭제 버튼 -->
            <form action="${pageContext.request.contextPath}/recentView/remove.do" method="post" style="margin:0;">
                <input type="hidden" name="productId" value="${rv.productId}">
                <button type="submit" class="remove-btn">삭제</button>
            </form>
        </div>
    </c:forEach>
</div>
