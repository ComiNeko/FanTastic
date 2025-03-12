<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/payments.css">
<script src="js/jquery-3.7.1.min.js"></script>

<div class="payment_container">
	<h1>주문 / 결제하기</h1>
	<form method="post" onsubmit="return false;">
		<div class="form-group">
			<label for="customerName">주문자</label> <input type="text"
				id="customerName" name="customerName"
				placeholder="송금하실 분의 이름을 입력해 주세요." required>
		</div>
		<div class="form-group">
			<label for="contactNumber">연락처</label> <input type="text"
				id="contactNumber" name="contactNumber"
				placeholder="연락 가능한 번호를 입력해 주세요." required>
		</div>
		<div class="form-group">
			<label for="email">이메일</label> <input type="email" id="email"
				name="email" placeholder="이메일을 입력해 주세요." required>
		</div>
		
		<div class="form-group">
			<label for="address">주소</label> <input type="text" id="address"
				name="address" placeholder="주소를을 입력해 주세요." required>
		</div>

		<div class="order-summary">
			<div class="left-column">
				<h2>주문 내역</h2>
				<div class="order-summary-item">
					<span>제품명</span> <span>제품</span>
				</div>
			</div>

			<div class="order-summary-item">
				<span>제품</span> <span>12,000원</span>
			</div>
			
			<div class="order-summary-item total" id="totalAmount">
				<span>합계</span> <span>12,000원</span>
			</div>
		</div>

		<div class="form-group">
			<label>결제 방법 선택:</label>
			<div class="payment-options">
				<button type="button" class="payment-btn selected" data-pg="inicis"
					onclick="selectPaymentMethod(this)">이니시스</button>
				<button type="button" class="payment-btn" data-pg="kakaopay"
					onclick="selectPaymentMethod(this)">카카오페이</button>
				<button type="button" class="payment-btn" data-pg="tosspay"
					onclick="selectPaymentMethod(this)">토스</button>
				<button type="button" class="payment-btn" data-pg="paypal"
					onclick="selectPaymentMethod(this)">페이팔</button>
			</div>
			<input type="hidden" id="selectedPaymentMethod" name="pg"
				value="inicis">
			<!-- 기본값 설정 -->
		</div>

		<div class="footer">
			<div class="checkbox-group">
				<input type="checkbox" id="terms" name="terms" required
					onchange="toggleErrorMessage()"> <label for="terms">주문
					규정을 확인하였으며, 불편에 대한 조정이 필요한 경우 판타스틱에 대한 제안을 응답합니다.</label>
			</div>
			<div id="error-message" class="error-message" style="display: none;">주문
				규정을 확인해야 결제할 수 있습니다.</div>
		</div>

		<div class="button-group">
			<button type="button" class="payment_btn" id="paymentButton"
				onclick="requestPayment()">결제하기</button>
			<button type="button" class="cancel_btn" onclick="cancelPayment()">취소</button>
		</div>
	</form>
</div>

<%@ include file="/fragments/footer.jsp"%>