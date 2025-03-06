<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>
<link rel="stylesheet" href="/css/index.css">
<script src="js/jquery-3.7.1.min.js"></script>

<!-- Swiper 슬라이더 -->
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <img src="/img/banner1.png" class="main-banner-img" alt="배너 이미지 1">
            <div class="swiper-caption">
                <h3>FanTastic에서 크리에이터의 굿즈를 만나보세요!</h3>
                <p>일러스트, 캐릭터 굿즈, 버추얼 아이템까지 다양한 상품을 제공합니다.</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner2.png" class="main-banner-img" alt="배너 이미지 2">
            <div class="swiper-caption">
                <h3>핫한 신상품 업데이트!</h3>
                <p>최신 크리에이터 아이템을 지금 확인해보세요.</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner3.png" class="main-banner-img" alt="배너 이미지 3">
            <div class="swiper-caption">
                <h3>FanTastic 오픈 이벤트</h3>
                <p>특별한 혜택을 누려보세요!</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner4.png" class="main-banner-img" alt="배너 이미지 4">
            <div class="swiper-caption">
                <h3>특별 할인 이벤트!</h3>
                <p>지금 한정 수량으로 특별 할인된 상품을 만나보세요.</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner5.png" class="main-banner-img" alt="배너 이미지 5">
            <div class="swiper-caption">
                <h3>크리에이터와의 협업 상품</h3>
                <p>유명 크리에이터와의 콜라보 상품을 소개합니다.</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner6.png" class="main-banner-img" alt="배너 이미지 6">
            <div class="swiper-caption">
                <h3>한정판 굿즈를 지금 만나보세요!</h3>
                <p>한정판으로 제작된 특별한 상품을 FanTastic에서 만나보세요.</p>
            </div>
        </div>
    </div>

    <!-- 이전/다음 버튼 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>

    <!-- 페이지네이션 (하단 점) -->
    <div class="swiper-pagination"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        loop: true, // 무한 루프
        autoplay: {
            delay: 3000, // 3초마다 자동 전환
            disableOnInteraction: false, // 유저가 터치해도 자동 슬라이드 유지
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true, // 하단 점 클릭 가능
        },
        on: {
            slideChangeTransitionStart: function () {
                // 모든 슬라이드의 텍스트 숨기기 (fade-out)
                document.querySelectorAll('.swiper-caption').forEach(el => {
                    el.style.opacity = '0';
                    el.style.transform = 'translateY(20px)';
                });
            },
            slideChangeTransitionEnd: function () {
                // 현재 활성화된 슬라이드의 텍스트 보이기 (fade-in)
                var activeSlide = document.querySelector('.swiper-slide-active .swiper-caption');
                if (activeSlide) {
                    activeSlide.style.opacity = '1';
                    activeSlide.style.transform = 'translateY(0px)';
                }
            }
        }
    });
</script>


<%@ include file="/fragments/footer.jsp"%>