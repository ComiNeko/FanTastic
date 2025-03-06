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
            margin: 0;
            padding: 0;
        }

        .sidebar {
            width: 200px;
            background-color: #f5f5f5;
            padding: 20px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
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
    </style>
</head>
<body>

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
        <div class="product" id="product-list"></div>
    </div>

    <script>
        // 카테고리별 상품 목록
        const allProducts = {
            "키링": [
                { name: "귀여운 고양이 키링", price: "5,000원", description: "귀여운 고양이 모양의 키링", image: "https://via.placeholder.com/150x100.png?text=고양이+키링" },
                { name: "패션 캐릭터 키링", price: "7,000원", description: "유명 캐릭터 디자인의 키링", image: "https://via.placeholder.com/150x100.png?text=패션+캐릭터+키링" },
                { name: "한정판 디즈니 키링", price: "10,000원", description: "디즈니 한정판 키링", image: "https://via.placeholder.com/150x100.png?text=디즈니+키링" },
                { name: "반짝이 키링", price: "6,500원", description: "반짝이는 디자인의 키링", image: "https://via.placeholder.com/150x100.png?text=반짝이+키링" },
                { name: "캐주얼 스타일 키링", price: "4,500원", description: "심플한 캐주얼 스타일 키링", image: "https://via.placeholder.com/150x100.png?text=캐주얼+스타일+키링" },
                { name: "심플한 키링", price: "3,000원", description: "간결하고 심플한 디자인", image: "https://via.placeholder.com/150x100.png?text=심플한+키링" },
                { name: "핸드메이드 키링", price: "8,000원", description: "수제 손으로 만든 키링", image: "https://via.placeholder.com/150x100.png?text=핸드메이드+키링" },
                { name: "고급스러운 키링", price: "12,000원", description: "고급스러운 소재의 키링", image: "https://via.placeholder.com/150x100.png?text=고급스러운+키링" },
                { name: "귀여운 동물 키링", price: "4,800원", description: "귀여운 동물 모양의 키링", image: "https://via.placeholder.com/150x100.png?text=동물+키링" },
                { name: "일러스트 키링", price: "6,000원", description: "일러스트 디자인 키링", image: "https://via.placeholder.com/150x100.png?text=일러스트+키링" },
                { name: "나만의 키링", price: "5,500원", description: "나만의 특별한 키링", image: "https://via.placeholder.com/150x100.png?text=나만의+키링" },
                { name: "레트로 키링", price: "7,500원", description: "레트로 느낌의 키링", image: "https://via.placeholder.com/150x100.png?text=레트로+키링" },
                { name: "꽃무늬 키링", price: "3,500원", description: "꽃무늬 디자인의 키링", image: "https://via.placeholder.com/150x100.png?text=꽃무늬+키링" },
                { name: "애니메이션 캐릭터 키링", price: "9,000원", description: "애니메이션 캐릭터 키링", image: "https://via.placeholder.com/150x100.png?text=애니+캐릭터+키링" },
                { name: "테디베어 키링", price: "5,200원", description: "귀여운 테디베어 키링", image: "https://via.placeholder.com/150x100.png?text=테디베어+키링" },
                { name: "미니멀 키링", price: "4,000원", description: "미니멀한 스타일의 키링", image: "https://via.placeholder.com/150x100.png?text=미니멀+키링" },
                { name: "트렌디 키링", price: "6,000원", description: "트렌디한 디자인 키링", image: "https://via.placeholder.com/150x100.png?text=트렌디+키링" },
                { name: "디즈니 캐릭터 키링", price: "8,500원", description: "디즈니 캐릭터 디자인 키링", image: "https://via.placeholder.com/150x100.png?text=디즈니+캐릭터+키링" },
                { name: "감성 키링", price: "7,200원", description: "감성적인 디자인의 키링", image: "https://via.placeholder.com/150x100.png?text=감성+키링" },
                { name: "실버 키링", price: "10,000원", description: "실버 재질의 고급 키링", image: "https://via.placeholder.com/150x100.png?text=실버+키링" }
            ]
        };

        // 카테고리 선택 시 상품을 보여주는 함수
        function showProducts(category) {
            let productContainer = document.getElementById("product-list");
            productContainer.innerHTML = ""; // 기존 내용 초기화

            // 선택한 카테고리의 상품 가져오기
            let selectedProducts = allProducts[category] || [];

            // 20개 미만의 제품이 있으면 기본 상품으로 채우기
            while (selectedProducts.length < 20) {
                selectedProducts.push({ name: "기본 상품", price: "1,000원", description: "기본 상품입니다", image: "https://via.placeholder.com/150x100.png?text=기본+상품" });
            }

            // 선택한 카테고리의 제품을 화면에 표시
            selectedProducts.slice(0, 20).forEach(item => {
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

        // 페이지 로딩 시 "키링" 카테고리 제품을 기본으로 표시
        window.onload = function () {
            showProducts("키링");
        };
    </script>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
