<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            text-align: left;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .back-btn {
            background-color: #6c757d;
        }
        .back-btn:hover {
            background-color: #5a6268;
        }
    </style>
    <script>
        function redirectToMyPage() {
            alert("상품 수정이 완료되었습니다.");
            window.location.href = "/mypage.do"; // 마이페이지로 이동
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>상품 수정</h2>

        <c:choose>
    <c:when test="${empty product}">
        <p style="color: red; font-weight: bold;">상품을 등록하지 않았습니다.</p>
        <button class="back-btn" onclick="location.href='/post/mysellinglist.do'">목록으로 돌아가기</button>
    </c:when>
    <c:otherwise>
        <form action="/post/productupdate.do" method="post" onsubmit="redirectToMyPage()">
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
    </c:otherwise>
</c:choose>

    </div>
</body>
</html>
