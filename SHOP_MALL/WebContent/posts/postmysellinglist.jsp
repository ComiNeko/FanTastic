<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>내가 등록한 상품 목록</h2>

<!-- 디버깅: productList가 존재하는지 확인 -->
<p>상품 리스트 존재 여부: ${not empty productList}</p>

<!-- 상품이 없을 경우 메시지 출력 -->
<c:choose>
    <c:when test="${empty productList}">
        <p style="color: red; font-weight: bold;">등록된 상품이 없습니다.</p>
        <button onclick="location.href='/post/postsellinglist.do'">상품 등록하러 가기</button>
    </c:when>
    <c:otherwise>
        <table border="1">
            <thead>
                <tr>
                    <th>상품 ID</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>재고</th>
                    <th>수정</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${productList}">
                    <tr>
                        <td>${product.productid}</td>
                        <td>${product.productName}</td>
                        <td>${product.productPrice}</td>
                        <td>${product.productStock}</td>
                        <td>
                            <button onclick="location.href='/post/productedit.do?productid=${product.productid}'">수정</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
