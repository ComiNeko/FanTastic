<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FanTastic</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic:wght@400;700&display=swap">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+Rounded:wght@400;700&display=swap">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/fragments.css">
</head>
<body>
	<header class="home-bar">
		<div class="container">
			<div class="home-left-part">
				<h1 class="home-name">
					<a href="/">FanTastic</a>
				</h1>
				<div class="home-search-part">
					<input class="home-search-box" type="text"
						placeholder="크리에이터 또는 의뢰명 검색">
					<button class="home-search-button">
						<i class="fas fa-search"></i>
						<!-- FontAwesome 아이콘 -->
					</button>
				</div>
			</div>
			<div class="home-right-part" style="list-style: none;">
				<c:choose>
					<c:when test="${empty sessionScope.user}">
						<li><a href="/member/login.do">로그인</a></li>
						<li><a href="/member/signup.do">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<span class="logged-user-id">${sessionScope.user.name} </span>
						<span class="logged-user-welcome"> 님 환영합니다!</span>
						<li><a href="/member/mypage.do">마이페이지</a></li>
						<li><a href="/member/logout.do">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<nav class="home-nav">
			<div class="container">
				<div class="nav-left">
					<ul class="nav-links-drop">
						<li class="dropdown"><a class="dropdown-toggle" href="#"
							id="navbarDropdown" role="button" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> 전체 카테고리 </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="#">캐릭터 일러스트</a>
								<a class="dropdown-item" href="#">일러스트</a>
								<a class="dropdown-item" href="#">라이브2D</a>
								<a class="dropdown-item" href="#">버추얼3D</a>
							</div>
						</li>
					</ul>
					<ul class="nav-links-popular">
						<li><a href="#">크리에이터</a></li>
						<li><a href="#">일러스트</a></li>
						<li><a href="#">라이브2D</a></li>
						<li><a href="#">버추얼3D</a></li>
					</ul>
				</div>
				<div class="nav-right">
					<ul class="nav-right-items">
						<li class="nav-item"><a href="#">의뢰게시판</a></li>
						<li class="nav-item"><a href="#">이용후기</a></li>
						<li class="nav-item"><a href="#">고객센터</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
</body>
<script>
	$(document).ready(function() {
		// 드롭다운 메뉴에 마우스 오버 시 열기
		$('.dropdown').hover(function() {
			$(this).find('.dropdown-menu').stop(true, true).slideDown(200);
		}, function() {
			$(this).find('.dropdown-menu').stop(true, true).slideUp(200);
		});
	});
</script>
</html>

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
</script>

</script>

<footer>
    <div class="footer-container container">
    	<div class="footer-tab">
	        <a href="#">홈</a><span> | </span>
			<a href="#">자주하는질문</a><span> | </span>
	        <a href="#">문의게시판</a><span> | </span>
	        <a href="#">이용약관</a><span> | </span>
	        <a href="#">개인정보취급방침</a>
        </div>
        <div class="footer-desc">
	        <p>Project NEW_MALL 대전 중구 계룡로 825 팀 대표 : 김창서 팀원 : 정진교, 이태래, 황인준, 백재욱</p>
	        <p>NEW_MALL 사이트의 상품/판매회원/중개 서비스/거래 정보, 콘텐츠, UI 등에 대한 무단복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠산업 진흥법 등 관련법령에 의하여 엄격히 금지됩니다.</p>
        </div>
    </div>
    <div class="copyright-container container">
        <p class="mb-0">Copyright © 2025 NEW_MALL Inc. All rights reserved.</p>
    </div>
</footer>
<script src="/js/slide.js"></script>
