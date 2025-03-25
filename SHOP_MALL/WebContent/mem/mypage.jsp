<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ include file="../fragments/header.jsp"%>

<link rel="stylesheet" href="../css/mypage.css">

<style>
#mypage .profile-buttons {
	display: flex;
	flex-direction: column; /* 줄 나눠서 배치 */
	gap: 10px; /* 줄 간격 */
}

/* 각 버튼 라인 */
#mypage .button-row {
	display: flex;
	gap: 10px; /* 버튼 사이 간격 */
}

/* ===== disabled 상태일 때 따로 스타일 지정 ===== */
#mypage .info-btn:disabled {
	background-color: #000000; /* 동일하게 유지 */
	color: #ffffff;
	opacity: 1; /* 흐릿해지는 것 방지 */
	cursor: not-allowed; /* 또는 pointer로 변경 가능 */
}

/* ===== 회원정보 수정, 비밀번호 수정 버튼 (작게 조정) ===== */
#mypage .info-btn {
	padding: 6px 12px; /* 기존 10px 16px → 줄임 */
	background-color: #000000;
	color: #ffffff;
	border: none;
	border-radius: 3px; /* 기존 4px → 살짝 더 각지게 */
	cursor: pointer;
	font-size: 0.85rem; /* 기존 0.9rem → 폰트 크기 살짝 줄임 */
}

#mypage .info-btn:hover:enabled {
	background-color: #333333;
}

#mypage .info-btn:disabled {
	opacity: 1;
	cursor: not-allowed;
}

/* ===== admin 버튼도 동일하게 ===== */
#mypage .admin-btn {
	padding: 10px 16px;
	background-color: #f5f5f5;
	color: #333333;
	border: 1px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.9rem;
}

/* ===== 작가 관련 버튼 ===== */
#mypage .admin-btn {
	padding: 6px 12px; /* 기존 10px 16px → 동일하게 줄임 */
	background-color: #f5f5f5;
	color: #333333;
	border: 1px solid #ddd;
	border-radius: 3px;
	cursor: pointer;
	font-size: 0.85rem; /* 폰트 크기 작게 */
}

#mypage .admin-btn:hover:enabled {
	background-color: #e0e0e0;
}

#mypage .admin-btn:disabled {
	opacity: 1;
	cursor: not-allowed;
}
</style>

<script>
	// JSTL を利用してサーバーの結果を JavaScript で表示
	<c:if test="${isAuthorExist == true}">
	alert('すでに作家登録されています。');
	</c:if>
</script>

<div id="mypage">

	<!-- 1) 上部プロフィールエリア -->
	<div class="mypage-container">
		<div class="profile-top-container">
			<!-- 左側: プロフィール画像 + ユーザー名 + ボタン -->
			<div class="profile-info">
				<div class="username">${sessionScope.user.name}さん、ようこそ！</div>
				<div class="profile-buttons">
					<!-- 一段目: 会員ボタン -->
					<div class="button-row member-buttons">
						<button class="info-btn"
							onclick="location.href='/member/updateMyInfo.do'">会員情報修正</button>
						<button class="info-btn"
							onclick="location.href='/member/updatecheck.do'">パスワード変更</button>
					</div>

					<!-- 二段目: 管理者ボタン (Admin 権限のみ表示) -->
					<c:if test="${sessionScope.user.role == 'Admin'}">
						<div class="button-row admin-buttons">
							<button class="admin-btn"
								onclick="location.href='/member/authorinsert.do'">作家登録</button>
							<button class="admin-btn"
								onclick="location.href='/admin/editProfile.do'">作家情報修正</button>
							<button class="admin-btn"
								onclick="location.href='/post/mysellinglist.do'">登録商品修正</button>
						</div>
					</c:if>

				</div>
				<!-- "profile-buttons" -->
			</div>
			<!-- "profile-info" -->

			<!-- 右側: 統計情報 (例) -->
			<div class="profile-right">
				<div class="status-box">
					<div class="item">
						<div class="count">0</div>
						<div class="desc">最近の注文/配送中</div>
					</div>
					<div class="item">
						<div class="count">0</div>
						<div class="desc">投稿したレビュー</div>
					</div>
					<div class="item">
						<div class="count">${sessionScope.favoriteCount}</div>
						<div class="desc">お気に入り商品</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 2) 左右2カラムレイアウト -->
	<div class="mypage-two-col-container">

		<!-- 左カラム (メニュー) -->
		<div class="left-col">
			<div class="mypage-submenu">
				<h6>ショッピング情報</h6>
				<ul>
					<li><a href="/member/orderlist.do">購入履歴</a></li>
					<li><a href="/post/postcart.do">カート</a></li>
					<li><a href="/post//list.do">お気に入り</a></li>
					<li><a href="/member/recentViewPage.do">最近閲覧した商品</a></li>
				</ul>
				<h6>カスタマーサービス</h6>
				<ul>
					<li><a href="/member/faq.do">FAQ</a></li>
				</ul>
			</div>
		</div>

		<!-- 右カラム (メインコンテンツ) -->
		<div class="right-col">
			<section id="orderHistory" class="content-section">
				<h5>注文リスト</h5>
				<div class="order-box">
					<table>
						<thead>
							<tr>
								<th>注文番号</th>
								<th>注文日</th>
								<th>商品情報</th>
								<th>数量</th>
								<th>配送状況</th>
							</tr>
						</thead>

						<tbody>
							<c:choose>
								<c:when test="${not empty recentOrder}">
									<tr>
										<td>${recentOrder.orderid}</td>
										<!-- 注文番号 -->
										<td>${recentOrder.createdAt}</td>
										<!-- 注文日 -->
										<td><img src="${recentOrder.productImage}" alt="商品画像"
											width="100px" height="100px"><br>
											${recentOrder.productName}</td>
										<td>${recentOrder.quantity}</td>
										<!-- 数量 -->
										<td>${recentOrder.deliveryStatus}</td>
										<!-- 配送状況 -->
									</tr>
								</c:when>

								<c:otherwise>
									<tr>
										<td colspan="5">過去3ヶ月以内の購入履歴はありません。</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>

					</table>
				</div>
			</section>
		</div>
	</div>
	<!-- mypage-two-col-container(left-col + right-col) -->
</div>



<%@ include file="../fragments/footer.jsp"%>