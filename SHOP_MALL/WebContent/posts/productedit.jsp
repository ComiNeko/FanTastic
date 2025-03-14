<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 마이페이지에서 상품 수정하는 기능입니다 -->
<h2>상품 수정</h2>

<!-- 상품이 없을 경우 메시지 출력 -->
<c:if test="${empty product}">
    <p style="color: red; font-weight: bold;">상품을 등록하지 않았습니다.</p>
    <button onclick="location.href='/post/mysellinglist.do'">목록으로 돌아가기</button>
</c:if>

<!-- 상품이 있을 경우 수정 폼 표시 -->
<c:if test="${not empty product}">
    <form action="/post/productupdate.do" method="post">
        <input type="hidden" name="productid" value="${product.productid}">

        <label>상품명</label>
        <input type="text" name="productName" value="${product.productName}" required>

        <label>가격</label>
        <input type="number" name="productPrice" value="${product.productPrice}" required>

        <label>재고</label>
        <input type="number" name="productStock" value="${product.productStock}" required>

        <label>상품 설명</label>
        <textarea name="productInfo" required>${product.productInfo}</textarea>

        <label>상품 이미지</label>
        <input type="text" name="productImage" value="${product.productImage}" required>

        <button type="submit">수정 완료</button>
    </form>
</c:if>
