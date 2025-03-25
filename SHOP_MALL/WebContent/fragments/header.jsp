<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FanTastic</title>

<script src="/js/jquery-3.7.1.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>

<link rel="stylesheet" 
   href="https://fonts.googleapis.com/css2?family=Sacramento&display=swap">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic:wght@400;700&display=swap">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+Rounded:wght@400;700&display=swap">

<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" 
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Swiper CSS -->
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/fragments.css">
</head>
<body>

	<header class="header-container">
		<div class="container">
			<div class="home-bar">
				<div class="home-left-part">
					<!-- 로고 -->
					<a href="/"><img src="/img/logo.png" class="logo" alt="FanTastic"></a>
					
					<!-- 드랍다운 카테고리 -->
					<div class="home-category">
						<div class="dropdown">
							<button class="category-btn dropdown-toggle" type="button" 
								onclick="location.href='/post/postsellinglist.do'" data-toggle="dropdown">カテゴリー</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="/post/creatorlist.do">クリエイター</a>
								<a class="dropdown-item" href="/post/postsellinglist.do">全商品</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=1">キーホルダー</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=2">アクリル</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=3">フォトカード</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=4">ティンケース</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=5">キーキャップ</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=6">ミラー / ピンバッジ</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=7">カバー / クリーナー</a>
								<a class="dropdown-item" href="/post/postsellinglist.do?category=8">その他</a>
							</div>
						</div>
					</div>
				
					<!-- 검색창 -->
					<div class="home-search">
						<input type="text" class="home-search-box" placeholder="FanTasticで自分の好みを見つけよう！">
						<button class="home-search-button">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

            <!-- 로그인/회원가입 -->
            <ul class="home-right-part">
               <c:choose>
                  <c:when test="${empty sessionScope.user}">
                     <li><a href="/member/login.do"><img src="/img/icon_login.png" class="header-icon" alt="로그인"></a></li>
                     <li><a href="/member/signup.do"><img src="/img/icon_signup.png" class="header-icon" alt="회원가입"></a></li>
                  </c:when>
                  <c:otherwise>
                     <li class="logged-user"><span class="logged-user-id">${sessionScope.user.name}</span>
                       様、ようこそ！</li>
                     <li><a href="/post/postcart.do"><img src="/img/icon_cart.png" class="header-icon-cart" alt="장바구니"></a></li>
                     <li><a href="/member/mypage.do"><img src="/img/icon_mypage.png" class="header-icon" alt="마이페이지"></a></li>
                     <li><a href="/member/logout.do"><img src="/img/icon_logout.png" class="header-icon" alt="로그아웃"></a></li>
                  </c:otherwise>
               </c:choose>
            </ul>
         </div>
      </div>
   </header>
  
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