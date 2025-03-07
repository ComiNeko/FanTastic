<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.PostVo" %>
<%@ include file="../fragments/header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑몰 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: row;
            margin-top: 70px;
        }

        .sidebar {
            width: 200px;
            background-color: #f5f5f5;
            padding: 20px;
            height: calc(100vh - 70px);
            position: fixed;
            left: 0;
            top: 70px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar li {
            padding: 10px;
            cursor: pointer;
            background-color: #ddd;
            margin: 5px 0;
            text-align: center;
        }

        .sidebar li:hover {
            background-color: #bbb;
        }

        .content {
            margin-left: 220px;
            padding: 20px;
            width: 100%;
        }

        .product {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
        }

        .product-item {
            width: 150px;
            height: auto;
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            background-color: #f9f9f9;
        }

        .product-item img {
            width: 100%;
            height: 100px;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .product-item p {
            margin: 5px 0;
            font-size: 14px;
            color: #333;
        }

        .product-item strong {
            font-size: 16px;
            color: #000;
            display: block;
            margin-bottom: 5px;
        }

        .product-item .price {
            font-size: 16px;
            font-weight: bold;
            color: #e74c3c;
            margin-top: 5px;
        }

        .product-item .description {
            font-size: 12px;
            color: #777;
            margin-top: 5px;
        }

        /* 🔹 글쓰기 버튼 스타일 추가 */
        .write-button-container {
            text-align: right;
            margin-bottom: 20px;
        }

        .write-button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }

        .write-button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="sidebar">
            <ul>
                <li onclick="location.href='/post/postsellinglist.do?category=1'">키링</li>
                <li onclick="location.href='/post/postsellinglist.do?category=2'">아크릴굿즈</li>
                <li onclick="location.href='/post/postsellinglist.do?category=3'">포토카드</li>
                <li onclick="location.href='/post/postsellinglist.do?category=4'">틴케이스</li>
                <li onclick="location.href='/post/postsellinglist.do?category=5'">키캡</li>
                <li onclick="location.href='/post/postsellinglist.do?category=6'">거울/핀버튼</li>
                <li onclick="location.href='/post/postsellinglist.do?category=7'">커버/클리너</li>
            </ul>
        </div>

        <div class="content">
            <h2>상품 목록</h2>

            <!-- 글쓰기 버튼 추가 -->
            <div class="write-button-container">
                <form action="postwrite.jsp" method="get">
                    <button type="submit" class="write-button">글쓰기</button>
                </form>
            </div>

            <div class="product">
                <%
                    List<PostVo> productList = (List<PostVo>) request.getAttribute("productList");
                    if (productList != null && !productList.isEmpty()) {
                        for (PostVo post : productList) {
                %>
                            <div class="product-item">
                                <img src="uploads/<%= post.getProductImage() %>" alt="<%= post.getProductName() %>">
                                <strong><%= post.getProductName() %></strong>
                                <p class="description"><%= post.getProductInfo() %></p>
                                <p class="price"><%= post.getProductPrice() %>원</p>
                            </div>
                <%
                        }
                    } else {
                %>
                        <p>게시글이 없습니다.</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
