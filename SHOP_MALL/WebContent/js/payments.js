// 결제 방법 선택
function selectPaymentMethod(button) {
    // 선택된 결제 방법을 하이라이트
    const buttons = document.querySelectorAll('.payment-btn');
    buttons.forEach(btn => btn.classList.remove('selected'));
    button.classList.add('selected');

    // 선택된 결제 방법을 입력 필드에 설정
    document.getElementById('selectedPaymentMethod').value = button.getAttribute('data-pg');
}

// 주문 규정 체크박스 상태에 따라 오류 메시지 표시
function toggleErrorMessage() {
    const errorMessage = document.getElementById("error-message");
    errorMessage.style.display = document.getElementById("terms").checked ? "none" : "block";
}

// 결제 요청 함수
function requestPayment() {
    const customerName = document.getElementById("customerName").value;
    const contactNumber = document.getElementById("contactNumber").value;
    const email = document.getElementById("email").value;
    const address = document.getElementById("address").value;
    const selectedPaymentMethod = document.getElementById("selectedPaymentMethod").value;
    const totalAmount = document.getElementById("totalAmount").innerText.replace(/[^0-9]/g, ''); // 금액에서 숫자만 추출

    const paymentData = {
        customerName: customerName,
        contactNumber: contactNumber,
        email: email,
        address: address,
        paymentMethod: selectedPaymentMethod,
        totalAmount: totalAmount // 총 결제 금액
    };

    // 포트원 결제 API 요청
    fetch('/your-server-endpoint/payment', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(paymentData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('결제 성공: ' + data.transactionId);
            // 결제 성공 후 추가 처리 (예: 주문 확인 페이지로 이동)
        } else {
            alert('결제 실패: ' + data.error_msg);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('결제 요청 중 오류가 발생했습니다.');
    });
}

// 결제 취소 함수
function cancelPayment() {
    document.getElementById("paymentForm").reset();
    alert("결제가 취소되었습니다.");
}