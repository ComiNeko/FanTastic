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