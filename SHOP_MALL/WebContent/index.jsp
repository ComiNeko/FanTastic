<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>

<link rel="stylesheet" href="/css/index.css">

<!-- Swiper 슬라이더 -->
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <img src="/img/banner1.png" class="main-banner-img" alt="バナー画像1">
            <div class="swiper-caption">
                <h3>FanTasticでクリエイターのグッズを見つけよう！</h3>
                <p>イラスト、キャラクターグッズ、バーチャルアイテムまで、多様な商品を提供します。</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner2.png" class="main-banner-img" alt="バナー画像2">
            <div class="swiper-caption">
                <h3>最新の新商品アップデート！</h3>
                <p>最新のクリエイターアイテムを今すぐチェック！</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner3.png" class="main-banner-img" alt="バナー画像3">
            <div class="swiper-caption">
                <h3>FanTasticオープンイベント</h3>
                <p>特別な特典をお楽しみください！</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner4.png" class="main-banner-img" alt="バナー画像4">
            <div class="swiper-caption">
                <h3>特別割引イベント！</h3>
                <p>今だけの限定数量で特別割引商品をチェック！</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner5.png" class="main-banner-img" alt="バナー画像5">
            <div class="swiper-caption">
                <h3>クリエイターとのコラボ商品</h3>
                <p>有名クリエイターとのコラボ商品をご紹介します。</p>
            </div>
        </div>
        <div class="swiper-slide">
            <img src="/img/banner6.png" class="main-banner-img" alt="バナー画像6">
            <div class="swiper-caption">
                <h3>限定版グッズを今すぐチェック！</h3>
                <p>限定版で制作された特別な商品をFanTasticでお楽しみください。</p>
            </div>
        </div>
    </div>

    <!-- 次へ / 前へ ボタン -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>

    <!-- ページネーション（下のドット） -->
    <div class="swiper-pagination"></div>
</div>

<section class="quick-menu-container">
    <div class="quick-menu">
        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #f7c52c;">
                <a href="/post/creatorlist.do"><img src="/img/qm_creator.png" alt="クリエイター"></a>
            </div>
            <p>FanTasticクリエイター</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #f56a6a;">
                <a href="/post/postsellinglist.do"><img src="/img/qm_product.png" alt="商品"></a>
            </div>
            <p>FanTasticグッズ</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #3c91e6;">
                <a href="/post/openevent.do"><img src="/img/qm_openevent.png" alt="サプライズオープンイベント"></a>
            </div>
            <p>サプライズ！オープンイベント</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #4caf50;">
                <a href="/post/review.do"><img src="/img/qm_review.png" alt="FanTasticフォトレビュー"></a>
            </div>
            <p>FanTasticフォトレビュー</p>
        </div>

        <div class="quick-menu-item">
            <div class="quick-menu-icon" style="background-color: #ff9800;">
                <a href="/post/request.do"><img src="/img/qm_request.png" alt="商品登録リクエスト"></a>
            </div>
            <p>商品登録リクエスト</p>
        </div>
    </div>
</section>

