<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp"%>

<link rel="stylesheet" href="/css/postcart.css">

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
</head>
<body>

<div class="cart-container">
    <h2 class="cart-title">장바구니</h2>

    <c:choose>
        <c:when test="${empty cartList}">
            <!-- 장바구니 비었을 때 -->
            <div class="empty-cart">
                <img src="${pageContext.request.contextPath}/img/cart.png" alt="장바구니 비었음">
                <p>장바구니가 비어있어요!</p>
                <p>다양한 상품을 구경하고<br> 나에게 맞는 상품을 담아보세요!</p>
                <a href="/post/postsellinglist.do?category=1" class="browse-products-btn">상품 구경하러 가기</a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- 장바구니에 상품 있을 때 -->
            <ul class="cart-items">
                <c:forEach var="item" items="${cartList}">
                    <li class="cart-item">
                        <img src="${pageContext.request.contextPath}${item.productImage}" alt="${item.productName}">
                        <div class="cart-item-info">
                            <h3>${item.productName}</h3>
                            <p>가격: <span class="cart-item-price">${item.productPrice}원</span></p>
                        	<p>수량: <span class="cart-item-quantity">${item.quantity}개</span></p>
                        </div>
                        <form action="postcart.do?action=remove" method="post">
                            <!-- cartid로 넘기기 -->
                            <input type="hidden" name="cartid" value="${item.cartid}">
                            <button type="submit" class="remove-cart-btn">삭제</button>
                        </form>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
