<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postcreator.css">

<section class="creatorlist-section">
    <div class="creatorlist-header">
       	<div class="container">
       		<div class="creatorlist-banner">
				<h4 class="creatorlist-semi-title">すべてのクリエイターが一目で！</h4>
				<h2 class="creatorlist-title">クリエイター</h2>
			</div>
		</div>
	</div>
	
	<div class="creatorlist-content">
		<div class="container">
			<div class="saleslist-sidebar">
				<ul>
					<li onclick="location.href='/post/creatorlist.do'"
					class="${pageContext.request.requestURI == '/post/creatorlist.do' ? 'active' : ''}">
					クリエイター </li>
					<li onclick="location.href='/post/postsellinglist.do'">全商品</li>
					<li onclick="location.href='/post/postsellinglist.do?category=2'"
	                  class="${param.category == '1' ? 'active' : ''}">キーリング</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=3'"
	                  class="${param.category == '2' ? 'active' : ''}">アクリルグッズ</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=4'"
	                  class="${param.category == '3' ? 'active' : ''}">フォトカード</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=5'"
	                  class="${param.category == '4' ? 'active' : ''}">ティンケース</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=6'"
	                  class="${param.category == '5' ? 'active' : ''}">キーキャップ</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=7'"
	                  class="${param.category == '6' ? 'active' : ''}">ミラー/ピンボタン</li>
	                <li onclick="location.href='/post/postsellinglist.do?category=8'"
	                  class="${param.category == '7' ? 'active' : ''}">カバー/クリーナー</li>
					<li onclick="location.href='/post/postsellinglist.do?category=8'"
					  class="${param.category == '8' ? 'active' : ''}">その他</li>
				</ul>
			</div>
			
			<div class="creatorlist-frame">
				<c:forEach var="creator" items="${creatorList}">
					<div class="creator-card" onclick="location.href='/post/creatordetail.do?authorid=${creator.authorid}'">
						<div class="background-image" style="background-image: url('/uploads/${creator.authorimg1}');"></div>
						<c:choose>
							<c:when test="${empty creator.authorimg1}">
								<img src="/img/no_image.png" alt="作家のイメージ" width="100">
							</c:when>
							<c:otherwise>
								<img src="/uploads/${creator.authorimg1}" alt="作家のイメージ"
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
