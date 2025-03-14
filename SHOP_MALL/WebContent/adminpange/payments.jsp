<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>
<link rel="stylesheet" href="/css/payments.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="/js/payments.js" defer></script>

<div class="payment_container" data-product-name="${productName}"
    data-product-price="${productPrice}"
    data-product-quantity="${productQuantity}">
    <h1>주문 / 결제하기</h1>
    <form method="post" onsubmit="return false;">
        <div class="order-summary">
            <h2>장바구니 내역</h2>
            <ul>
                <li>상품 ID: <strong>${productId}</strong></li>
                <li>상품명: <strong id="productName">${productName}</strong></li>
                <li>가격: <strong>${productPrice}원</strong></li>
                <li>수량: <strong>${productQuantity}개</strong></li>
                <li>총 금액: <strong id="totalAmount">${productPrice * productQuantity}원</strong></li>
            </ul>
        </div>

        <div class="user-info-container">
            <%-- 세션에서 유저의 정보 가져오기 --%>
            <p id="userName">이름: ${sessionScope.user.name}</p>
            <p id="userPhoneNumber">전화번호: ${sessionScope.user.phonenumber}</p>
            <p id="userEmail">이메일: ${sessionScope.user.email}</p>
            <p id="userAddress">주소: ${sessionScope.user.address}</p>
        </div>

        <div class="form-group">
            <label>결제 방법 선택:</label>
            <div class="payment-options">
                <button type="button" class="payment-btn selected" data-pg="inicis">이니시스</button>
                <button type="button" class="payment-btn" data-pg="kakaopay">카카오페이</button>
                <button type="button" class="payment-btn" data-pg="tosspay">토스</button>
                <button type="button" class="payment-btn" data-pg="paypal">페이팔</button>
            </div>
            <input type="hidden" id="selectedPaymentMethod" name="pg"
                value="inicis">
        </div>

        <div class="footer">
            <div class="checkbox-group">
                <input type="checkbox" id="terms" name="terms" required> <label
                    for="terms">주문 규정을 확인하였으며, 불편에 대한 조정이 필요한 경우 FanTastic에 대한 제안을
                    응답합니다.</label>
            </div>
            <div id="error-message" class="error-message" style="display: none;">주문
                규정을 확인해야 결제할 수 있습니다.</div>
        </div>

        <div class="button-group">
            <button type="button" class="payment_btn" id="paymentButton"
                onclick="requestPayment()">결제하기</button>
            <button type="button" class="cancel_btn" id="cancelButton">취소</button>
        </div>
    </form>
</div>

<%@ include file="/fragments/footer.jsp"%>