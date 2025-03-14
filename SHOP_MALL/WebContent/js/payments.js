document.addEventListener('DOMContentLoaded', function() {
    console.log("DOMContentLoaded event fired!");

    // 아임포트 SDK 로드 완료 후 초기화
    if (typeof IMP !== 'undefined') {
        IMP.init("imp12583230"); // 가맹점 식별코드로 변경
    } else {
        console.error("아임포트 SDK가 로드되지 않았습니다.");
        return;
    }

    // 기본 결제 방법 선택 (이니시스)
    const defaultButton = document.querySelector('.payment-btn[data-pg="inicis"]');
    if (defaultButton) {
        selectPaymentMethod(defaultButton);
    }

    // 결제 방법 선택 버튼에 이벤트 리스너 등록
    document.querySelectorAll('.payment-btn').forEach(button => {
        button.addEventListener('click', function() {
            selectPaymentMethod(this);
        });
    });

    // 체크박스 이벤트 리스너 등록
    const termsCheckbox = document.getElementById('terms');
    const errorMessage = document.getElementById('error-message');

    if (termsCheckbox) {
        termsCheckbox.addEventListener('change', function() {
            errorMessage.style.display = this.checked ? 'none' : 'block';
        });
    } else {
        console.error("termsCheckbox element not found!");
    }

    // 결제하기 버튼 이벤트 리스너 등록
    const paymentButton = document.getElementById('paymentButton');
    if (paymentButton) {
        paymentButton.addEventListener('click', function() {
            requestPayment();
        });
    }

    // 취소 버튼 이벤트 리스너 등록
    const cancelButton = document.getElementById('cancelButton');
    if (cancelButton) {
        cancelButton.addEventListener('click', function() {
            if (confirm('결제를 취소하시겠습니까?')) {
                window.location.href = "/cart.jsp"; // 장바구니 페이지로 이동
            }
        });
    }
});

// 결제 방법 선택
function selectPaymentMethod(button) {
    const buttons = document.querySelectorAll('.payment-btn');
    buttons.forEach(btn => btn.classList.remove('selected'));
    button.classList.add('selected');
    document.getElementById('selectedPaymentMethod').value = button.getAttribute('data-pg');
}

// 폼 유효성 검사
function validateForm() {
    const termsCheckbox = document.getElementById('terms');
    const errorMessage = document.getElementById('error-message');

    if (!termsCheckbox) {
        console.error("termsCheckbox 요소가 존재하지 않습니다.");
        errorMessage.style.display = 'block';
        errorMessage.innerText = "약관 동의 체크박스를 찾을 수 없습니다.";
        return false;
    }

    if (!termsCheckbox.checked) {
        errorMessage.style.display = 'block';
        errorMessage.innerText = "주문 규정을 확인해야 결제할 수 있습니다.";
        return false;
    }

    errorMessage.style.display = 'none';
    return true;
}

// 결제 요청
function requestPayment() {
    if (!validateForm()) return; // 유효성 검사 통과하지 않으면 종료

    const IMP = window.IMP; // 아임포트 객체
    const selectedPG = document.getElementById('selectedPaymentMethod').value;

    // PG사별 결제 방법 설정
    const paymentMethods = {
        inicis: 'card',
        kakaopay: 'kakaopay',
        tosspay: 'tosspay',
        paypal: 'paypal'
    };

    // 선택된 PG사가 유효한지 확인
    if (!paymentMethods[selectedPG]) {
        alert("유효하지 않은 결제 방법입니다.");
        return;
    }

    // 결제 요청 데이터
    IMP.request_pay({
        pg: selectedPG,
        pay_method: paymentMethods[selectedPG],
        name: document.getElementById('productName').innerText,
        merchant_uid: "ORD" + new Date().getTime(),
        amount: document.getElementById('totalAmount').innerText.replace('원', '').replace(/,/g, ''),
        buyer_name: document.getElementById("userName").textContent.split(": ")[1],
        buyer_tel: document.getElementById("userPhoneNumber").textContent.split(": ")[1],
        buyer_email: document.getElementById("userEmail").textContent.split(": ")[1],
        buyer_address: document.getElementById("userAddress").textContent.split(": ")[1]
    }, function(response) {
        if (response.success) {
            alert('결제가 완료되었습니다.');
            sendPaymentDataToServer(response, selectedPG); // 서버에 결제 정보 전송
        } else {
            alert('결제 실패: ' + response.error_msg);
            if (confirm('다시 시도하시겠습니까?')) {
                requestPayment(); // 재시도
            }
        }
    });
}

// 서버에 결제 정보 전송
function sendPaymentDataToServer(response, selectedPG) {
    const paymentContainer = document.querySelector('.payment_container');
    const productId = paymentContainer.getAttribute('data-product-id'); // productId 추가
    const productQuantity = parseInt(paymentContainer.getAttribute('data-product-quantity')) || 1; // productQuantity 추가

    const paymentData = {	
        imp_uid: response.imp_uid, // 아임포트 거래 고유 ID
        merchant_uid: response.merchant_uid, // 주문 고유 ID
        pay_method: selectedPG, // 결제 방법
        productId: productId, // 상품 ID
		userid: document.getElementById("userid").textContent.split(": ")[1],
        productQuantity: productQuantity, // 상품 수량
        productName: document.getElementById('productName').innerText, // 상품명
        amount: document.getElementById('totalAmount').innerText.replace('원', '').replace(/,/g, ''), // 결제 금액
        buyer_name: document.getElementById("userName").textContent.split(": ")[1],
        buyer_tel: document.getElementById("userPhoneNumber").textContent.split(": ")[1],
        buyer_email: document.getElementById("userEmail").textContent.split(": ")[1],
        buyer_address: document.getElementById("userAddress").textContent.split(": ")[1]
    };

	console.log("js파일에서 콘솔찍는중: ", paymentData);
	console.log("JSON 데이터 문자열:", JSON.stringify(paymentData, null, 2));	

    // AJAX 요청으로 서버에 결제 정보 전송
    $.ajax({
        type: "POST",
        url: "/payment/save.do", // 결제 정보를 저장할 서버 URL
        contentType: "application/json",
        data: JSON.stringify(paymentData),
        success: function(response) {
            if (response.success) {
                alert('결제 정보가 저장되었습니다.');
                window.location.href = "/"; // 성공 페이지로 이동
            } else {
                alert('결제 정보 저장 실패: ' + response.message);
            }
        },
        error: function(error) {
            console.error("결제 정보 저장 실패:", error);
            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}
