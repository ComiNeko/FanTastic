<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file="../fragments/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="../css/MyP.css">

    <style>
    /* 전체 기본 스타일 */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
    }
    a {
        text-decoration: none;
        color: inherit;
    }
    ul, li {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    /* 상단 GNB (마이페이지 메뉴) */
    .gnb {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 40px;
        height: 60px;
        background-color: #fff;
        /* 밑줄 제거 */
        border-bottom: none; 
    }
    .gnb .left-menu {
        font-weight: 600;
        font-size: 1.2rem;
        color: #000;
    }
    .gnb .right-menu a {
        margin-right: 20px;
        font-size: 0.95rem;
        color: #666;
        padding-bottom: 3px;
        transition: color 0.2s;
    }
    .gnb .right-menu a:last-child {
        margin-right: 0;
    }
    .gnb .right-menu a:hover {
        color: #000;
    }
    /* 현재 페이지(FAQ) 활성화 스타일 */
    .gnb .right-menu a.active {
        color: #000;
        font-weight: 600;
        border-bottom: 2px solid #000;
    }

    /* 페이지 타이틀 영역 */
    .page-title-wrap {
        width: 1200px;
        margin: 0 auto;
        padding: 20px 0 10px; /* 아래쪽 살짝 간격 */
    }
    .page-title-wrap h2 {
        font-size: 1.5rem;
        font-weight: 700;
        margin: 0;
        /* 밑줄 등 다른 효과를 원치 않으면 제거 */
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
    }

    /* FAQ 레이아웃: 좌 카테고리 + 우 질문/답변 */
    .faq-layout {
        width: 1200px;
        margin: 0 auto;
        padding: 20px 0 40px;
        display: flex;
        gap: 40px;
    }
    /* 좌측 카테고리 */
    .faq-category {
        width: 200px;
        border-right: 1px solid #eee;
    }
    .faq-category h3 {
        font-size: 1rem;
        font-weight: 600;
        margin-bottom: 10px;
    }
    .faq-category ul li {
        margin-bottom: 10px;
        cursor: pointer;
        color: #666;
        font-size: 0.95rem;
    }
    .faq-category ul li.active {
        font-weight: 600;
        color: #000;
    }

    /* 우측 FAQ 아코디언 */
    .faq-content {
        flex: 1;
    }
    .accordion-item {
        border-bottom: 1px solid #eee;
    }
    .accordion-item:last-child {
        border-bottom: none;
    }
    /* 질문 영역 */
    .accordion-title {
        position: relative;
        padding: 15px 0;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
    }
    .accordion-title:hover {
        background-color: #fafafa;
    }
    /* 오른쪽 화살표 */
    .accordion-title::after {
        content: '▼';
        font-size: 0.8rem;
        color: #999;
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        transition: transform 0.2s;
    }
    /* 펼쳐졌을 때 화살표 회전 */
    .accordion-item.open .accordion-title::after {
        transform: translateY(-50%) rotate(-180deg);
    }
    /* 답변 영역 */
    .accordion-content {
        display: none;
        padding: 10px 0 15px;
        font-size: 0.95rem;
        line-height: 1.4;
        color: #555;
    }
    .accordion-item.open .accordion-content {
        display: block;
    }
    </style>

<body>

<!-- 상단 GNB -->
<div class="gnb">
    <div class="left-menu">마이페이지</div>
    <div class="right-menu">
        <a href="#">구매내역</a>
        <a href="#">멤버십/레벨</a>
        <a href="#">내가 쓴 글</a>
        <a href="#">좋아요</a>
        <a href="#">최근 본</a>
        <!-- FAQ만 활성화 표시 -->
        <a href="#" class="active">FAQ</a>
        <a href="#">크리에이터 문의 내역 확인</a>
    </div>
</div>

<!-- 페이지 타이틀 -->
<div class="page-title-wrap">
    <h2>고객 FAQ</h2>
</div>

<!-- FAQ 본문 레이아웃 -->
<div class="faq-layout">
    <!-- 좌측 카테고리 -->
    <div class="faq-category">
        <ul>
            <li class="active" data-cate="cate1">자주하는 질문</li>
            <li data-cate="cate2">주문/결제</li>
            <li data-cate="cate3">취소/반품</li>
            <li data-cate="cate4">디지털 굿즈 구매 가이드</li>
            <li data-cate="cate5">기타</li>
        </ul>
    </div>

    <!-- 우측 FAQ 내용 -->
    <div class="faq-content">
        <!-- [자주하는 질문] cate1 -->
        <div id="cate1" class="accordion-category">
            <div class="accordion-item">
                <div class="accordion-title">크리에이터 굿즈와, 마플샾</div>
                <div class="accordion-content">
                    크리에이터 굿즈란 개인 혹은 창작자가 직접 디자인/제작하여 판매하는 상품입니다.<br>
                    마플샾은 이러한 굿즈를 등록하고 판매할 수 있는 플랫폼입니다.
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">마플샾 배송 상품, 크리에이터 배송 상품은 무엇인가요?</div>
                <div class="accordion-content">
                    마플샾 배송 상품은 마플 자체 물류를 통해 제작/배송되는 상품이며,<br>
                    크리에이터 배송 상품은 각 크리에이터가 직접 제작/배송을 진행하는 상품입니다.
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">상품 수정했지만 반영이 안 돼요!</div>
                <div class="accordion-content">
                    상품 수정 사항 반영까지 약간의 시간이 걸릴 수 있습니다.<br>
                    일정 시간이 지나도 반영되지 않으면 고객센터로 문의해 주세요.
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">제품을 받았는데 교환/반품이 가능한가요?</div>
                <div class="accordion-content">
                    상품 수령 후 7일 이내에 교환/반품 접수가 가능합니다.<br>
                    단, 상품 훼손 등 사유에 따라 불가할 수 있으니 정책을 확인해 주세요.
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">각각 다른 크리에이터 샵 주문건 묶음 배송이 가능한가요?</div>
                <div class="accordion-content">
                    크리에이터별 생산/출고지가 달라 묶음 배송이 어려운 경우가 많습니다.<br>
                    자세한 사항은 고객센터를 통해 확인해 주세요.
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">비회원도 주문할 수 있나요?</div>
                <div class="accordion-content">
                    비회원 주문도 가능합니다만, 마이페이지 이용 및 적립 혜택이 제한됩니다.
                </div>
            </div>
        </div>

        <!-- [주문/결제] cate2 -->
        <div id="cate2" class="accordion-category" style="display: none;">
            <div class="accordion-item">
                <div class="accordion-title">주문/결제 관련 예시 질문 1</div>
                <div class="accordion-content">
                    주문/결제 관련 답변 1...
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">주문/결제 관련 예시 질문 2</div>
                <div class="accordion-content">
                    주문/결제 관련 답변 2...
                </div>
            </div>
        </div>

        <!-- [취소/반품] cate3 -->
        <div id="cate3" class="accordion-category" style="display: none;">
            <div class="accordion-item">
                <div class="accordion-title">취소/반품 관련 예시 질문 1</div>
                <div class="accordion-content">
                    취소/반품 관련 답변 1...
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">취소/반품 관련 예시 질문 2</div>
                <div class="accordion-content">
                    취소/반품 관련 답변 2...
                </div>
            </div>
        </div>

        <!-- [디지털 굿즈 구매 가이드] cate4 -->
        <div id="cate4" class="accordion-category" style="display: none;">
            <div class="accordion-item">
                <div class="accordion-title">디지털 굿즈 구매 관련 예시 질문 1</div>
                <div class="accordion-content">
                    디지털 굿즈 구매 관련 답변 1...
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">디지털 굿즈 구매 관련 예시 질문 2</div>
                <div class="accordion-content">
                    디지털 굿즈 구매 관련 답변 2...
                </div>
            </div>
        </div>

        <!-- [기타] cate5 -->
        <div id="cate5" class="accordion-category" style="display: none;">
            <div class="accordion-item">
                <div class="accordion-title">기타 관련 예시 질문 1</div>
                <div class="accordion-content">
                    기타 관련 답변 1...
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-title">기타 관련 예시 질문 2</div>
                <div class="accordion-content">
                    기타 관련 답변 2...
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>
/**
 * 좌측 카테고리 클릭 시 해당 질문/답변만 보이도록
 */
const categoryLinks = document.querySelectorAll('.faq-category ul li');
categoryLinks.forEach(link => {
    link.addEventListener('click', () => {
        // 모든 li 비활성화
        categoryLinks.forEach(li => li.classList.remove('active'));
        link.classList.add('active');

        // 해당 container 안의 모든 accordion-category 숨김
        const parentContainer = document.querySelector('.faq-content');
        const allCategories = parentContainer.querySelectorAll('.accordion-category');
        allCategories.forEach(cat => cat.style.display = 'none');

        // 클릭된 li의 data-cate 값과 일치하는 id만 표시
        const cateId = link.getAttribute('data-cate');
        const targetDiv = parentContainer.querySelector('#' + cateId);
        if(targetDiv) {
            targetDiv.style.display = 'block';
        }
    });
});

/**
 * 아코디언 펼치기/접기
 */
document.addEventListener('click', function(e) {
    if(e.target && e.target.classList.contains('accordion-title')) {
        const item = e.target.closest('.accordion-item');
        item.classList.toggle('open');
    }
});
</script>

<%@ include file="../fragments/footer.jsp" %>


