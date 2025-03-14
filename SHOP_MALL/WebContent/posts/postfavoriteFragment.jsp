<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:forEach var="item" items="${favoriteList}">
    <div class="favorite-item" id="favitem_${item.productid}">
        <img src="${item.productimage}" alt="${item.productname}">
        <div class="product-name">${item.productname}</div>
        <div class="product-price">${item.productprice}원</div>
    </div>
</c:forEach>