<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postcreator.css">

<section class="creatorlist-section">
    <div class="creatorlist-header">
       	<div class="container">
       		<div class="creatorlist-banner">
				<h4 class="creatorlist-semi-title">모든 크리에이터를 한 눈에!</h4>
				<h2 class="creatorlist-title">크리에이터 목록</h2>
			</div>
		</div>
    </div>
	<div class="creatorlist-content">
		<div class="container">
			<div class="saleslist-sidebar">
				<ul>
					<li onclick="location.href='/post/postsellinglist.do?category=1'"
						class="${param.category == '1' ? 'active' : ''}">크리에이터</li>
					<li onclick="location.href='/post/postsellinglist.do?category=2'"
						class="${param.category == '1' ? 'active' : ''}">키링</li>
					<li onclick="location.href='/post/postsellinglist.do?category=3'"
						class="${param.category == '2' ? 'active' : ''}">아크릴굿즈</li>
					<li onclick="location.href='/post/postsellinglist.do?category=4'"
						class="${param.category == '3' ? 'active' : ''}">포토카드</li>
					<li onclick="location.href='/post/postsellinglist.do?category=5'"
						class="${param.category == '4' ? 'active' : ''}">틴케이스</li>
					<li onclick="location.href='/post/postsellinglist.do?category=6'"
						class="${param.category == '5' ? 'active' : ''}">키캡</li>
					<li onclick="location.href='/post/postsellinglist.do?category=7'"
						class="${param.category == '6' ? 'active' : ''}">거울/핀버튼</li>
					<li onclick="location.href='/post/postsellinglist.do?category=8'"
						class="${param.category == '7' ? 'active' : ''}">커버/클리너</li>
				</ul>
			</div>
			
			<div class="creatorlist-frame">
			    <c:forEach var="creator" items="${creatorList}">
			    	<div class="creator-card" onclick="location.href='/post/creatordetail.do?authorid=${creator.authorid}'">
			    		<div class="background-image" style="background-image: url('/uploads/${creator.authorimg1}');"></div>
				        <img src="/uploads/${creator.authorimg1}" alt="작가 이미지" width="100">
				        <!-- <img src="../img/ex_profile_03.png" alt="작가 이미지" width="100"> -->
				        <p class="creator-name">${creator.authorname}</p>
				        <p class="creator-info">${creator.authorinfo}</p>

						<div class="like-area">
							<span class="like-icon">♡</span>
							<span class="like-count">1324</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<script>
	function toggleLike(element, authorId) {
		const likeCountSpan = element.querySelector('.like-count');
		let likeCount = parseInt(likeCountSpan.textContent, 10);

		// 예시: 서버와의 통신을 통해 찜 상태를 토글합니다.
		// 실제 구현 시 서버 API와 연동해야 합니다.
		const isLiked = element.classList.toggle('liked');

		if (isLiked) {
			likeCount += 1;
		} else {
			likeCount -= 1;
		}

		likeCountSpan.textContent = likeCount;

		// 서버에 찜 상태를 업데이트하는 로직을 추가하세요.
		// 예: updateLikeStatus(authorId, isLiked);
	}
</script>

<%@ include file="/fragments/footer.jsp" %>