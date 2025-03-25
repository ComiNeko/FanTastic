<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/payments.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="/js/payments.js?v=123" defer></script>

<section class="payment-section">
	<div class="payment-header">
		<div class="container">
			<h2 class="payment-title">注文/お会計</h2>
		</div>
	</div>
	<div class="payment-container" data-product-id="${productId}" data-product-name="${productName}" 
								   data-product-price="${productPrice}" data-product-quantity="${productQuantity}">
	    <form method="post" onsubmit="return false;">
	        <div class="payment-order-summary">
	        	<div class="payment-order-header">
	            	<h2 class="payment-order-title">カートの内容</h2>
	            </div>
	            <div class="payment-order-info">
		            <ul>
						<li>商品名: <strong id="productName">${productName}</strong></li>
                        <li>価格: <strong><fmt:formatNumber value="${productPrice * 0.1}" type="number" pattern="#,##0" />円</strong></li>
                        <li>数量: <strong>${productQuantity}個</strong></li>
                        <li>合計金額: <strong id="totalAmount"><fmt:formatNumber value="${productPrice * productQuantity * 0.1}" type="number" pattern="#,##0" />円</strong></li>
		            </ul>
	            </div>
	        </div>
	
	        <div class="payment-userinfo">
	            <%-- 세션에서 유저의 정보 가져오기 --%>            
                <p id="userid">ユーザーID: ${sessionScope.user.userid}</p>
                <p id="userName">名前: ${sessionScope.user.name}</p>
                <p id="userPhoneNumber">電話番号: ${sessionScope.user.phonenumber}</p>
                <p id="userEmail">メールアドレス: ${sessionScope.user.email}</p>
                <p id="userAddress">住所: ${sessionScope.user.address}</p>
	        </div>

	        <div class="payment-form-group">
	            <label>お会計方法の選択: </label>
	            <div class="payment-options">
	                <button type="button" class="payment-btn selected" data-pg="inicis">イニシス</button>
	                <button type="button" class="payment-btn" data-pg="kakaopay">カカオペイ</button>
	                <button type="button" class="payment-btn" data-pg="tosspay">トス</button>
	                <button type="button" class="payment-btn" data-pg="paypal">ペイパル</button>
	            </div>
				<input type="hidden" id="selectedPaymentMethod" name="pg" value="inicis">
			</div>
	
			<div class="payment-footer">
	            <div class="payment-checkbox-group">
					<input type="checkbox" id="terms" name="terms" required>
					<label for="terms">注文規約を確認し、不都合がある場合はFanTasticに提案を行います。</label>
				</div>
				<div id="error-message" class="error-message" style="display: none;">注文規約を確認しないとお会計できません。</div>
				
				<div class="payment-button-group">
					<button type="button" class="payment_btn" id="paymentButton" onclick="requestPayment()">お会計する</button>
					<button type="button" class="cancel_btn" id="cancelButton">キャンセル</button>
				</div>
			</div>
		</form>
	</div>
</section>
<%@ include file="/fragments/footer.jsp"%>