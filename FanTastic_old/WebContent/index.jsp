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

<section class="quick-menu-container">
    <div class="quick-menu">
        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #f7c52c;">
                <a href="/posts/popcreator.do"><img src="/img/qm_creator.png" alt="인기 크리에이터"></a>
            </div>
            <p>FanTastic 크리에이터</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #f56a6a;">
                <a href="/posts/popproduct.do"><img src="/img/qm_product.png" alt="인기 상품"></a>
            </div>
            <p>FanTastic 굿즈</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #3c91e6;">
                <a href="/posts/openevent.do"><img src="/img/qm_openevent.png" alt="깜짝 오픈이벤트"></a>
            </div>
            <p>깜짝! 오픈이벤트</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #4caf50;">
                <a href="/posts/review.do"><img src="/img/qm_review.png" alt="FanTastic 포토리뷰"></a>
            </div>
            <p>FanTastic 포토리뷰</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #ff9800;">
                <a href="/posts/request.do"><img src="/img/qm_request.png" alt="상품 등록요청"></a>
            </div>
            <p>상품 등록요청</p>
        </div>
    </div>
</section>

<section class="popular-creators">
    <div class="container">
       <h4 class="section-semi-title">3월 가장 인기많은 작가 랭킹</h4>
        <h2 class="section-title">주간 인기 크리에이터</h2>
        <div class="creator-wrapper">
            <!-- 1위 크리에이터 -->
            <div class="first-place">
                <div class="top-creator">
                <div class="creator-card">
                   <div class="creator-info">
                        <h2 class="ranking">WEEKLY TOP 1</h2>
                    </div>
                    <div class="background-blur"></div>
                    <div class="profile-image">
                        <a href="#">
                        	<img src="/img/ex_profile_01.png" alt="John 프로필 이미지">
                       	</a>
                    </div>
                    <div class="creator-info">
                        <h1 style="font-size: 32px; font-weight: 700;">John Doe</h1>
                        <p>유튜버</p>
                           <p>❤️ Favorite: 12,345</p>
                    </div>
                    
                    <!-- 대표 상품 3개 -->
                    <div class="creator-products">
                        <a href="#" class="product">
                            <img src="/img/ex_product_01.png" alt="상품 1">
                        </a>
                        <a href="#" class="product">
                            <img src="/img/ex_product_02.png" alt="상품 2">
                        </a>
                        <a href="#" class="product">
                            <img src="/img/ex_product_03.png" alt="상품 3">
                        </a>
                    </div>
                </div>
            </div>
            </div>

            <!-- 2~5위 크리에이터 -->
            <div class="other-creators">
                <div class="creator-card">
	                <a href="#">
	                    <div class="rank">2위</div>
	                    <img src="/img/ex_profile_02.png" alt="Jane's Profile" class="profile-img">
	                    <div class="creator-info">
	                        <h3 class="creator-name">Jane</h3>
	                        <p class="creator-job">유튜버</p>
	                        <p class="creator-favorite">❤️ Favorite: 9,876</p>
	                    </div>
	                </a>
                </div>
                <div class="creator-card">
                	<a href="#">
	                    <div class="rank">3위</div>
	                    <img src="/img/ex_profile_03.png" alt="Chris's Profile" class="profile-img">
	                    <div class="creator-info">
	                        <h3 class="creator-name">Chris</h3>
	                        <p class="creator-job">만화가</p>
	                        <p class="creator-favorite">❤️ Favorite: 8,765</p>
	                    </div>
                    </a>
                </div>
                <div class="creator-card">
                	<a href="#">
	                    <div class="rank">4위</div>
	                    <img src="/img/ex_profile_04.png" alt="Kim's Profile" class="profile-img">
	                    <div class="creator-info">
	                        <h3 class="creator-name">Kim</h3>
	                        <p class="creator-job">라이브2D 아티스트</p>
	                        <p class="creator-favorite">❤️ Favorite: 7,654</p>
	                    </div>
                    </a>
                </div>
                <div class="creator-card">
	                <a href="#">
	                    <div class="rank">5위</div>
	                    <img src="/img/ex_profile_05.png" alt="Lee's Profile" class="profile-img">
	                    <div class="creator-info">
                        	<h3 class="creator-name">Lee</h3>
	                        <p class="creator-job">버추얼 크리에이터</p>
	                        <p class="creator-favorite">❤️ Favorite: 6,543</p>
	                    </div>
	                </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 지금 인기 상품 섹션 -->
