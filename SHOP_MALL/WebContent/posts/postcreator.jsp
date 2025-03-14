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
					<div class="creator-card"
						onclick="location.href='/post/creatordetail.do?authorid=${creator.authorid}'">
						<c:choose>
							<c:when test="${empty creator.authorimg1}">
								<img src="/img/no_image.png" alt="작가 이미지" width="100">
							</c:when>
							<c:otherwise>
								<img src="/uploads/${creator.authorimg1}" alt="작가 이미지"
									width="100">
							</c:otherwise>
						</c:choose>
						<p class="creator-name">${creator.authorname}</p>
						<p class="creator-info">${creator.authorinfo}</p>
					</div>
				</c:forEach>



				<!-- 페이지 번호 표시 시작 -->
				<div class="pagination">
					<c:if test="${startPage > 1}">
						<a href="/post/creatorlist.do?page=${startPage - 1}">&laquo;</a>
					</c:if>

					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<a href="/post/creatorlist.do?page=${i}"
							class="${i == currentPage ? 'active' : ''}">${i}</a>
					</c:forEach>

					<c:if test="${endPage < totalPage}">
						<a href="/post/creatorlist.do?page=${endPage + 1}">&raquo;</a>
					</c:if>
				</div>
				<!------------- 페이징 끝 --------------->

			</div>
		</div>
	</div>
</section>

<%@ include file="/fragments/footer.jsp"%>
