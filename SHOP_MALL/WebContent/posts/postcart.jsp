<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.PostVo" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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

<%
    HttpSession sessionObj = request.getSession(false);
    boolean isLoggedIn = (sessionObj != null && sessionObj.getAttribute("user") != null);
    List<PostVo> cartList = (List<PostVo>) request.getAttribute("cartList");
%>

<div class="cart-container">
    <h2 class="cart-title">장바구니</h2>

    <%
        if (cartList == null || cartList.isEmpty()) {
    %>
        <!-- 장바구니가 비었을 때 -->
        <div class="empty-cart">
            <img src="${pageContext.request.contextPath}/img/cart.png" alt="장바구니 비었음">
            <p>장바구니가 비어있어요!</p>
            <p>다양한 상품을 구경하고<br> 나에게 맞는 상품을 담아보세요!</p>
            <a href="postsellinglist.jsp" class="browse-products-btn">상품 구경하러 가기</a>
        </div>
    <%
        } else {
    %>
        <!-- 장바구니에 상품이 있을 때 -->
        <ul class="cart-items">
            <c:forEach var="item" items="${cartList}">
                <li class="cart-item">
                    <img src="${pageContext.request.contextPath}/uploads/${item.productImage}" alt="${item.productName}">
                    <div class="cart-item-info">
                        <h3>${item.productName}</h3>
                        <p>가격: <span class="cart-item-price">${item.productPrice}원</span></p>
                    </div>
                    <form action="postcart.do?action=remove" method="post">
                        <input type="hidden" name="cartid" value="${item.productid}">
                        <button type="submit" class="remove-cart-btn">삭제</button>
                    </form>
                </li>
            </c:forEach>
        </ul>
    <%
        }
    %>
</div>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
