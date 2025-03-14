<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>내가 등록한 상품 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .edit-btn {
            background-color: #ffc107;
            color: black;
        }
        .edit-btn:hover {
            background-color: #e0a800;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .register-btn {
            background-color: #007bff;
            color: white;
            display: block;
            width: 100%;
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            text-decoration: none;
            border-radius: 5px;
        }
        .register-btn:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function confirmDelete(productId) {
            if (confirm("정말 이 상품을 삭제하시겠습니까?")) {
                window.location.href = "/post/productdelete.do?productid=" + productId;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>내가 등록한 상품 목록</h2>

        <c:choose>
            <c:when test="${empty productList}">
                <p style="color: red; text-align: center; font-weight: bold;">등록된 상품이 없습니다.</p>
                <a href="/post/postsellinglist.do" class="register-btn">상품 등록하러 가기</a>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>상품 ID</th>
                            <th>상품명</th>
                            <th>가격</th>
                            <th>재고</th>
                            <th>수정</th>
                            <th>삭제</th>
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
                                    <button class="btn edit-btn" onclick="location.href='/post/productedit.do?productid=${product.productid}'">수정</button>
                                </td>
                                <td>
                                    <button class="btn delete-btn" onclick="confirmDelete(${product.productid})">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
