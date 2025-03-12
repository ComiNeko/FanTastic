// 결제 방법 선택
function selectPaymentMethod(button) {
    const buttons = document.querySelectorAll('.payment-btn');
    buttons.forEach(btn => btn.classList.remove('selected'));
    button.classList.add('selected');
    document.getElementById('selectedPaymentMethod').value = button.getAttribute('data-pg');
}

document.addEventListener('DOMContentLoaded', function() {
    function validateForm() {
        const customerName = document.getElementById('customerName');
        const contactNumber = document.getElementById('contactNumber');
        const email = document.getElementById('email');
        const termsCheckbox = document.getElementById('terms');
        const errorMessage = document.getElementById('error-message');

        // 각 필드의 유효성 검사
        if (!customerName.value) {
            alert("입금자명을 입력해 주세요.");
            customerName.focus();
            return false; // 유효성 검사 실패
        }

        if (!contactNumber.value) {
            alert("연락처를 입력해 주세요.");
            contactNumber.focus();
            return false; // 유효성 검사 실패
        }

        if (!email.value) {
            alert("이메일을 입력해 주세요.");
            email.focus();
            return false; // 유효성 검사 실패
        }

        if (!termsCheckbox.checked) {
            errorMessage.style.display = 'block'; // 체크박스 미체크 시 경고 메시지 표시
            return false; // 유효성 검사 실패
        } else {
            errorMessage.style.display = 'none'; // 체크박스 체크 시 경고 메시지 숨김
        }

        return true; // 모든 검사를 통과한 경우
    }

    function requestPayment() {
        if (!validateForm()) return; // 유효성 검사 통과하지 않으면 종료

        const IMP = window.IMP; // 아임포트 객체
        IMP.init("imp12583230"); // 아임포트에서 발급받은 키

        // 선택된 결제 방법 가져오기
        const selectedPG = document.getElementById('selectedPaymentMethod').value; // 수정: hidden input에서 값 가져오기

        IMP.request_pay({
            pg: selectedPG, // 선택된 PG사
            pay_method: 'card', // 결제 방법 (카드 결제)
            name: 'Toganawa', // 상품명
            merchant_uid: "ORD20250218-000002", // 주문 고유 ID
            amount: 1530000, // 결제 금액
            buyer_name: document.getElementById('customerName').value, // 구매자 이름
            buyer_tel: document.getElementById('contactNumber').value, // 구매자 연락처
            buyer_email: document.getElementById('email').value, // 구매자 이메일
        }, function (response) {
            if (response.success) {
                // 성공 결제 처리
                alert('결제 성공: ' + response.imp_uid);
                // 여기서 결제 정보를 서버에 저장하는 로직 추가
            } else {
                // 실패 결제 처리
                alert('결제 실패: ' + response.error_msg);
            }
        });
    }

    // 결제하기 버튼 클릭 시 요청 함수 호출
    document.querySelector('button[onclick="requestPayment()"]').addEventListener('click', requestPayment);
});