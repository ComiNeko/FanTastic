<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
<%@ include file="/fragments/header.jsp"%>
<link rel="stylesheet" href="/css/payments.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="/js/payments.js" defer></script>

<script>
    // 결제 방법 선택
    function selectPaymentMethod(button) {
        const buttons = document.querySelectorAll('.payment-btn');
        buttons.forEach(btn => {
            btn.classList.remove('selected');
            btn.style.backgroundColor = '';
            btn.style.color = '';
        });
        button.classList.add('selected');
        button.style.backgroundColor = '#007bff';
        button.style.color = 'white';
        const selectedPG = button.getAttribute('data-pg');
        document.getElementById('selectedPaymentMethod').value = selectedPG;
    }

    // 결제 요청
    function requestPayment() {
        const customerName = document.getElementById('customerName').value;
        const contactNumber = document.getElementById('contactNumber').value;
        const email = document.getElementById('email').value;
        const request = document.getElementById('request').value;
        const selectedPG = document.getElementById('selectedPaymentMethod').value;

        // 결제 요청을 위한 데이터 구조
        const paymentData = {
            productId: "${productId}", // 서버에서 전달된 상품 ID
            productName: "${productName}", // 서버에서 전달된 상품 이름
            productPrice: "${productPrice}", // 서버에서 전달된 상품 가격
            customerName: customerName,
            contactNumber: contactNumber,
            email: email,
            request: request,
            pg: selectedPG
        };

        // AJAX 요청으로 결제 처리
        $.ajax({
            type: "POST",
            url: "/payment/process", // 결제 처리 URL
            contentType: "application/json",
            data: JSON.stringify(paymentData),
            success: function(response) {
                // 결제 성공 시 처리
                alert('결제가 완료되었습니다.');
                // 결제 성공 후 리다이렉션 또는 다른 처리
                window.location.href = "/paymentSuccess.jsp"; // 성공 페이지로 이동
            },
            error: function(xhr, status, error) {
                console.error("결제 요청 에러:", error);
                alert("결제 요청 중 오류 발생.");
            }
        });
    }

    // 결제 취소
    function cancelPayment() {
        // 결제 취소 시 처리
        window.location.href = "/cart.jsp"; // 장바구니 페이지로 이동
    }

    // 페이지 로드 시 총 금액 계산
    document.addEventListener('DOMContentLoaded', function() {
        const productPrice = parseInt("${productPrice}"); // 서버에서 전달된 상품 가격
        const productQuantity = parseInt("${productQuantity}"); // 서버에서 전달된 상품 수량
        const totalAmount = productPrice * productQuantity; // 총 금액 계산
        document.getElementById('totalAmount').innerHTML = `${totalAmount}원`; // 총 금액 표시
    });
</script>

<div class="payment_container">
	<h1>주문 / 결제하기</h1>
	<form method="post" onsubmit="return false;">
		<div class="order-summary">
			<h2>장바구니 내역</h2>
			<ul>
				<li id="productId">상품 ID: <strong>${productId}</strong></li>
				<li id="productName">상품명: <strong>${productName}</strong></li>
				<li id="productPrice">가격: <strong>${productPrice}원</strong></li>
				<li id="productQuantity">수량: <strong>${productQuantity}개</strong></li>
				<li id="totalAmount">총 금액: <strong></strong></li>
				<!-- 총 금액 표시 -->
			</ul>
		</div>

		<div class="form-group">
			<label for="customerName">입금자명</label> <input type="text"
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
			<label for="request">요청사항</label>
			<textarea id="request" name="request" rows="4"
				placeholder="특별한 요청사항이 있으시면 입력해 주세요."></textarea>
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
		</div>

		<div class="footer">
			<div class="checkbox-group">
				<input type="checkbox" id="terms" name="terms" required
					onchange="toggleErrorMessage()"> <label for="terms">주문
					규정을 확인하였으며, 불편에 대한 조정이 필요한 경우 아트믹에 대한 제안을 응답합니다.</label>
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