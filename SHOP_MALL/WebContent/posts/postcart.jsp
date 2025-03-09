<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.PostVo" %>
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
        <h2>장바구니</h2>
        
        <%
            List<PostVo> cartList = (List<PostVo>) request.getAttribute("cartList");
            if (cartList == null || cartList.isEmpty()) {
        %>
            <!-- 장바구니가 비어있을 때 -->
            <div class="empty-cart">
                <img src="/img/cart.png" alt="장바구니">
                <p>장바구니가 비어있어요!</p>
                <a href="/posts/postsellinglist.jsp" class="browse-button">상품 구경하러 가기</a>
            </div>
        <%
            } else {
        %>
            <!-- 장바구니에 상품이 있을 때 -->
            <div class="cart-items">
                <table>
                    <tr>
                        <th>상품 이미지</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>삭제</th>
                    </tr>
                    <% for (PostVo post : cartList) { %>
                        <tr>
                            <td><img src="uploads/<%= post.getProductImage() %>" alt="<%= post.getProductName() %>"></td>
                            <td><%= post.getProductName() %></td>
                            <td><%= post.getProductPrice() %>원</td>
                            <td><%= post.getQuantity() %></td>
                            <td>
                                <a href="/postcart.do?action=remove&cartid=<%= post.getCartid() %>" class="remove-btn">삭제</a>
                            </td>
                        </tr>
                    <% } %>
                </table>
            </div>
        <%
            }
        %>
    </div>

</body>
</html>