<section class="popular-products">
    <div class="container">
        <h4 class="section-semi-title">가장 인기있는 상품을 만나보세요!</h4>
        <h2 class="section-title">TODAY'S HOT 인기 상품</h2>
        
        <!-- Swiper 컨테이너 -->
        <div class="swiper popular-products-slider">
            <div class="swiper-wrapper">
                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_01.png" alt="John의 키링">
                    <div class="product-info">
                    	<h4>John</h4>
                        <h3>대롱대롱 아크릴 스탠드</h3>
                        <p class="product-costs">20,000원</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_02.png" alt="Jane의 포토카드">
                    <div class="product-info">
                    	<h4>Jane</h4>
                        <h3>생기발랄 아크릴 스탠드</h3>
                        <p class="product-costs">15,000원</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_03.png" alt="Chris의 아크릴 스탠드">
                    <div class="product-info">
                    	<h4>Chris</h4>
                        <h3>푸근해보이는 키링</h3>
                        <p class="product-costs">2,500원</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_04.png" alt="Kim의 마우스패드">
                    <div class="product-info">
                    	<h4>Kim</h4>
                        <h3>정말로 귀여운 키캡</h3>
                        <p class="product-costs">3,000원</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_05.png" alt="Lee의 틴케이스">
                    <div class="product-info">
                    	<h4>Lee</h4>
                        <h3>[품절임박]귀욤귀욤 sd스티커셋</h3>
                        <p class="product-costs">2,000원</p>
                    </div>
                </div>
            </div>
            
            <!-- 네비게이션 버튼 -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        </div>
    </div>
</section>

<!-- 리뷰 섹션 -->
<section class="review-section">
	<div class="container">
		<div class="review-header">
			<div class="review-header-left">
				<h4 class="section-semi-title">판타스틱한 내돈내산 리뷰!</h4>
				<h2 class="section-title">FanTastic 포토 리뷰</h2>
			</div>
			<div class="review-header-right">
				<a href="/posts/postreview.do" class="see-more">See More</a>
			</div>
		</div>

		<div class="review-container">
			<!-- 리뷰 1 -->
			<div class="review-card">
				<img src="/img/ex_review_01.png" alt="리뷰 이미지">
				<div class="review-info">
					<a href="/posts/postreview?reviewid=01.do" class="product-link">
						<div class="review-meta">
							<div class="stars">★★★★★</div>
							<span class="review-time">25분 전</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_01.png" alt="상품 이미지">
							<div class="product-info">
								<h3>선물세트 느낌나는 이쁘디 이쁜 상자</h3>
								<p>3,500원</p>
							</div>
						</div>
					</a>
				</div>
			</div>

			<!-- 리뷰 2 -->
			<div class="review-card">
				<img src="/img/ex_review_02.png" alt="리뷰 이미지">
				<div class="review-info">
					<a href="/posts/postreview?reviewid=02.do" class="product-link">
						<div class="review-meta">
							<div class="stars">★★★★★</div>
							<span class="review-time">2시간 전</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_02.png" alt="상품 이미지">
							<div class="product-info">
								<h3>OOO의 인형 키링</h3>
								<p>3,500원</p>
							</div>
						</div>
					</a>
				</div>
			</div>

			<!-- 리뷰 3 -->
			<div class="review-card">
				<img src="/img/ex_review_03.png" alt="리뷰 이미지">
				<div class="review-info">
					<a href="/posts/postreview?reviewid=03.do" class="product-link">
						<div class="review-meta">
							<div class="stars">★★★★★</div>
							<span class="review-time">11시간 전</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_03.png" alt="상품 이미지">
							<div class="product-info">
								<h3>멋진 쿠키런 뱃지</h3>
								<p>3,500원</p>
							</div>
						</div>
					</a>
				</div>
			</div>

			<!-- 리뷰 4 -->
			<div class="review-card">
				<img src="/img/ex_review_04.png" alt="리뷰 이미지">
				<div class="review-info">
					<a href="/posts/postreview?reviewid=04.do" class="product-link">
						<div class="review-meta">
							<div class="stars">★★★★★</div>
							<span class="review-time">23시간 전</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_04.png" alt="상품 이미지">
							<div class="product-info">
								<h3>OOO의 멋진 포토카드</h3>
								<p>3,500원</p>
							</div>
						</div>
					</a>
				</div>
			</div>

		</div>
	</div>
</section>

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

<script>
    var swiper = new Swiper(".popular-products-slider", {
        slidesPerView: 3,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        breakpoints: {
            1024: { slidesPerView: 3 },
            768: { slidesPerView: 2 },
            480: { slidesPerView: 1 }
        }
    });
</script>

<script>
    var swiper = new Swiper(".review-slider", {
        slidesPerView: 4,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        breakpoints: {
            1024: { slidesPerView: 4 },
            768: { slidesPerView: 2 },
            480: { slidesPerView: 1 }
        }
    });
</script>



<%@ include file="/fragments/footer.jsp"%>