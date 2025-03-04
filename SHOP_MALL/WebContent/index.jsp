<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>

<main class="container-fluid">
	<div class="container">
		<div class="main-content">
			<h1 class="main-title">
				<a class="home-logo" href="/">FanTastic</a>
			</h1>
			<h2 class="sub-title">FanTastic</h2>
			<div class="main-search-div">
				<input class="main-search-box" type="text" placeholder="검색">
				<button class="main-search-btn">검색</button>
			</div>
		</div>
	</div>
</main>
<!-- 이미지 나열 부분 -->
<div class="container-fluid">

</div>

<%@ include file="/fragments/footer.jsp"%>

<script>
	// 이미지 컨테이너 선택
	const imageContainers = document.querySelectorAll('.image-container');

	// 스크롤 이벤트 처리
	window.addEventListener('wheel', function(event) {
		if (event.ctrlKey) { // Ctrl 키가 눌렸을 때
			event.preventDefault(); // 기본 스크롤 동작 방지

			let scale = 1; // 기본 스케일

			// 스크롤 방향에 따라 스케일 조정
			if (event.deltaY < 0) {
				scale = 1.1; // 확대
			} else {
				scale = 0.9; // 축소
			}

			// 각 이미지 컨테이너에 대해 스케일 적용
			imageContainers.forEach(function(container) {
				container.style.transform = `scale(${scale})`;
			});
		}
	});

</script>
</body>
</html>