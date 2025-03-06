<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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
            flex-direction: column; /* 기존 flex를 column으로 변경해서 header와 content가 겹치지 않도록 수정 */
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: row; /* 사이드바와 컨텐츠 나열 */
            margin-top: 70px; /* 헤더와 겹치지 않도록 수정 */
        }

        .sidebar {
            width: 200px;
            background-color: #f5f5f5;
            padding: 20px;
            height: calc(100vh - 70px); /* 헤더 높이 제외한 화면 높이 */
            position: fixed;
            left: 0;
            top: 70px; /* 헤더와 겹치지 않도록 수정 */
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
                <li onclick="showProducts('키링')">키링</li>
                <li onclick="showProducts('아크릴굿즈')">아크릴굿즈</li>
                <li onclick="showProducts('포토카드')">포토카드</li>
                <li onclick="showProducts('틴케이스')">틴케이스</li>
                <li onclick="showProducts('키캡')">키캡</li>
                <li onclick="showProducts('거울/핀버튼')">거울/핀버튼</li>
                <li onclick="showProducts('커버/클리너')">커버/클리너</li>
            </ul>
        </div>

        <div class="content">
            <h2>상품 목록</h2>

            <!-- 🔹 글쓰기 버튼 추가 -->
            <div class="write-button-container">
                <form action="postwrite.jsp" method="get">
                    <button type="submit" class="write-button">글쓰기</button>
                </form>
            </div>

            <div class="product" id="product-list"></div>
        </div>
    </div>

    <script>
        // 카테고리별 상품 목록
        const allProducts = {
            "키링": [
                { name: "귀여운 고양이 키링", price: "5,000원", description: "귀여운 고양이 모양의 키링", image: "https://via.placeholder.com/150x100.png?text=고양이+키링" },
                { name: "패션 캐릭터 키링", price: "7,000원", description: "유명 캐릭터 디자인의 키링", image: "https://via.placeholder.com/150x100.png?text=패션+캐릭터+키링" }
            ]
        };

        // 카테고리 선택 시 상품을 보여주는 함수
        function showProducts(category) {
            let productContainer = document.getElementById("product-list");
            productContainer.innerHTML = ""; // 기존 내용 초기화

            let selectedProducts = allProducts[category] || [];

            selectedProducts.forEach(item => {
                let div = document.createElement("div");
                div.className = "product-item";
                div.innerHTML = `
                    <img src="${item.image}" alt="${item.name}">
                    <strong>${item.name}</strong>
                    <p class="description">${item.description}</p>
                    <p class="price">${item.price}</p>
                `;
                productContainer.appendChild(div);
            });
        }

        // 기본 카테고리 표시
        window.onload = function () {
            showProducts("키링");
        };
    </script>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