<section class="popular-creators">
	<div class="container">
		<h4 class="section-semi-title">3月の最も人気のある作家ランキング</h4>
		<h2 class="section-title">週間人気クリエイター</h2>
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
							<a href="#"> <img src="/img/ex_profile_01.png"
								alt="John 프로필 이미지">
							</a>
						</div>
						<div class="creator-info">
							<h1 style="font-size: 32px; font-weight: 700;">John Doe</h1>
							<p>ユーチューバー</p>
							<p>❤️ お気に入り: 12,345</p>
						</div>

						<!-- 대표 상품 3개 -->
						<div class="creator-products">
							<a href="#" class="product"> <img
								src="/img/ex_product_01.png" alt="상품 1">
							</a> <a href="#" class="product"> <img
								src="/img/ex_product_02.png" alt="상품 2">
							</a> <a href="#" class="product"> <img
								src="/img/ex_product_03.png" alt="상품 3">
							</a>
						</div>
					</div>
				</div>
			</div>

			<!-- 2~5위 크리에이터 -->
			<div class="other-creators">
				<div class="creator-card">
					<a href="#">
						<div class="rank">2位</div> <img src="/img/ex_profile_02.png"
						alt="Jane's Profile" class="profile-img">
						<div class="creator-info">
							<h3 class="creator-name">Jane</h3>
							<p class="creator-job">ユーチューバー</p>
							<p class="creator-favorite">❤️ お気に入り: 9,876</p>
						</div>
					</a>
				</div>
				<div class="creator-card">
					<a href="#">
						<div class="rank">3位</div> <img src="/img/ex_profile_03.png"
						alt="Chris's Profile" class="profile-img">
						<div class="creator-info">
							<h3 class="creator-name">Chris</h3>
							<p class="creator-job">漫画家</p>
							<p class="creator-favorite">❤️ お気に入り: 8,765</p>
						</div>
					</a>
				</div>
				<div class="creator-card">
					<a href="#">
						<div class="rank">4位</div> <img src="/img/ex_profile_04.png"
						alt="Kim's Profile" class="profile-img">
						<div class="creator-info">
							<h3 class="creator-name">Kim</h3>
							<p class="creator-job">Live2Dアーティスト</p>
							<p class="creator-favorite">❤️ お気に入り: 7,654</p>
						</div>
					</a>
				</div>
				<div class="creator-card">
					<a href="#">
						<div class="rank">5位</div> <img src="/img/ex_profile_05.png"
						alt="Lee's Profile" class="profile-img">
						<div class="creator-info">
							<h3 class="creator-name">Lee</h3>
							<p class="creator-job">バーチャルクリエイター</p>
							<p class="creator-favorite">❤️ お気に入り: 6,543</p>
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
        <h4 class="section-semi-title">最も人気のある商品をチェック！</h4>
        <h2 class="section-title">TODAY'S HOT 人気商品</h2>
        
        <!-- Swiper 컨테이너 -->
        <div class="swiper popular-products-slider">
            <div class="swiper-wrapper">
                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_01.png" alt="John의 키링">
                    <div class="product-info">
                    	<h4>John</h4>
                        <h3>ゆらゆらアクリルスタンド</h3>
                        <p class="product-costs">2,000円</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_02.png" alt="Jane의 포토카드">
                    <div class="product-info">
                    	<h4>Jane</h4>
                        <h3>元気いっぱいアクリルスタンド</h3>
                        <p class="product-costs">1,500円</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_03.png" alt="Chris의 아크릴 스탠드">
                    <div class="product-info">
                    	<h4>Chris</h4>
                        <h3>ほのぼのキーホルダー</h3>
                        <p class="product-costs">250円</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_04.png" alt="Kim의 마우스패드">
                    <div class="product-info">
                    	<h4>Kim</h4>
                        <h3>本当にかわいいキーキャップ</h3>
                        <p class="product-costs">300円</p>
                    </div>
                </div>

                <div class="swiper-slide product-card">
                    <img src="/img/ex_product_05.png" alt="Lee의 틴케이스">
                    <div class="product-info">
                    	<h4>Lee</h4>
                        <h3>[売り切れ間近] かわいいSDステッカーセット</h3>
                        <p class="product-costs">200円</p>
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
				<h4 class="section-semi-title">FanTasticな自腹レビュー！</h4>
				<h2 class="section-title">FanTasticフォトレビュー</h2>
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
							<span class="review-time">25分前</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_01.png" alt="상품 이미지">
							<div class="product-info">
								<h3>ギフトセット風のかわいい箱</h3>
								<p>350円</p>
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
							<span class="review-time">2時間前</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_02.png" alt="상품 이미지">
							<div class="product-info">
								<h3>ぬいぐるみキーホルダー</h3>
								<p>350円</p>
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
							<span class="review-time">11時間前</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_03.png" alt="상품 이미지">
							<div class="product-info">
								<h3>素敵なクッキーランバッジ</h3>
								<p>350円</p>
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
							<span class="review-time">23時間前</span>
						</div>
						<div class="review-meta-info">
							<img src="/img/ex_product_04.png" alt="상품 이미지">
							<div class="product-info">
								<h3>素敵なフォトカード</h3>
								<p>350円</p>
							</div>
						</div>
					</a>
				</div>
			</div>

		</div>
	</div>
</section>

<!-- 공지사항 & 고객센터 섹션 -->
<section class="notice-customer-section">
    <div class="container">
        <div class="notice">
        	<div class="notice-head">
	            <h2 class="section-title">お知らせ</h2>
	            <a href="/notice" class="more-btn">See More</a>
            </div>
            <ul class="notice-list">
                <li>
                    <a href="#">[イベント] 新商品ローンチ記念特別割引のお知らせ</a>
                    <span class="date">2024.03.13</span>
                </li>
                <li>
                    <a href="#">[アップデート] FanTasticサービス改編のお知らせ</a>
                    <span class="date">2024.03.10</span>
                </li>
                <li>
                    <a href="#">[お知らせ] システムメンテナンススケジュールのお知らせ</a>
                    <span class="date">2024.03.08</span>
                </li>
                <li>
                    <a href="#">[必読] 安全取引のための注意事項</a>
                    <span class="date">2024.03.05</span>
                </li>
                <li>
                    <a href="#">[必読] オープンイベントのお知らせ</a>
                    <span class="date">2024.03.04</span>
                </li>
            </ul>
        </div>

        <div class="customer">
            <h2 class="section-title">カスタマーセンター</h2>
            <p class="customer-info">営業時間: 平日 10:00 ~ 18:00<br>ランチタイム: 12:00 ~ 13:00</p>
            <div class="customer-service">
                <p class="customer-phone">📞 1588-1234</p>
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