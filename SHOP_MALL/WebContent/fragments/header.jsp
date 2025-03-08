<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FanTastic</title>

<script src="js/jquery-3.7.1.min.js"></script>


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
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<!-- Swiper CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/fragments.css">
</head>
<body>
	<header class="header-container">
		<div class="container">
			<div class="home-bar">
				<!-- 로고 -->
				<div class="home-left-part">
					<h1 class="home-name">
						<a href="/">FanTastic</a>
					</h1>

					<!-- 검색창 -->
					<div class="home-search">
						<input type="text" class="home-search-box" placeholder="검색">
						<button class="home-search-button">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

				<!-- 로그인/회원가입 -->
				<ul class="home-right-part">
					<c:choose>
						<c:when test="${empty sessionScope.user}">
							<li><a href="/member/login.do">로그인</a></li>
							<li><a href="/member/signup.do">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li><span class="logged-user-id">${sessionScope.user.name}</span>
								님 환영합니다!</li>
							<li><a href="/member/mypage.do">마이페이지</a></li>
							<li><a href="/member/logout.do">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</header>

	<!-- 네비게이션 바 -->
	<nav>
		<div class="container">
			<div class="home-nav">
				<div class="home-nav-category">
					<div class="dropdown">
						<button class="category-btn dropdown-toggle" type="button"
							data-toggle="dropdown">전체 카테고리</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="../posts/postsellinglist.jsp">키링</a> <a class="dropdown-item"
								href="#">아크릴</a> <a class="dropdown-item" href="#">포토카드</a> <a
								class="dropdown-item" href="#">틴케이스</a> <a class="dropdown-item"
								href="#">키캡</a> <a class="dropdown-item" href="#">거울/핀버튼</a> <a
								class="dropdown-item" href="#">커버/클리너</a>
						</div>
					</div>
				</div>
				<ul class="home-nav-menu">
					<li><a href="#">키링</a></li>
					<li><a href="#">아크릴</a></li>
					<li><a href="#">포토카드</a></li>
					<li><a href="#">틴케이스</a></li>
					<li><a href="#">키캡</a></li>
					<li><a href="#">고객센터</a></li>
				</ul>
			</div>
		</div>
	</nav>

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