<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/payments.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="/js/payments.js" defer></script>

<section class="payment-section">
	<div class="payment-header">
		<div class="container">
			<h2 class="payment-title">주문/결제하기</h2>
		</div>
	</div>
	<div class="payment-container" data-product-id="${productId}" data-product-name="${productName}" 
								   data-product-price="${productPrice}" data-product-quantity="${productQuantity}">
	    <form method="post" onsubmit="return false;">
	        <div class="payment-order-summary">
	        	<div class="payment-order-header">
	            	<h2 class="payment-order-title">장바구니 내역</h2>
	            </div>
	            <div class="payment-order-info">
		            <ul>
						<li>상품명: <strong>${param.productName}</strong></li>
						<li>가격: <strong>${param.productPrice}원</strong></li>
						<li>수량: <strong>${param.productQuantity}개</strong></li>
						<li>총 금액: <strong id="totalAmount">${productPrice * productQuantity}원</strong></li>
		            </ul>
	            </div>
	        </div>
	
	        <div class="payment-userinfo">
	            <%-- 세션에서 유저의 정보 가져오기 --%>            
	            <p id="userid">아이디: ${sessionScope.user.userid}</p>
	            <p id="userName">이름: ${sessionScope.user.name}</p>
	            <p id="userPhoneNumber">전화번호: ${sessionScope.user.phonenumber}</p>
	            <p id="userEmail">이메일: ${sessionScope.user.email}</p>
	            <p id="userAddress">주소: ${sessionScope.user.address}</p>
	        </div>
	
	        <div class="payment-form-group">
	            <label>결제 방법 선택: </label>
	            <div class="payment-options">
	                <button type="button" class="payment-btn selected" data-pg="inicis">이니시스</button>
	                <button type="button" class="payment-btn" data-pg="kakaopay">카카오페이</button>
	                <button type="button" class="payment-btn" data-pg="tosspay">토스</button>
	                <button type="button" class="payment-btn" data-pg="paypal">페이팔</button>
	            </div>
	            <input type="hidden" id="selectedPaymentMethod" name="pg" value="inicis">
	        </div>
	
	        <div class="payment-footer">
	            <div class="payment-checkbox-group">
	                <input type="checkbox" id="terms" name="terms" required>
	                <label for="terms">주문 규정을 확인하였으며, 불편에 대한 조정이 필요한 경우 FanTastic에 대한 제안을 응답합니다.</label>
	            </div>
	            <div id="error-message" class="error-message" style="display: none;">주문 규정을 확인해야 결제할 수 있습니다.</div>
	            
		        <div class="payment-button-group">
		            <button type="button" class="payment-btn" id="paymentButton" onclick="requestPayment()">결제하기</button>
		            <button type="button" class="cancel-btn" id="cancelButton">취소</button>
		        </div>
	        </div>
	    </form>
	</div>
</section>

<%@ include file="/fragments/footer.jsp"%>