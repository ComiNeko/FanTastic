<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="FI-sign">
    <h2 class="FI-high-T">아이디 찾기</h2>
    
    <!-- 이메일 입력 및 인증 코드 요청 -->
    <div id="email-form">
        <label for="email">이메일:</label>
        <div class="email-container">
            <input type="text" id="emailPrefix" name="emailPrefix" placeholder="이메일 아이디" required>
            <span>@</span>
            <select id="emailDomain" name="emailDomain">
                <option value="" selected>선택해주세요</option>
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="daum.net">daum.net</option>
                <option value="icloud.com">icloud.com</option>
                <option value="custom">직접입력</option>
            </select>
            <input type="text" id="customEmailDomain" name="customEmailDomain" placeholder="도메인 입력" style="display: none;">
        </div>
        <button type="button" id="requestAuthCode">인증코드 받기</button>
        <span id="email-error" class="error-message"></span>
    </div>

    <!-- 인증 코드 입력 -->
    <div id="auth-form" style="display: none;">
        <label>인증 코드:</label>
        <input type="text" id="authCode" required>
        <button type="button" id="verifyCode">인증하기</button>
        <span id="auth-error" class="error-message"></span>
    </div>

    <!-- 아이디 결과 -->
    <div id="id-result" style="display: none;">
        <h3>아이디:</h3>
        <p id="maskedUserId"></p>
    </div>
</div>

<script>
$(document).ready(function () {
    // 이메일 입력 필드 조합 함수
    function getFullEmail() {
        var emailPrefix = $("#emailPrefix").val().trim();
        var emailDomain = $("#emailDomain").val();
        var customEmailDomain = $("#customEmailDomain").val().trim();

        if (!emailPrefix) {
            $("#email-error").text("이메일 아이디를 입력해주세요.");
            return null;
        }

        if (emailDomain === "custom") {
            if (!customEmailDomain) {
                $("#email-error").text("이메일 도메인을 입력해주세요.");
                return null;
            }
            return emailPrefix + "@" + customEmailDomain;
        } else {
            if (!emailDomain) {
                $("#email-error").text("이메일 도메인을 선택해주세요.");
                return null;
            }
            return emailPrefix + "@" + emailDomain;
        }
    }

    // 이메일 도메인 선택 시 직접 입력 필드 활성화/비활성화
    $("#emailDomain").change(function() {
        if ($(this).val() === "custom") {
            $("#customEmailDomain").show().prop("required", true).prop("disabled", false);
        } else {
            $("#customEmailDomain").hide().prop("required", false).prop("disabled", true).val("");
        }
    });

    // 이메일 인증 요청 (아이디 찾기)
    $("#requestAuthCode").click(function () {
        // 에러 메시지 초기화
        $("#email-error").text("");
        var email = getFullEmail();
        console.log("DEBUG - final email:", email);
        if (!email) return;

        $.post("/member/findIdProcess.do", { email: email }, function (response) {
            var trimmedResponse = response.trim();
            // 성공 메시지인 경우에만 인증 단계로 넘어감
            if (trimmedResponse === "인증 코드가 이메일로 전송되었습니다.") {
                alert("인증 코드가 이메일로 전송되었습니다.");
                $("#email-form").hide();
                $("#auth-form").show();
            } else {
                // 그 외는 모두 에러 메시지로 처리
                $("#email-error").text(trimmedResponse);
            }
        });
    });

    // 인증 코드 확인
    $("#verifyCode").click(function () {
        $("#auth-error").text("");
        var authCode = $("#authCode").val().trim();
        if (!authCode) {
            $("#auth-error").text("인증 코드를 입력해주세요.");
            return;
        }

        $.post("/member/verifyEmail.do", { authCode: authCode }, function (response) {
            var trimmedResponse = response.trim();
            if (trimmedResponse.startsWith("success:")) {
                var userId = trimmedResponse.split(":")[1];
                $("#maskedUserId").text(userId);
                $("#auth-form").hide();
                $("#id-result").show();
            } else {
                $("#auth-error").text(trimmedResponse);
            }
        });
    });
});
</script>



<%@ include file="/fragments/footer.jsp"%>